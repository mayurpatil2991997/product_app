import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionPage {
  /// Show Option
  Future<void> showOption(BuildContext context) async {
    showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _dialogContext = context;
          return Loading();
        }
    );
  }

  /// BuildContext
  BuildContext _dialogContext;

  void hideOption() {
    if (_dialogContext != null) {
      if (Navigator.canPop(_dialogContext)) {
        Navigator.pop(_dialogContext);
      }
      _dialogContext = null;
    }
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
