import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tvseries_event.dart';
part 'tvseries_state.dart';

class TvseriesBloc extends Bloc<TvseriesEvent, TvseriesState> {
  TvseriesBloc() : super(TvseriesInitial()) {
    on<TvseriesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
