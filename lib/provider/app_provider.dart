import 'package:money_management/provider/account_provider.dart';
import 'package:money_management/provider/category_provider.dart';
import 'package:money_management/provider/disposable_provider.dart';
import 'package:flutter/material.dart';
import 'package:money_management/provider/expend_provider.dart';
import 'package:provider/provider.dart';

class AppProviders {
  static List<DisposableProvider> getDisposableProviders(BuildContext context) {
    return [
      Provider.of<ExpendProvider>(context, listen: false),
      Provider.of<AccountProvider>(context, listen: false),
      Provider.of<CategoryProvider>(context, listen: false),
    ];
  }

  static void disposeAllDisposableProviders(BuildContext context) {
    getDisposableProviders(context).forEach((disposableProvider) {
      disposableProvider.disposeValues();
    });
  }
}
