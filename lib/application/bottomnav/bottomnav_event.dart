part of 'bottomnav_bloc.dart';

@immutable
abstract class BottomnavEvent {}

class ScreenChange extends BottomnavEvent{
  int screenIndex;
  ScreenChange({required this.screenIndex});
}