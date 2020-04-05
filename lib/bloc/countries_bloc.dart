import 'package:coronavirus/bloc/bloc.dart';
import 'package:coronavirus/model/CountriesData.dart';
import 'package:coronavirus/resource/repository.dart';
import 'package:rxdart/rxdart.dart';

class CountriesBloc extends Bloc<CountriesData> {
  final Repository _repository = Repository();

  final _countriesFetcher = PublishSubject<CountriesData>();

  Observable<CountriesData> get countriesData => _countriesFetcher.stream;

  fetchCountries() async {
    try {
      CountriesData countriesData = await _repository.fetchCountriesData();
      addEvent(countriesData);
    } catch (err) {
      addError(err);
    }
  }

  @override
  void addEvent(CountriesData event) {
    _countriesFetcher.sink.add(event);
  }

  @override
  void addError(err) {
    _countriesFetcher.addError(err);
  }

  @override
  void dispose() {
    _countriesFetcher.close();
  }
}

final countriesBloc = CountriesBloc();
