import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../drawer_card.dart';
import '../overlay_card.dart';

class AppBarComponentScanPage extends StatefulWidget {
  final String url;

  const AppBarComponentScanPage({super.key, required this.url});

  @override
  State<AppBarComponentScanPage> createState() =>
      _AppBarComponentScanPageState();
}

class _AppBarComponentScanPageState extends State<AppBarComponentScanPage> {
  double? _lastWindowWidth;
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey drawerKey = GlobalKey();
  OverlayEntry? aboutOverlayEntry;

  void _removeOverlay() {
    aboutOverlayEntry?.remove();
    aboutOverlayEntry = null;
  }

  void _showOverlay({required Offset position, required Widget content}) {
    _removeOverlay();

    final overlay = Overlay.of(context);

    aboutOverlayEntry = OverlayEntry(
      builder: (context) => OverlayCard(
        position: position,
        onClose: _removeOverlay,
        child: content,
      ),
    );

    overlay.insert(aboutOverlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final currentWidth = MediaQuery.of(context).size.width;

        if (_lastWindowWidth != null && _lastWindowWidth != currentWidth) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _removeOverlay();
          });
        }

        _lastWindowWidth = currentWidth;

        return SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 30, 50, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Inno Test",
                  style: TextStyle(
                    color:
                        themeProvider.isDarkTheme ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 40,
                  width: 350,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xFFF5F5F5)),
                  child: Text(
                    widget.url,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Inter"),
                  ),
                ),
                SizedBox(
                  key: drawerKey,
                  width: 40,
                  height: 40,
                  child: GestureDetector(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.menu, // <-- Drawer icon
                        size: 25,
                        color: themeProvider.isDarkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    onTap: () {
                      if (aboutOverlayEntry != null) {
                        _removeOverlay();
                        return;
                      }

                      final RenderBox renderBox = drawerKey.currentContext!
                          .findRenderObject() as RenderBox;
                      final position = renderBox.localToGlobal(Offset.zero);

                      _showOverlay(
                        position: Offset(
                            position.dx - 220, position.dy + 40), // ← было -170
                        content: DrawerCard(onClose: _removeOverlay),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
