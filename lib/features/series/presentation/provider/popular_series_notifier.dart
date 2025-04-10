import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/series.dart';
import '../../domain/usecases/get_popular_series.dart';

class PopularSeriesNotifier extends ChangeNotifier {
  final GetPopularSeries getPopularSeries;

  PopularSeriesNotifier(this.getPopularSeries);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Series> _series = [];
  List<Series> get series => _series;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (Data) {
        _series = Data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
