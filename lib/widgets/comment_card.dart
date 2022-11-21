import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tri_karo_2/widgets/star_button.dart';

import '../utils/colors.dart';
import '../utils/constant_variables.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        // height: 160,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          Row(children: [
            CircleAvatar(radius: 20, backgroundImage: AssetImage('$imagePath/sample_user_image.png')),
            const SizedBox(width: 14),
            Text('Lauralee Quintero', style: GoogleFonts.poppins(fontSize: 16, color: black, fontWeight: FontWeight.w600)),
            const Spacer(),
            const StarButton(text: '5')
          ]),
          const SizedBox(height: 16),
          Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text.',
              style: GoogleFonts.poppins(fontSize: 14, color: grey_2)),
          // const SizedBox(height: 8),
          // Row(children: [
          //   Icon(EvaIcons.heartOutline, color: black, size: 28),
          //   const SizedBox(width: 8),
          //   Text('74', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: black)),
          //   const SizedBox(width: 24),
          //   Text('1 week ago', style: GoogleFonts.poppins(fontSize: 12, color: grey_2))
          // ])
        ]));
  }
}
