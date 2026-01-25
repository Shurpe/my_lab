part of 'details_bloc.dart';

abstract class DetailsEvent {}

class DetailsLoad extends DetailsEvent {
  final int id;
  DetailsLoad(this.id);
}
