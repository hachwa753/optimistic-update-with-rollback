abstract class TodoEvent {}

class TodoFetchEvent extends TodoEvent {}

class TodoToggleEvent extends TodoEvent {
  final int id;
  TodoToggleEvent(this.id);
}
