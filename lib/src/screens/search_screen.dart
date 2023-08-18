import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotspot/src/screens/detail_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'widgets/search_screen_extended_info.dart';

import '../blocs/bloc_exports.dart';
import '../blocs/info/info_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final String phoneSvg = 'assets/svg/phone.svg';

  final String documentSvg = 'assets/svg/document.svg';

  final String copySvg = 'assets/svg/copy.svg';

  final String clockSvg = 'assets/svg/clock.svg';

  final String markerSvg = 'assets/svg/marker.svg';

  final String offSvg = 'assets/svg/off.svg';
  var uuid = const Uuid();
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        if (!isLoading) {
          setState(() {
            isLoading = true;
          });
        }
        final result = context.read<InfoBloc>().state.infoList;
        if (result.isNotEmpty) {
          context.read<InfoBloc>().add(getMoreInfoEvent());
          setState(() {
            isLoading = false;
          });
        }
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 44,
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      BlocBuilder<InfoBloc, InfoState>(
                        builder: (context, state) {
                          return ExpansionPanelList.radio(
                            dividerColor: Colors.black54,
                            elevation: 0,
                            children: state.infoList
                                .map(
                                  (info) => ExpansionPanelRadio(
                                    backgroundColor: Colors.black,
                                    value: uuid.v4(),
                                    headerBuilder: (context, isExpanded) =>
                                        Slidable(
                                      startActionPane: ActionPane(
                                        motion: const StretchMotion(),
                                        children: [
                                          SlidableAction(
                                            autoClose: true,
                                            onPressed: (context) {},
                                            backgroundColor: Colors.black,
                                            icon: Icons.star_border_outlined,
                                            label: '즐겨찾기',
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //클릭 범위
                                                  GestureDetector(
                                                    onTap: () {
                                                      final infoBloc = context
                                                          .read<InfoBloc>();
                                                      final passedInfo = infoBloc
                                                          .state.infoList
                                                          .firstWhere(
                                                              (infoElement) =>
                                                                  infoElement
                                                                      .id ==
                                                                  info.id);
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailScreen(
                                                                    info:
                                                                        passedInfo)),
                                                      );
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        //프로그램 제목
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 3),
                                                          child: Text(
                                                            '#${info.title}',
                                                            style:
                                                                const TextStyle(
                                                              fontVariations: <FontVariation>[
                                                                FontVariation(
                                                                  'wght',
                                                                  500,
                                                                ),
                                                              ],
                                                              fontSize: 14,
                                                              letterSpacing: 1,
                                                            ),
                                                          ),
                                                        ),

                                                        const SizedBox(
                                                            height: 6),
                                                        //이름 & 장소 타입

                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              info.name.length >
                                                                      15
                                                                  ? info.name
                                                                      .substring(
                                                                          0, 15)
                                                                  : info.name,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 4),
                                                            Text(
                                                              info.location_type,
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 6),
                                                        // 주소
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 2),
                                                              child: SvgPicture
                                                                  .asset(
                                                                markerSvg,
                                                                width: 14,
                                                                colorFilter:
                                                                    const ColorFilter
                                                                        .mode(
                                                                  Colors.grey,
                                                                  BlendMode
                                                                      .srcIn,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 4),
                                                            //주소
                                                            Flexible(
                                                              child: Text(
                                                                info.address,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines:
                                                                    isExpanded ==
                                                                            false
                                                                        ? 1
                                                                        : 2,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    body: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // 상세설명
                                                ExtendedInfo(
                                                  documentSvg: documentSvg,
                                                  detail: info.details,
                                                ),
                                                const SizedBox(height: 6),
                                                // 연락처
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      phoneSvg,
                                                      width: 14,
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                        Colors.grey,
                                                        BlendMode.srcIn,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        if (!await launchUrl(
                                                            Uri.parse(
                                                                'tel:${info.contact}'))) {
                                                          throw 'X';
                                                        }
                                                        return;
                                                      },
                                                      child: Text(
                                                        info.contact,
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xff62A5F1),
                                                          fontVariations: <FontVariation>[
                                                            FontVariation(
                                                                'wght', 400),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 6),
                                                //영업시간
                                                ExtendedInfo(
                                                  documentSvg: clockSvg,
                                                  detail: info.workhours,
                                                ),

                                                const SizedBox(height: 6),
                                                //휴무시간
                                                ExtendedInfo(
                                                  documentSvg: offSvg,
                                                  detail: info.off,
                                                  textColor: Colors.red,
                                                ),
                                                const SizedBox(height: 6),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
