import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sample_bloc_page_state.dart';

class SampleBlocPageCubit extends Cubit<SampleBlocPageState> {
  SampleBlocPageCubit() : super(SampleBlocPageInitial());

  Future<void> fetchData() async {
    emit(SampleBlocPageLoading());
    try {
      // Simulate a network call
      await Future.delayed(const Duration(seconds: 2));
      emit(SampleBlocPageLoaded('Fetched Data'));
    } catch (e) {
      emit(SampleBlocPageError('Failed to fetch data'));
    }
  }
}
