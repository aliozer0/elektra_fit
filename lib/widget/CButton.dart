import 'package:elektra_fit/global/global-variables.dart';
import 'package:flutter/material.dart';

class CButton extends StatelessWidget {
  const CButton({
    super.key,
    required this.title,
    required this.func,
    this.width,
    this.backgroundColor,
    this.height,
    this.isBorder = false,
  });
  final String title;
  final VoidCallback func;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final bool isBorder;
  @override
  Widget build(BuildContext context) {
    double H = MediaQuery.of(context).size.height;
    double W = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: isDarkMode$.stream,
        builder: (context, snapshot) {
          return InkWell(
              onTap: func,
              child: Container(
                width: width ?? MediaQuery.of(context).size.width * 0.43,
                height: height ?? MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)), color: isBorder ? Colors.transparent : config.primaryColor, border: Border.all(color: config.primaryColor, width: 1)),
                child: Container(
                  // padding: EdgeInsets.only(bo),
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: W / 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                      fontFamily: 'Proxima',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ));
        });
  }
}
