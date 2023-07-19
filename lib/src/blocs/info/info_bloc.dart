import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotspot/src/models/info_model.dart';

import '../../repositories/firestore_repository.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  InfoBloc() : super(const InfoState(infoList: [])) {
    on<getInfoEvent>(_onGetInfoLists);
  }

  void _onGetInfoLists(getInfoEvent event, Emitter<InfoState> emit) async {
    List<InfoModel> infoLists = [];
    await FirestoreRepository.getInfoLists().then((value) {
      for (var info in value) {
        infoLists.add(info);
      }
    });
    emit(InfoState(infoList: infoLists));
  }

  void _isFavorite(isFavorite event, Emitter<InfoState> emit) async {}
}
