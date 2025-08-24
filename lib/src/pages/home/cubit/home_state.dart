part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeReceiveSharedMarker extends HomeState {
  final String id;

  const HomeReceiveSharedMarker(this.id);

  @override
  List<Object> get props => [id];
}

final class HomeLoadedSuccess extends HomeState {
  final String? collectionId;
  const HomeLoadedSuccess({
    this.collectionId,
  });

  @override
  List<Object?> get props => [collectionId];
}

final class HomeLoadedError extends HomeState {
  final String message;

  const HomeLoadedError(this.message);

  @override
  List<Object> get props => [message];
}
