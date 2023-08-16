part of 'info_bloc.dart';

abstract class InfoEvent extends Equatable {
  const InfoEvent();

  @override
  List<Object> get props => [];
}

class changeRegionEvent extends InfoEvent {
  final String region;
  const changeRegionEvent(this.region);
  @override
  List<Object> get props => [region];
}

class getInfoEvent extends InfoEvent {
  @override
  List<Object> get props => [];
}

class getMoreInfoEvent extends InfoEvent {
  @override
  List<Object> get props => [];
}

class getInfoByRegionSeoulEvent extends InfoEvent {
  @override
  List<Object> get props => [];
}

class getMoreInfoByRegionSeoulEvent extends InfoEvent {
  @override
  List<Object> get props => [];
}

class getInfoByRegionGyeonggidoEvent extends InfoEvent {
  @override
  List<Object> get props => [];
}

class getMoreInfoByRegionGyeonggidoEvent extends InfoEvent {
  @override
  List<Object> get props => [];
}

class isFavorite extends InfoEvent {
  @override
  List<Object> get props => [];
}
