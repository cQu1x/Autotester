import 'package:flutter/material.dart';
import 'package:inno_test/domain/model/test.dart';
import 'package:inno_test/presentation/widgets/component_test_dialog.dart';
import 'package:provider/provider.dart';

import '../providers/test_provider.dart';
import '../providers/theme_provider.dart';

class ComponentTestTile extends StatelessWidget {
  final String id;
  final VoidCallback onDelete;

  const ComponentTestTile(
      {super.key, required this.id, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final testProvider = Provider.of<TestProvider>(context);

    final Test? test = testProvider.getTestById(id);
    print(test == null ? "nullik" : "test");
    if (test == null) return const SizedBox();

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => ComponentTestDialog(
            existingId: id,
            initialText: test.testName,
            onSaved: (_) {},
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        height: 50, // <-- выравниваем тайл + крестик
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // <-- ВАЖНО
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              width: 287,
              decoration: BoxDecoration(
                color: const Color(0xFFCAE5FF),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                test.testName,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                testProvider.removeTest(id);
                onDelete();
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  alignment: Alignment.center,
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkTheme
                        ? const Color(0xFF898989)
                        : const Color(0xFFF5F5F5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: themeProvider.isDarkTheme
                        ? const Color(0xFFF5F5F5)
                        : const Color(0xFFB2B2B2),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
