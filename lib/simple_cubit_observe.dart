import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitObserve implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('change = $change');
    onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint(' close $bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    debugPrint('creat = $bloc');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('bloc = $bloc');
    debugPrint('object = $error');
    debugPrint('StackTrace = $stackTrace');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint('Bloc = $bloc');
    debugPrint('Object = $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('Bloc = $bloc');
    debugPrint('Transition = $transition');
  }
}
