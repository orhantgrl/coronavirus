import 'package:coronavirus/bloc/bloc.dart';
import 'package:coronavirus/model/TotalData.dart';
import 'package:coronavirus/resource/repository.dart';
import 'package:rxdart/rxdart.dart';

class TotalDataBloc extends Bloc<TotalData> {
  final Repository _repository = Repository();

  final _totalDataFetcher = PublishSubject<TotalData>();

  Observable<TotalData> get totalData => _totalDataFetcher.stream;

  fetchTotalData() async {
    try {
      TotalData totalData = await _repository.fetchTotalData();
      addEvent(totalData);
    } catch (err) {
      addError(err);
    }
  }

  @override
  void addEvent(TotalData event) {
    _totalDataFetcher.sink.add(event);
  }

  @override
  void addError(err) {
    _totalDataFetcher.sink.addError(err);
  }

  @override
  void dispose() {
    _totalDataFetcher.close();
  }
}

final totalDataBloc = TotalDataBloc();
