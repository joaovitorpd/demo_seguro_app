import 'package:flutter/foundation.dart';

void safePrint(Object? message) {
  if (kDebugMode) {
    debugPrint(message.toString());
  }
}
