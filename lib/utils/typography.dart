  import 'package:flutter/cupertino.dart';
  import 'package:google_fonts/google_fonts.dart';

  class TypoText {

    final String text;
    final Color color;

    TypoText({
      required this.text,
      required this.color,
    });

    // ignore: non_constant_identifier_names
    Large() => Text(text, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 30.0, fontWeight: FontWeight.w700, color: color));
    large() => Text(text, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 20.0, fontWeight: FontWeight.w700, color: color));
    h1() => Text(text, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 19.0, fontWeight: FontWeight.w700, color: color));
    h2() => Text(text, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 17.0, fontWeight: FontWeight.w700, color: color));
    h3() => Text(text, overflow: TextOverflow.visible, style: GoogleFonts.inter(fontSize: 15.0, fontWeight: FontWeight.w700, color: color));
    long() => Text(text, overflow: TextOverflow.visible, style: GoogleFonts.inter(fontSize: 15.0, fontWeight: FontWeight.w400, color: color));
    longCast() => Text(text, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 15.0, fontWeight: FontWeight.w400, color: color));
    short() => Text(text, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 12.0, fontWeight: FontWeight.w400, color: color));

  }