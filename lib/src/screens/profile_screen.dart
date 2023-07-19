import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            children: [
              const Text(
                '설정',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          '내 활동',
                          style: TextStyle(
                            fontVariations: <FontVariation>[
                              FontVariation('wght', 400),
                            ],
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Row(
                        children: [
                          Text(
                            '즐겨찾기',
                            style: TextStyle(
                              fontVariations: <FontVariation>[
                                FontVariation('wght', 400),
                              ],
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          '계정',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().authRepository.signOut();
                      },
                      child: const Row(
                        children: [
                          Text(
                            '로그아웃',
                            style: TextStyle(
                              fontVariations: <FontVariation>[
                                FontVariation('wght', 400),
                              ],
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 4),
                    child: Row(
                      children: [
                        Text(
                          '테마 설정',
                          style: TextStyle(
                            fontVariations: <FontVariation>[
                              FontVariation('wght', 400),
                            ],
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<SwitchBloc, SwitchState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          Switch(
                            value: state.switchValue,
                            onChanged: (newValue) {
                              newValue
                                  ? context
                                      .read<SwitchBloc>()
                                      .add(SwitchOnEvent())
                                  : context
                                      .read<SwitchBloc>()
                                      .add(SwitchOffEvent());
                            },
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            state.switchValue == true
                                ? Icons.dark_mode
                                : Icons.light_mode,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 4),
                    child: Row(
                      children: [
                        Text(
                          '언어 설정',
                          style: TextStyle(
                            fontVariations: <FontVariation>[
                              FontVariation('wght', 400),
                            ],
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      // Switch(
                      //   value: false,
                      //   onChanged: (newValue) async {
                      //     newValue
                      //         ? await EasyLocalization.of(context)!
                      //             .setLocale(const Locale('en', 'US'))
                      //         : await EasyLocalization.of(context)!
                      //             .setLocale(const Locale('ko', 'KR'));
                      //     await EasyLocalization.ensureInitialized();
                      //   },
                      // ),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
