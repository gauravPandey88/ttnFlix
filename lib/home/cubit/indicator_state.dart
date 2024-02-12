import 'package:ttn_flix/utils/default_equatable.dart';

abstract class IndicatorState extends DefaultEquatable {
  const IndicatorState();
}

class InitialState extends IndicatorState {}

class IndicatorLoadedState extends IndicatorState {
  final int? carousalMovieCurrentPage;

  const IndicatorLoadedState({this.carousalMovieCurrentPage});

  @override
  List<Object?> get props => [carousalMovieCurrentPage];
}
