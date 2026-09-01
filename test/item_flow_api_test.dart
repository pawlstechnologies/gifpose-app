import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/screens/donor_flow/viewmodels/donor_viewmodel.dart';
import 'package:giftpose/screens/donor_flow/views/donor_post_item.dart';
import 'package:giftpose/screens/main_view/viewmodels/base_viewmodel.dart';
import 'package:giftpose/screens/requester_flow/models/analyzeimage_response.dart';
import 'package:giftpose/screens/requester_flow/models/item_api_models.dart';
import 'package:giftpose/screens/requester_flow/repo/requester_repo.dart';
import 'package:giftpose/screens/requester_flow/viewmodels/requester_viewmodel.dart';
import 'package:giftpose/screens/requester_flow/views/post_an_item.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/localization_provider.dart';
import 'package:provider/provider.dart';

void main() {
  group('item API models', () {
    test('serializes the documented request contract', () {
      const request = ItemMutationRequest(
        name: 'Invisible Deodorant',
        description: 'Description',
        imageUrls: ['https://example.com/item.jpg'],
        type: 'request',
        pickup: 'Personal Delivery',
        postCode: 'CW1 3AZ',
        country: 'GB',
        suggestedCategoryId: 'category-id',
        suggestedSubcategoryId: 'subcategory-id',
        suggestedContentId: 'content-id',
      );

      expect(request.toJson(), {
        'name': 'Invisible Deodorant',
        'description': 'Description',
        'imageUrls': ['https://example.com/item.jpg'],
        'type': 'request',
        'pickup': 'Personal Delivery',
        'postCode': 'CW1 3AZ',
        'country': 'GB',
        'categoryId': null,
        'subcategoryId': null,
        'contentId': null,
        'suggestedCategoryId': 'category-id',
        'suggestedSubcategoryId': 'subcategory-id',
        'suggestedContentId': 'content-id',
      });
    });

    test('accepts both status and success response flags', () {
      final created = ItemMutationResponse.fromJson({
        'status': true,
        'message': 'created',
        'data': {'_id': 'created-id'},
      });
      final updated = ItemMutationResponse.fromJson({
        'success': true,
        'message': 'updated',
        'data': {'_id': 'updated-id'},
      });

      expect(created.success, isTrue);
      expect(created.itemId, 'created-id');
      expect(updated.success, isTrue);
      expect(updated.itemId, 'updated-id');
    });
  });

  group('requester flow', () {
    test('loads server pickup options and applies AI analysis', () async {
      final repo = _FakeRequesterRepo();
      final vm = RequesterViewmodel(requesterRepo: repo);
      addTearDown(vm.dispose);
      await _flushMicrotasks();

      expect(vm.pickupOptions.map((option) => option.name), [
        'Pickup',
        'Personal Delivery',
        'Agent Delivery (payment upon delivery)',
      ]);
      expect(vm.selectedPickupOption, 'Pickup');

      await vm.analyseImages([File('/tmp/reference.jpg')]);
      expect(vm.itemNameCtrl.text, 'Nivea Spray');
      expect(vm.itemDescriptionCtrl.text, '72-hour protection');
      expect(vm.imageUrls, ['https://example.com/uploaded.jpg']);
      expect(vm.categoryId, isNull);
      expect(vm.suggestedCategoryId, 'category-id');
      expect(vm.suggestedSubcategoryId, 'subcategory-id');
      expect(vm.suggestedContentId, 'content-id');
    });

    test('posts and then updates a requested item', () async {
      final repo = _FakeRequesterRepo();
      final vm = RequesterViewmodel(requesterRepo: repo);
      addTearDown(vm.dispose);
      await _flushMicrotasks();
      await vm.analyseImages([File('/tmp/reference.jpg')]);
      vm.locationCtrl.text = 'CW1 3AZ';
      vm.selectPickupOption('Personal Delivery');

      expect(await vm.submit(), isTrue);
      expect(vm.itemId, 'request-id');
      expect(repo.lastRequest?.type, 'request');
      expect(repo.lastRequest?.pickup, 'Personal Delivery');
      expect(repo.lastRequest?.country, 'GB');

      vm.itemNameCtrl.text = 'Updated Nivea Spray';
      expect(await vm.submit(isEditing: true), isTrue);
      expect(repo.updatedId, 'request-id');
      expect(repo.lastRequest?.name, 'Updated Nivea Spray');
    });

    test('does not call the API when required values are missing', () async {
      final repo = _FakeRequesterRepo();
      final vm = RequesterViewmodel(requesterRepo: repo);
      addTearDown(vm.dispose);
      await _flushMicrotasks();

      expect(await vm.submit(), isFalse);
      expect(repo.postRequestCalls, 0);
      expect(vm.errorMessage, contains('complete all fields'));
    });
  });

  group('donor flow', () {
    test('uses analysis result and posts a donated item', () async {
      final repo = _FakeRequesterRepo();
      final vm = DonorViewmodel(requesterRepo: repo);
      addTearDown(vm.dispose);
      await _flushMicrotasks();

      vm.selectedImage = File('/tmp/donation.jpg');
      final data = (await repo.analyseImage(files: [vm.selectedImage!])).data;
      vm.itemNameController.text = data.name;
      vm.descriptionController.text = data.description;
      vm.imageUrls = data.images;
      vm.suggestedCategoryId = data.category.id;
      vm.suggestedSubcategoryId = data.category.subcategories!.first.id;
      vm.suggestedContentId =
          data.category.subcategories!.first.contents.first.id;
      vm.setLocation('CW1 3AZ');

      expect(await vm.submit(), isTrue);
      expect(vm.itemId, 'offer-id');
      expect(repo.postItemCalls, 1);
      expect(repo.lastRequest?.type, isNull);
      expect(repo.lastRequest?.postCode, 'CW1 3AZ');
    });

    test(
      'posts an offer against a requested item with pickup choice',
      () async {
        final repo = _FakeRequesterRepo();
        final vm = DonorViewmodel(requesterRepo: repo);
        addTearDown(vm.dispose);
        await _flushMicrotasks();
        vm.itemNameController.text = 'Nivea Spray';
        vm.descriptionController.text = '72-hour protection';
        vm.imageUrls = ['https://example.com/uploaded.jpg'];
        vm.setLocation('CW1 3AZ');
        vm.selectPickupOption('Agent Delivery (payment upon delivery)');

        expect(await vm.submit(offeringRequestedItem: true), isTrue);
        expect(repo.postRequestCalls, 1);
        expect(repo.lastRequest?.type, 'offer');
        expect(
          repo.lastRequest?.pickup,
          'Agent Delivery (payment upon delivery)',
        );
      },
    );
  });

  group('user journeys', () {
    testWidgets('requester selects pickup and posts through the UI', (
      tester,
    ) async {
      final repo = _FakeRequesterRepo();
      final vm = RequesterViewmodel(requesterRepo: repo);
      addTearDown(vm.dispose);
      await vm.analyseImages([File('/tmp/reference.jpg')]);

      await tester.pumpWidget(
        _testApp(
          viewmodel: vm,
          home: const PostAnItemScreen(),
          successRoute: AppRoutes.requestPosted,
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byWidgetPredicate(
          (widget) =>
              widget is TextField && widget.controller == vm.locationCtrl,
        ),
        'CW1 3AZ',
      );
      await tester.ensureVisible(find.text('Personal Delivery'));
      await tester.tap(find.text('Personal Delivery'));
      await tester.ensureVisible(find.text('Post'));
      await tester.tap(find.text('Post'));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('flow-success')), findsOneWidget);
      expect(repo.postRequestCalls, 1);
      expect(repo.lastRequest?.pickup, 'Personal Delivery');
    });

    testWidgets('donor confirms a post through the review UI', (tester) async {
      final repo = _FakeRequesterRepo();
      final vm = DonorViewmodel(requesterRepo: repo)
        ..itemNameController.text = 'Nivea Spray'
        ..descriptionController.text = '72-hour protection'
        ..imageUrls = ['https://example.com/uploaded.jpg']
        ..setLocation('CW1 3AZ')
        ..postStep = DonorPostStep.review;
      addTearDown(vm.dispose);

      await tester.pumpWidget(
        _testApp(
          viewmodel: vm,
          home: const DonorPostItemScreen(),
          successRoute: AppRoutes.donorPostedSuccess,
        ),
      );
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Confirm'));
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('flow-success')), findsOneWidget);
      expect(repo.postItemCalls, 1);
      expect(repo.lastRequest?.postCode, 'CW1 3AZ');
    });
  });
}

