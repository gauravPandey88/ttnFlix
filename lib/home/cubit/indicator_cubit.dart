
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/home/cubit/indicator_state.dart';

class IndicatorCubit extends Cubit<IndicatorState> {

  IndicatorCubit() : super(InitialState());

  void updatePageIndicator(int index) {
    emit(IndicatorLoadedState(carousalMovieCurrentPage: index));
    }

}
