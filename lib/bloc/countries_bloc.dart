import 'package:coronavirus/resource/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'package:coronavirus/model/CountriesData.dart';
import 'package:coronavirus/model/TotalData.dart';

class CountriesBloc {
  final _repository = Repository();

  final _countriesFetcher = PublishSubject<CountriesData>();
  final _totalDataFetcher = PublishSubject<TotalData>();

  Observable<CountriesData> get allCountries => _countriesFetcher.stream;
  Observable<TotalData> get totalData => _totalDataFetcher.stream;

  fetchAllCountries() async {
    CountriesData countriesData = await _repository.fetchCountriesData();
    _countriesFetcher.sink.add(countriesData);
  }

  fetchAllTotalData() async {
    TotalData totalData = await _repository.fetchTotalData();
    _totalDataFetcher.sink.add(totalData);
  }

  void dispose() {
    _countriesFetcher.close();
    _totalDataFetcher.close();
  }
}

final bloc = CountriesBloc();