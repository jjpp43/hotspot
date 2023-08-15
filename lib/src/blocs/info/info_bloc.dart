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
    on<getInfoByRegionSeoulEvent>(_onGetInfoListsByRegionSeoul);
    on<getMoreInfoByRegionSeoulEvent>(_onGetMoreInfoListsByRegionSeoul);
    on<changeRegionEvent>(_onChangeRegion);
  }
  final FirestoreRepository _firestoreRepository = FirestoreRepository();

  void _onGetInfoLists(getInfoEvent event, Emitter<InfoState> emit) async {
    final snapshot = await _firestoreRepository.getInfoLists();

    final List<InfoModel> fetchedInfo =
        snapshot.docs.map((doc) => InfoModel.fromSnapshot(doc.data())).toList();

    emit(InfoState(infoList: fetchedInfo));
  }

  void _onGetMoreInfoLists(
      getMoreInfoEvent event, Emitter<InfoState> emit) async {
    //Store the last document of the list
    final lastInfo = state.infoList.last;
    //Get the rest of the results by starting after the last document
    final snapshot = await _firestoreRepository.getMoreInfoLists(lastInfo);
    //Get all the additional list
    final List<InfoModel> fetchedInfo =
        snapshot.docs.map((doc) => InfoModel.fromSnapshot(doc.data())).toList();
    //Add the additional list to the original list
    final List<InfoModel> updatedList =
        List.from(state.infoList..addAll(fetchedInfo));
    //Emit the state
    emit(InfoState(infoList: updatedList));
  }

  void _onChangeRegion(changeRegionEvent event, Emitter<InfoState> emit) async {
    print('Bloc : ${event.region}');
    final updatedState = InfoState(
      infoList: state.infoList,
      region: event.region,
    );
    emit(updatedState);
    //지금 여기서 emit한 다음에 값이 안바뀜. 여기부터 pickup하면 됨.
    print('After Emit : ${state.region}');
  }

  void _onGetInfoListsByRegionSeoul(
      getInfoByRegionSeoulEvent event, Emitter<InfoState> emit) async {
    state.infoList.clear();
    final snapshot = await _firestoreRepository.getInfoListsByRegionSeoul();

    final List<InfoModel> fetchedInfo =
        snapshot.docs.map((doc) => InfoModel.fromSnapshot(doc.data())).toList();

    emit(InfoState(infoList: fetchedInfo));
  }

  void _onGetMoreInfoListsByRegionSeoul(
      getMoreInfoByRegionSeoulEvent event, Emitter<InfoState> emit) async {
    final lastInfo = state.infoList.last;
    // print('What\'s passed as an argument : $lastInfo');
    final snapshot =
        await _firestoreRepository.getMoreInfoListsByRegionSeoul(lastInfo);

    final List<InfoModel> fetchedInfo =
        snapshot.docs.map((doc) => InfoModel.fromSnapshot(doc.data())).toList();
    // print(
    //     'Right after retrieving additional 10 snapshots(${fetchedInfo.length}) : $fetchedInfo');
    final List<InfoModel> updatedList =
        List.from(state.infoList..addAll(fetchedInfo));
    // print('All snapshots combined(${updatedList.length}) : $updatedList');
    emit(InfoState(infoList: updatedList));
  }

  void _isFavorite(isFavorite event, Emitter<InfoState> emit) async {}
}
