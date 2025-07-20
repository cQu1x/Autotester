import 'package:flutter/material.dart';
import 'package:inno_test/domain/model/test.dart';
import 'package:inno_test/presentation/pages/home_page.dart';
import 'package:inno_test/presentation/providers/test_provider.dart';
import 'package:inno_test/presentation/widgets/appbars/appbar_component_scan_page.dart';
import 'package:provider/provider.dart';

class ComponentTestPage extends StatefulWidget {
  final String url;
  final List<String> tiles;

  const ComponentTestPage({super.key, required this.url, required this.tiles});

  @override
  State<ComponentTestPage> createState() => _ComponentTestPageState();
}

class _ComponentTestPageState extends State<ComponentTestPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final double _minHeight = 100;
  final double _maxHeight = 250;
  double _currentHeight = 100;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_adjustHeight);
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

    tp.layout(maxWidth: 500 - 60); // padding left + right = 30 + 30

    final newHeight = tp.size.height +
        60 +
        (_controller.text.length > 40 ? 45 : 0); // + extra for padding/buttons
    setState(() {
      _currentHeight = newHeight.clamp(_minHeight, _maxHeight);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _redirectHomePage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => HomePage(
        tiles: widget.tiles,
      ),
    ));
  }

  void _addComponentTest(String trim, TestProvider provider) {
    var id = DateTime.now().microsecondsSinceEpoch.toString();
    id += "|comp";
    widget.tiles.insert(0, id);
    provider.addTest(Test(testName: "${_controller.text.trim()}|comp", id: id));
  }

  @override
  Widget build(BuildContext context) {
    final testProvider = Provider.of<TestProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBarComponentScanPage(url: widget.url),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Hello, what are we testing today?",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: 500,
              height: _currentHeight + 20,
              padding: const EdgeInsets.only(
                  left: 30, top: 20, right: 30, bottom: 15),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: (_currentHeight >= _maxHeight)
                        ? Scrollbar(
                            controller: _scrollController,
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              reverse: true,
                              child: TextField(
                                controller: _controller,
                                cursorColor: const Color(0xFF0088FF),
                                maxLines: null,
                                decoration: const InputDecoration(
                                  hintText: 'Type something',
                                  border: InputBorder.none,
                                  isCollapsed: true,
                                  hintStyle: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xFF898989),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Inter",
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ),
                          )
                        : TextField(
                            controller: _controller,
                            cursorColor: const Color(0xFF0088FF),
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: 'Type something',
                              border: InputBorder.none,
                              isCollapsed: true,
                              hintStyle: TextStyle(
                                fontSize: 17,
                                color: Color(0xFF898989),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Inter",
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                            ),
                          ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: _redirectHomePage,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            height: 35,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(100)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  color: Color(0xFFF5F5F5),
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Back",
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFF5F5F5)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _addComponentTest(
                              _controller.text.trim(), testProvider);
                          _redirectHomePage();
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFD9D9D9),
                            ),
                            child: Icon(
                              Icons.arrow_upward,
                              color: Color(0xFFF5F5F5),
                            ),
                          ),
                        ),
                      )
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
