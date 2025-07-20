import 'package:flutter/material.dart';

import '../widgets/appbars/appbar_empty.dart';
import 'loading_page.dart';

class DesignPage extends StatelessWidget {
  final String url;
  final List<String> tests;

  const DesignPage({super.key, required this.url, required this.tests});

  void redirectLoadingPage(BuildContext context, bool designTest) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => LoadingPage(
        url: url,
        tests: tests,
        designTest: designTest,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), child: AppbarEmpty()),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 500,
              height: 300,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.18 * 255).round()),
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Do you want include UI/UX test?",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "By the end of our testing we will provide you PDF report with information about UX/UI",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Inter",
                        color: Color(0xFF898989)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          redirectLoadingPage(context, false);
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            alignment: Alignment.center,
                            width: 110,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFC4C4),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFF383C),
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.close,
                                    size: 13,
                                    color: Color(0xFFFFC4C4),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "No",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFFFF383C),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Inter"),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          redirectLoadingPage(context, true);
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            alignment: Alignment.center,
                            width: 110,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFFE1FFE7),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF4AD968),
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.check,
                                    size: 13,
                                    color: Color(0xFFE1FFE7),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Include",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF4AD968),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Inter"),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
