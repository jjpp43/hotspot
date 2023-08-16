import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotspot/src/blocs/bloc_exports.dart';
import 'package:hotspot/src/blocs/info/info_bloc.dart';
import 'package:hotspot/src/screens/search_screen.dart';
import 'widgets/main_screen_block.dart';
import 'widgets/main_screen_region_block.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    '지역별 SPOT',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 160,
                                        child: ListView(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                context.read<InfoBloc>().add(
                                                    getInfoByRegionSeoulEvent());
                                                Get.to(
                                                    () => const SearchScreen());
                                              },
                                              child: const MainScreenRegionBlock(
                                                  img:
                                                      'assets/images/seoul-min.jpg',
                                                  title: '서울특별시'),
                                            ),
                                            const SizedBox(width: 10),
                                            GestureDetector(
                                              onTap: () {
                                                context.read<InfoBloc>().add(
                                                    getInfoByRegionGyeonggidoEvent());
                                                Get.to(
                                                    () => const SearchScreen());
                                              },
                                              child: const MainScreenRegionBlock(
                                                  img:
                                                      'assets/images/gyeonggi-min.jpg',
                                                  title: '경기도'),
                                            ),
                                            const SizedBox(width: 10),
                                            const MainScreenRegionBlock(
                                                img:
                                                    'assets/images/gangwon-min.jpg',
                                                title: '강원도'),
                                            const SizedBox(width: 10),
                                            const MainScreenRegionBlock(
                                                img:
                                                    'assets/images/gyeongsangdo-min.jpg',
                                                title: '경상도'),
                                            const SizedBox(width: 10),
                                            const MainScreenRegionBlock(
                                                img:
                                                    'assets/images/choongchungdo-min.jpg',
                                                title: '충청도'),
                                            const SizedBox(width: 10),
                                            const MainScreenRegionBlock(
                                                img:
                                                    'assets/images/jeonlado-min.jpg',
                                                title: '전라도'),
                                            const SizedBox(width: 10),
                                            const MainScreenRegionBlock(
                                                img:
                                                    'assets/images/jejudo-min.jpg',
                                                title: '제주도'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '드라마 SPOT',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 160,
                                        child: ListView(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: const MainScreenBlock(
                                                  img:
                                                      'assets/images/1-min.jpg',
                                                  title: '사랑의 불시착'),
                                            ),
                                            const SizedBox(width: 10),
                                            const MainScreenBlock(
                                                img: 'assets/images/2-min.jpg',
                                                title: '도깨비'),
                                            const SizedBox(width: 10),
                                            const MainScreenBlock(
                                                img: 'assets/images/3-min.jpg',
                                                title: '미스터 션샤인'),
                                          ],
                                        ),
                                      ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              '영화 SPOT',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 160,
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: const [
                                      MainScreenBlock(
                                          img: 'assets/images/movie1-min.jpg',
                                          title: '괴물'),
                                      SizedBox(width: 10),
                                      MainScreenBlock(
                                          img: 'assets/images/movie2-min.jpg',
                                          title: '곡성'),
                                      SizedBox(width: 10),
                                      MainScreenBlock(
                                          img: 'assets/images/movie3-min.jpg',
                                          title: '건축학개론'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              '예능 SPOT',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 160,
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: const [
                                      MainScreenBlock(
                                          img: 'assets/images/show1-min.jpg',
                                          title: '런닝맨'),
                                      SizedBox(width: 10),
                                      MainScreenBlock(
                                          img: 'assets/images/show2-min.jpg',
                                          title: '1박2일'),
                                      SizedBox(width: 10),
                                      MainScreenBlock(
                                          img: 'assets/images/show3-min.jpg',
                                          title: '맛있는 녀석들'),
                                    ],
                                  ),
                                ),
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
        ),
      ),
    );
  }
}
