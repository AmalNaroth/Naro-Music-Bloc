part of 'bottomnav_bloc.dart';

@immutable
class BottomnavState {
  int currentIndex;
  BottomnavState({required this.currentIndex});
}

class BottomnavInitial extends BottomnavState {
  BottomnavInitial() : super (currentIndex: 0);
}
