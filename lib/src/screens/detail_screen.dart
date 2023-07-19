import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/info_model.dart';

class DetailScreen extends StatefulWidget {
  final InfoModel info;

  const DetailScreen({
    super.key,
    required this.info,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFullscreen = false;
  final String phoneSvg = 'assets/svg/phone.svg';
  final String documentSvg = 'assets/svg/document.svg';
  final String copySvg = 'assets/svg/copy.svg';
  final String clockSvg = 'assets/svg/clock.svg';
  final String markerSvg = 'assets/svg/marker.svg';
  final String offSvg = 'assets/svg/off.svg';
  final String likeOutlinedSvg = 'assets/svg/like-outline.svg';
  final String likeFilledSvg = 'assets/svg/like-filled.svg';
  final String bookmarkFilledSvg = 'assets/svg/bookmark-filled.svg';
  final String bookmarkOutlinedSvg = 'assets/svg/bookmark-outline.svg';

  GoogleMapController? mapController;
  Set<Marker> markers = {};
  LatLng showLocation = const LatLng(36.5, 127);

  String getFirstWords(String sentence) {
    return sentence.split(" ").sublist(0, 2).join(" ");
  }

  @override
  void initState() {
    markers.add(Marker(
      markerId: MarkerId(showLocation.toString()),
      position: showLocation,
      infoWindow:
          InfoWindow(title: widget.info.name, snippet: widget.info.address),
      icon: BitmapDescriptor.defaultMarker,
    ));
    super.initState();
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFullscreen = !isFullscreen;
              });
            },
            icon: const Padding(
              padding: EdgeInsets.only(right: 18.0),
              child: Icon(Icons.fullscreen),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //지도
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: isFullscreen
                    ? MediaQuery.of(context).size.height
                    : MediaQuery.of(context).size.width * 0.7,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: showLocation,
                    zoom: 10,
                  ),
                  markers: markers,
                  mapType: MapType.normal,
                  onMapCreated: (controller) {
                    setState(() {
                      mapController = controller;
                    });
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    //프로그램 제목
                    Stack(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.black,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Text(
                                      widget.info.title,
                                      style: const TextStyle(
                                        fontVariations: <FontVariation>[
                                          FontVariation(
                                            'wght',
                                            500,
                                          ),
                                        ],
                                        fontSize: 14,
                                        letterSpacing: 1,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            //이름
                            Row(
                              children: [
                                Text(
                                  widget.info.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            //간략한 주소
                            Row(
                              children: [
                                Text(
                                  getFirstWords(widget.info.address),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  '⋅',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.info.location_type,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //즐겨찾기 버튼
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: LikeButton(
                                onTap: onLikeButtonTapped,
                                size: 24,
                                animationDuration:
                                    const Duration(milliseconds: 800),
                                circleColor: const CircleColor(
                                  start: Colors.white,
                                  end: Colors.black,
                                ),
                                bubblesColor: const BubblesColor(
                                  dotPrimaryColor: Colors.white,
                                  dotSecondaryColor: Colors.white,
                                ),
                                likeBuilder: (bool isLiked) {
                                  if (isLiked) {
                                    return SvgPicture.asset(
                                      bookmarkFilledSvg,
                                    );
                                  }
                                  return SvgPicture.asset(
                                    bookmarkOutlinedSvg,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.grey,
                                      BlendMode.srcIn,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.42,
                              MediaQuery.of(context).size.width * 0.1,
                            ),
                            maximumSize: Size(
                              (MediaQuery.of(context).size.width - 40) / 2,
                              MediaQuery.of(context).size.width * 0.1,
                            ),
                            side: const BorderSide(),
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.white,
                            elevation: 0,
                          ),
                          child: const Text(
                            '길찾기',
                            style: TextStyle(
                              color: Colors.black,
                              fontVariations: <FontVariation>[
                                FontVariation('wght', 500),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.42,
                              MediaQuery.of(context).size.width * 0.1,
                            ),
                            side: const BorderSide(),
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.black,
                            elevation: 0,
                          ),
                          child: const Text(
                            '지도보기',
                            style: TextStyle(
                              color: Colors.white,
                              fontVariations: <FontVariation>[
                                FontVariation('wght', 500),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.black, thickness: 0.3),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: SvgPicture.asset(
                            markerSvg,
                            width: 14,
                            colorFilter: const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.info.address,
                          style: const TextStyle(
                            fontVariations: <FontVariation>[
                              FontVariation(
                                'wght',
                                400,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    // 연락처
                    Row(
                      children: [
                        SvgPicture.asset(
                          phoneSvg,
                          width: 14,
                          colorFilter: const ColorFilter.mode(
                            Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () async {
                            if (!await launchUrl(
                                Uri.parse('tel:${widget.info.contact}'))) {
                              throw 'X';
                            }
                            return;
                          },
                          child: Text(
                            widget.info.contact,
                            style:
                                const TextStyle(fontVariations: <FontVariation>[
                              FontVariation(
                                'wght',
                                400,
                              ),
                            ], color: Color(0xff62A5F1)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    //영업시간
                    Row(
                      children: [
                        SvgPicture.asset(
                          clockSvg,
                          width: 14,
                          colorFilter: const ColorFilter.mode(
                            Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.info.workhours,
                          style: const TextStyle(
                            fontVariations: <FontVariation>[
                              FontVariation(
                                'wght',
                                400,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    //휴무시간
                    Row(
                      children: [
                        SvgPicture.asset(
                          offSvg,
                          width: 14,
                          colorFilter: const ColorFilter.mode(
                            Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.info.off,
                          style: const TextStyle(
                            color: Colors.red,
                            fontVariations: <FontVariation>[
                              FontVariation('wght', 400),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.black, thickness: 0.3),
                    const SizedBox(height: 10),
                    // 상세설명
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: SvgPicture.asset(
                            documentSvg,
                            width: 14,
                            colorFilter: const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            widget.info.details,
                            style: const TextStyle(
                              fontVariations: <FontVariation>[
                                FontVariation('wght', 400)
                              ],
                            ),
                            overflow: TextOverflow.clip,
                            maxLines: null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
