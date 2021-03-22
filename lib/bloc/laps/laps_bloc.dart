import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/laps/laps.dart';

class LapsBloc extends Bloc<LapsEvent, LapsState> {
  LapsBloc(LapsState initialState) : super(initialState);

  @override
  Stream<LapsState> mapEventToState(event) {}
}
