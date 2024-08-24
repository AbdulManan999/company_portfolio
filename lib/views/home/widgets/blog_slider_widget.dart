import 'package:flutter/material.dart';
import 'package:flutter_base/route/routes.dart';
import 'package:flutter_base/utils/image_assets.dart';
import 'package:flutter_base/widgets/button_widget/customizable_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/colors.dart';
import '../details_screen.dart';

class BlogSliderWidget extends StatefulWidget {
  final int itemIndex;
  final String title;
  final String description;
  final String image;
  const BlogSliderWidget({super.key, required this.itemIndex, required this.title, required this.description, required this.image});

  @override
  State<BlogSliderWidget> createState() => _BlogSliderWidgetState();
}

class _BlogSliderWidgetState extends State<BlogSliderWidget> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        print(value);
        isHovered = value;
        setState(() {});
      },
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(widget.title,widget.description,widget.image)));
      },
      hoverColor: Colors.transparent,
      child: (ResponsiveBreakpoints.of(context).screenWidth < 575)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
                        ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                            ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                                ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                    ? 614.h
                                    : 331
                                : 289
                            : 398
                        : 404,
                    width: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
                        ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                            ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                                ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                                    ? 450
                                    : 273
                                : 242
                            : 322
                        : 425,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          portfolioImages(widget.itemIndex),
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: (isHovered)
                              ? [primaryColor, Colors.transparent]
                              : [Colors.black54, Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    fontSize: (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                        ? 30
                                        : 30,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.all(5.0),
                                //   child: Text(
                                //     widget.description,
                                //     textAlign: TextAlign.left,
                                //     style: GoogleFonts.poppins(
                                //       fontSize: 16,
                                //       fontWeight: FontWeight.w300,
                                //       color: Colors.white.withOpacity(0.75),
                                //     ),
                                //   ),
                                // ),
                                // Visibility(
                                //   visible: isHovered,
                                //   child: SizedBox(
                                //     height: (ResponsiveBreakpoints.of(context).screenWidth < 990)
                                //         ? 5
                                //         : 15,
                                //   ),
                                // ),
                                // Visibility(
                                //   visible: isHovered,
                                //   child: CustomizableTextButton(
                                //     prefixButtonIcon: null,
                                //     suffixButtonIcon: null,
                                //     isFullWidth: false,
                                //     isOutlined: true,
                                //     buttonBorderColor: Colors.white30,
                                //     buttonTitle: "Read More".toUpperCase(),
                                //     onPressed: () async {},
                                //     buttonTitleStyle: TextStyle(
                                //       fontSize:
                                //           (ResponsiveBreakpoints.of(context).screenWidth < 750)
                                //               ? 12
                                //               : 14,
                                //       color: Colors.white,
                                //       fontWeight: FontWeight.w500,
                                //     ),
                                //     buttonBorderRadius: 6,
                                //     buttonColor: Colors.transparent,
                                //     horizontalPadding: 30,
                                //     verticalPadding: 8,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              height: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
                  ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                      ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                          ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                              ? 614
                              : 331
                          : 289
                      : 398
                  : 404,
              width: (ResponsiveBreakpoints.of(context).screenWidth < 1270)
                  ? (ResponsiveBreakpoints.of(context).screenWidth < 990)
                      ? (ResponsiveBreakpoints.of(context).screenWidth < 770)
                          ? (ResponsiveBreakpoints.of(context).screenWidth < 575)
                              ? 450
                              : 273
                          : 242
                      : 322
                  : 425,
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    portfolioImages(widget.itemIndex),
                  ),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: (isHovered)
                        ? [primaryColor, Colors.transparent]
                        : [Colors.black54, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              fontSize:
                              (ResponsiveBreakpoints.of(context).screenWidth < 990) ? 30 : 30,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.all(5.0),
                          //   child: Text(
                          //     widget.description,
                          //     textAlign: TextAlign.left,
                          //     style: GoogleFonts.poppins(
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.w300,
                          //       color: Colors.white.withOpacity(0.75),
                          //     ),
                          //   ),
                          // ),
                          // Visibility(
                          //   visible: isHovered,
                          //   child: SizedBox(
                          //     height:
                          //         (ResponsiveBreakpoints.of(context).screenWidth < 990) ? 5 : 15,
                          //   ),
                          // ),
                          // Visibility(
                          //   visible: isHovered,
                          //   child: CustomizableTextButton(
                          //     prefixButtonIcon: null,
                          //     suffixButtonIcon: null,
                          //     isFullWidth: false,
                          //     isOutlined: true,
                          //     buttonBorderColor: Colors.white30,
                          //     buttonTitle: "Read More".toUpperCase(),
                          //     onPressed: () async {},
                          //     buttonTitleStyle: TextStyle(
                          //       fontSize:
                          //           (ResponsiveBreakpoints.of(context).screenWidth < 750) ? 12 : 14,
                          //       color: Colors.white,
                          //       fontWeight: FontWeight.w500,
                          //     ),
                          //     buttonBorderRadius: 6,
                          //     buttonColor: Colors.transparent,
                          //     horizontalPadding: 30,
                          //     verticalPadding: 8,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  String portfolioImages(int index) {
    if (index == 0) {
      return customizedSolution;
    } else if (index == 1) {
      return provenTrackRecord;
    } else if (index == 2) {
      return clientCentricSolution;
    } else if (index == 3) {
      return secureSolution;
    } else {
      return portfolio5Image;
    }
  }
}
