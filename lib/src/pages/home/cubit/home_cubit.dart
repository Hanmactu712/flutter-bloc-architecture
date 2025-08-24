import 'dart:async';
import 'dart:developer';
import 'package:app_core/app_core.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    AppLogger("HomeCubit").info("HomeCubit created");
  }

  _emitState(HomeState state) {
    if (isClosed) return;
    emit(state);
  }

  void loadData() {
    _emitState(const HomeLoadedSuccess());
  }

  void selectCollection(String? id) {
    _emitState(HomeLoadedSuccess(collectionId: id));
  }
}
