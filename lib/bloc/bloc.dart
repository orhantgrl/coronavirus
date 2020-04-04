abstract class Bloc<T> {
  void addEvent(T event);

  void addError(dynamic err);

  void dispose();
}
