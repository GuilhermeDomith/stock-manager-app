
import 'package:flutter/material.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).primaryColorLight
        )
    );
  }
}

