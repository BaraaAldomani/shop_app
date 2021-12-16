import 'package:flutter_bloc/flutter_bloc.dart';

List <Map> comment = [
  {'id': '1', 'comment': 'woooow this is great'},
  {'id': '2', 'comment': 'good Item'},
  {'id': '3', 'comment': 'thx you mr baraa'},
  {'id': '4', 'comment': 'I will come again later'},
  {'id': '4', 'comment': 'I will come again later'},
  {'id': '4', 'comment': 'I will come again later'},
  {'id': '4', 'comment': 'I will come again later'},
  {'id': '4', 'comment': 'I will come again later'},
  {'id': '4', 'comment': 'I will come again later'},
] ;
class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}