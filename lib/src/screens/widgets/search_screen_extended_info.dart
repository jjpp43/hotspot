import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExtendedInfo extends StatelessWidget {
  const ExtendedInfo({
    super.key,
    required this.detail,
    required this.documentSvg,
    this.textColor,
  });
  final String detail;
  final String documentSvg;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
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
            detail,
            style: TextStyle(
              fontVariations: const <FontVariation>[
                FontVariation('wght', 400),
              ],
              color: textColor,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
