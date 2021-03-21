import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/labs/labs.dart';

class LabsBloc extends Bloc<LabsEvent, LabsState> {
  LabsBloc(LabsState initialState) : super(initialState);

  @override
  Stream<LabsState> mapEventToState(event) {}
}
