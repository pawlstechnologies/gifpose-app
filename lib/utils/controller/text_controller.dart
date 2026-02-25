import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';


class CustomTextController {
  static addText(
      {required TextEditingController controller, required String value}) {
    controller.text = controller.text + value;
  }

  static deleteText({required TextEditingController controller}) {
    controller.text = controller.text.substring(0, controller.text.length - 1);
  }

  static double amountControllerFormatter(TextEditingController controller) {
    return (double.tryParse(
            controller.text.replaceAll('\$', '').replaceAll(",", "")) ??
        0);
  }

  static double calculateRate(
      {required double rate,
      required TextEditingController controller,
      required TextEditingController setController}) {
    var currentAmount = amountControllerFormatter(controller);

    double calculatedRate = currentAmount / rate;
    setController.text = calculatedRate.toCurrencyString();
    return calculatedRate;
  }
}
