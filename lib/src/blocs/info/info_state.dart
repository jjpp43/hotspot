part of 'info_bloc.dart';

class InfoState extends Equatable {
  final List<InfoModel> infoList;
  final String? region;
  const InfoState({
    required this.infoList,
    this.region,
  });

  @override
  List<Object> get props => [infoList];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'infoList': infoList.map((x) => x.toMap()).toList(),
    };
  }

  factory InfoState.fromMap(Map<String, dynamic> map) {
    return InfoState(
      infoList: List<InfoModel>.from(
        (map['infoList']).map<InfoModel>(
          (x) => InfoModel.fromSnapshot(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
