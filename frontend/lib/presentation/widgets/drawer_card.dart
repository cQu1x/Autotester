import 'package:flutter/material.dart';
import 'package:inno_test/presentation/pages/welcome_page.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import 'custom_switch.dart';

class DrawerCard extends StatefulWidget {
  final VoidCallback onClose;

  const DrawerCard({super.key, required this.onClose});

  @override
  State<DrawerCard> createState() => _DrawerCardState();
}

class _DrawerCardState extends State<DrawerCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: 350,
        height: 300,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        decoration: BoxDecoration(
          color: themeProvider.isDarkTheme ? Color(0xFF303030) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.18 * 255).round()),
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top row with close button — уже готов у тебя
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Align(
                alignment: Alignment.topRight,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: widget.onClose,
                    child: Container(
                      width: 61,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFF5F5F5)),
                      child: Text(
                        "Close",
                        style: TextStyle(
                            color: Color(0xFF898989),
                            fontSize: 12,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Dark mode toggle row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Dark mode",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: CustomSwitch(
                    value: themeProvider.isDarkTheme,
                    onChanged: (_) => themeProvider.changeTheme(),
                  ),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(height: 1, thickness: 1),
            ),

            // How to use
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(
                "How to use",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Color(0xFF898989),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => WelcomePage(),
                ));
                widget.onClose();
              },
            ),

            const Divider(height: 1, thickness: 1), // нижняя черта
          ],
        ),
      ),
    );
  }
}
