/*
-- طريقة تسجيله في ال main.dart:
void main() {
  // بنسجل ال BlocObserver بتاعنا في ال main.dart في ال void main فوق ال runApp() مباشرة
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
})
// class SimpleBlocObserver extends BlocObserver { ==> بنعملها extends لو هنستخدم method معينة احنا عايزينها عشان implement بتجبرنا نستخدم كل ال methods الموجودة
*/

import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      log('Change -- ${bloc.runtimeType} => $change');
    }
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      log('Transition -- ${bloc.runtimeType} => $transition');
    }
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      log('Close -- ${bloc.runtimeType} => $bloc');
    }
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      log('Create -- ${bloc.runtimeType} => $bloc');
    }
  }

  @override
  void onDone(
    Bloc<dynamic, dynamic> bloc,
    Object? event, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    super.onDone(bloc, event, error, stackTrace);
    if (kDebugMode) {
      log(
        'Done -- ${bloc.runtimeType} => $event,/ error: $error,/ stackTrace: $stackTrace',
      );
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      log('Error -- ${bloc.runtimeType} => $error');
    }
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      log('Event -- ${bloc.runtimeType} => $event');
    }
  }
}
