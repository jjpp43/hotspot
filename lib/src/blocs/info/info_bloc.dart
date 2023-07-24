import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:hotspot/src/models/info_model.dart';

import '../../repositories/firestore_repository.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  InfoBloc() : super(const InfoState(infoList: [])) {
    on<getInfoEvent>(_onGetInfoLists);
    on<getMoreInfoEvent>(_onGetMoreInfoLists);
  }
  List<InfoModel> infoLists = [];
  // void _onGetInfoLists(getInfoEvent event, Emitter<InfoState> emit) async {
  //   await FirestoreRepository.getInfoLists().then((value) {
  //     for (var info in value) {
  //       infoLists.add(info);
  //     }
  //     print('Bloc init : ${infoLists.length.toString()}');
  //   });

  //   emit(InfoState(infoList: infoLists));
  // }

  void _onGetInfoLists(getInfoEvent event, Emitter<InfoState> emit) async {
    final snapshot = await FirestoreRepository.getInfoLists();

    final List<InfoModel> fetchedInfo =
        snapshot.docs.map((doc) => InfoModel.fromMap(doc.data())).toList();

    infoLists.assignAll(fetchedInfo);

    emit(InfoState(infoList: infoLists));
  }

  void _onGetMoreInfoLists(
      getMoreInfoEvent event, Emitter<InfoState> emit) async {
    final snapshot = await FirestoreRepository.getMoreInfoLists(
        lastInfo: state.infoList.last);

    final List<InfoModel> fetchedInfo =
        snapshot.docs.map((doc) => InfoModel.fromMap(doc.data())).toList();

    infoLists.addAll(fetchedInfo);

    emit(InfoState(infoList: infoLists));
  }

  void _isFavorite(isFavorite event, Emitter<InfoState> emit) async {}
}