Widget _testApp<T extends ChangeNotifier>({
  required T viewmodel,
  required Widget home,
  required String successRoute,
}) {
  return ScreenUtilInit(
    designSize: const Size(375, 874),
    builder: (context, child) => MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseViewmodel>(
          create: (_) => _TestBaseViewmodel(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider(),
        ),
        ChangeNotifierProvider<T>.value(value: viewmodel),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: home,
        routes: {
          successRoute: (_) =>
              const Scaffold(key: Key('flow-success'), body: Text('Success')),
        },
      ),
    ),
  );
}

class _TestBaseViewmodel extends BaseViewmodel {
  @override
  Future<void> getFcmToken() async {}
}

Future<void> _flushMicrotasks() => Future<void>.delayed(Duration.zero);

class _FakeRequesterRepo implements RequesterRepo {
  int postItemCalls = 0;
  int postRequestCalls = 0;
  String? updatedId;
  ItemMutationRequest? lastRequest;

  @override
  Future<AnalyseImageResponse> analyseImage({required List<File> files}) async {
    return AnalyseImageResponse(
      message: 'AI analysis complete',
      data: Data(
        name: 'Nivea Spray',
        description: '72-hour protection',
        category: Category(
          id: 'category-id',
          name: 'Personal Care',
          slug: 'personal-care',
          status: 'Active',
          subcategories: [
            Subcategory(
              id: 'subcategory-id',
              name: 'Deodorants',
              categoryId: 'category-id',
              status: 'Active',
              slug: 'deodorants',
              contents: [
                Category(
                  id: 'content-id',
                  name: 'Spray',
                  slug: 'spray',
                  status: 'Active',
                ),
              ],
            ),
          ],
        ),
        suggestedCategory: null,
        images: ['https://example.com/uploaded.jpg'],
      ),
    );
  }

  @override
  Future<List<PickupOption>> getPickupOptions() async => const [
    PickupOption('Pickup'),
    PickupOption('Personal Delivery'),
    PickupOption('Agent Delivery (payment upon delivery)'),
  ];

  @override
  Future<ItemMutationResponse> postItem(ItemMutationRequest request) async {
    postItemCalls++;
    lastRequest = request;
    return const ItemMutationResponse(
      success: true,
      message: 'Item Posted Successfully',
      data: {'_id': 'offer-id'},
    );
  }

  @override
  Future<ItemMutationResponse> postRequestedItem(
    ItemMutationRequest request,
  ) async {
    postRequestCalls++;
    lastRequest = request;
    return const ItemMutationResponse(
      success: true,
      message: 'Item Requested Successfully',
      data: {'_id': 'request-id'},
    );
  }

  @override
  Future<ItemMutationResponse> updateItem({
    required String id,
    required ItemMutationRequest request,
  }) async {
    updatedId = id;
    lastRequest = request;
    return ItemMutationResponse(
      success: true,
      message: 'Item updated successfully',
      data: {'_id': id},
    );
  }
}
