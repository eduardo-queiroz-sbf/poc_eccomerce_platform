import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CoreBloc<T extends Bloc<Event, State>, Event, State>
    extends Bloc<Event, State> {
  CoreBloc(State state) : super(state);

  BlocProvider<T> provider() => BlocProvider<T>(
        lazy: false,
        create: (_) => this as T,
      );
}
