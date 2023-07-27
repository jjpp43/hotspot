import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotspot/src/models/info_model.dart';

import '../../repositories/firestore_repository.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  InfoBloc() : super(const InfoState(infoList: [])) {
    on<getInfoEvent>(_onGetInfoLists);
    on<getMoreInfoEvent>(_onGetMoreInfoLists);
  }
  final FirestoreRepository _firestoreRepository = FirestoreRepository();

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
    final snapshot = await _firestoreRepository.getInfoLists();

    final List<InfoModel> fetchedInfo =
        snapshot.docs.map((doc) => InfoModel.fromSnapshot(doc.data())).toList();

    emit(InfoState(infoList: fetchedInfo));
  }

  void _onGetMoreInfoLists(
      getMoreInfoEvent event, Emitter<InfoState> emit) async {
    final lastInfo = state.infoList.last;
    print('What\'s passed as an argument : $lastInfo');
    final snapshot = await _firestoreRepository.getMoreInfoLists(lastInfo);

    final List<InfoModel> fetchedInfo =
        snapshot.docs.map((doc) => InfoModel.fromSnapshot(doc.data())).toList();
    print(
        'Right after retrieving additional 10 snapshots(${fetchedInfo.length}) : $fetchedInfo');
    final List<InfoModel> updatedList =
        List.from(state.infoList..addAll(fetchedInfo));
    print('All snapshots combined(${updatedList.length}) : $updatedList');
    emit(InfoState(infoList: updatedList));
  }

  void _isFavorite(isFavorite event, Emitter<InfoState> emit) async {}
}
