import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldStyle extends StatelessWidget {
  final TextEditingController codeTextController;
  final String lableText;
  final bool obscureText;
  final TextInputType inputType;
  final bool isenablelable;
  final String hintText;
  TextFieldStyle({
    required this.codeTextController,
    required this.lableText,
    required this.obscureText,
    required this.inputType,
    required this.isenablelable,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isenablelable
            ? Align(
                alignment: Alignment.centerRight,
                child: Text(
                  lableText,
                  style: GoogleFonts.tajawal(
                    fontSize: 16.sp,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              )
            : SizedBox(),
        isenablelable
            ? SizedBox(
                height: 6.h,
              )
            : SizedBox(),
        TextField(
          controller: codeTextController,
          obscureText: obscureText,
          keyboardType: inputType,
          maxLines: 1,
          maxLength: 50,
          cursorHeight: 25.h,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(18),
            counterText: "",
            labelText: hintText,
            labelStyle: TextStyle(
                color: Color(0XFFBCBCBC),
                fontWeight: FontWeight.normal,
                fontSize: 18),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            fillColor: Color(0XFFF3F3F9),
            filled: true,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 0,
                color: Colors.grey.shade300,
              ),
            ),
            // focusColor: Color(0XFF22A45D),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey.shade300,
                  style: BorderStyle.solid),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1,
                  color: Colors.red.shade300,
                  style: BorderStyle.solid),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1,
                  color: Colors.red.shade900,
                  style: BorderStyle.solid),
            ),
          ),
        ),
      ],
    );
  }
}
