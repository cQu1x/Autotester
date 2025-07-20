import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/model/test.dart';
import '../providers/test_provider.dart';

class ComponentTestDialog extends StatefulWidget {
  final String? initialText;
  final String? existingId; // если редактируем
  final void Function(String newId)? onSaved;

  const ComponentTestDialog({
    super.key,
    this.initialText,
    this.existingId,
    this.onSaved,
  });

  @override
  State<ComponentTestDialog> createState() => _ComponentTestDialogState();
}

class _ComponentTestDialogState extends State<ComponentTestDialog> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final double _minHeight = 80;
  final double _maxHeight = 250;
  double _currentHeight = 80;

  bool _canSubmit = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialText ?? "";
    _controller.addListener(() {
      _adjustHeight();
      _updateCanSubmit(); // 👈 проверяем наличие текста
    });
    _adjustHeight();
    _updateCanSubmit();
  }

  void _updateCanSubmit() {
    final text = _controller.text.trim();
    setState(() {
      _canSubmit = text.isNotEmpty;
    });
  }

  void _adjustHeight() {
    final span = TextSpan(
      text: _controller.text,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        fontFamily: "Inter",
      ),
    );

    final tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      maxLines: null,
    );

    tp.layout(maxWidth: 500 - 60);
    final newHeight = tp.size.height + 60;

    setState(() {
      _currentHeight = newHeight.clamp(_minHeight, _maxHeight);
    });
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final provider = Provider.of<TestProvider>(context, listen: false);

    if (widget.existingId != null) {
      provider.removeTest(widget.existingId!);
    }

    final id =
        widget.existingId ?? "${DateTime.now().microsecondsSinceEpoch}|comp";
    provider.addTest(Test(testName: text, id: id));
    widget.onSaved?.call(id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFF5F5F5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add integration test",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: _currentHeight,
              child: (_currentHeight >= _maxHeight)
                  ? Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: _buildTextField(),
                      ),
                    )
                  : _buildTextField(),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _canSubmit ? _submit : null,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _canSubmit
                          ? const Color(0xFF0088FF)
                          : const Color(0xFFD9D9D9), // 🔥 серый если нельзя
                    ),
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: _controller,
      maxLines: null,
      cursorColor: const Color(0xFF0088FF),
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        fontFamily: "Inter",
      ),
      decoration: const InputDecoration(
        hintText: "Type your test...",
        hintStyle: TextStyle(
          color: Color(0xFF898989),
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
        border: InputBorder.none,
        isCollapsed: true,
      ),
    );
  }
}
