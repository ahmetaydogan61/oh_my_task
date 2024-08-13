import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Deption {
  static final GetIt _getIt = GetIt.instance;

  static T get<T extends Object>() {
    return _getIt.get();
  }

  static singleton<T extends Object>(T instance) {
    _getIt.registerSingleton(instance);
  }
}

T get<T extends Object>() {
  return Deption.get<T>();
}

singleton<T extends Object>(T instance) {
  Deption.singleton(instance);
}

T getViewModel<T extends ChangeNotifier>() {
  return Deption.get<T>();
}
