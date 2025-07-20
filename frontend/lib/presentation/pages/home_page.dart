import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inno_test/domain/enums/test_variant_type.dart';
import 'package:inno_test/presentation/pages/design_page.dart';
import 'package:inno_test/presentation/providers/test_provider.dart';
import 'package:inno_test/presentation/widgets/appbars/appbar_home_page.dart';
import 'package:inno_test/presentation/widgets/attribute_check_tile.dart';
import 'package:inno_test/presentation/widgets/scenario_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/theme_provider.dart';
import '../widgets/component_test_dialog.dart';
import '../widgets/component_test_tile.dart';
import '../widgets/smart_input_tile.dart';

class HomePage extends StatefulWidget {
  final List<String> tiles;

  const HomePage({super.key, required this.tiles});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  bool sendButtonStyle = false;
  bool _isUrlInvalid = false;

  late AnimationController _animationController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -6.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -6.0, end: 6.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 6.0, end: -2.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -2.0, end: 2.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 2.0, end: 0.0), weight: 1),
    ]).animate(_animationController);

    textEditingController.addListener(() {
      if (textEditingController.text.isEmpty && _isUrlInvalid) {
        setState(() {
          _isUrlInvalid = false;
        });
      }
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void errorInUrl() {
    setState(() {
      _isUrlInvalid = true;
    });
    _animationController.forward(from: 0);
  }

  Future<void> sendUrl(TestProvider testProvider) async {
    final url = textEditingController.text.trim();

    if (url.isEmpty || widget.tiles.isEmpty) {
      errorInUrl();
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8081/api/checkurl'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'url': url}),
      );
      print("${response.body} wtf");
      final setCookie = response.headers['set-cookie'];
      if (setCookie != null && setCookie.contains('instructions shown=true')) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('instructions_shown', true);
      }

      final data = json.decode(response.body);

      if (data['status'] == 'success') {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DesignPage(
            url: url,
            tests: testProvider.getTests().map((e) => e.testName).toList(),
          ),
        ));
      } else {
        errorInUrl();
      }
    } catch (e) {
      print(e.toString());
      errorInUrl();
    }
  }

  void onScenarioButtonPressed(
      TestProvider testProvider, TestVariantType type) {
    var id = DateTime.now().microsecondsSinceEpoch.toString();
    id += (type == TestVariantType.existence)
        ? "|ex"
        : ((type == TestVariantType.attributeCheck)
            ? "|attr"
            : ((type == TestVariantType.interactionCheck) ? "|int" : "|comp"));
    setState(() {
      if (testProvider.getTests().length == widget.tiles.length) {
        widget.tiles.insert(0, id);
      }
    });

    Future.delayed(Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _redirectComponentScanDialog() {
    showDialog(
      context: context,
      builder: (_) => ComponentTestDialog(
        onSaved: (newId) {
          setState(() {
            widget.tiles.insert(0, newId);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final testProvider = Provider.of<TestProvider>(context);
    print('tiles: ${widget.tiles}');
    print('tests in provider: ${testProvider.getTests().map((e) => e.id)}');

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), child: AppBarHomePage()),
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    "Hello, what are we testing today?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double maxWidth = constraints.maxWidth > 500
                          ? 500
                          : constraints.maxWidth * 0.9;

                      return AnimatedBuilder(
                        animation: _shakeAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                                _isUrlInvalid ? _shakeAnimation.value : 0, 0),
                            child: child,
                          );
                        },
                        child: Container(
                          width: maxWidth,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: themeProvider.isDarkTheme
                                ? const Color(0xFF303030)
                                : const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: _isUrlInvalid
                                  ? const Color(0xFFFF383C)
                                  : Colors.transparent,
                              width: 0.8,
                            ),
                          ),
                          child: TextFormField(
                            style: TextStyle(fontWeight: FontWeight.w500),
                            onChanged: (text) {
                              setState(() {});
                            },
                            onFieldSubmitted: (text) {
                              sendUrl(testProvider);
                            },
                            cursorColor: Color(0xFF0088FF),
                            controller: textEditingController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              hintStyle: const TextStyle(
                                  color: Color(0xFF898989),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Inter"),
                              hintText: "Paste link",
                              border: InputBorder.none,
                              suffixIcon: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: (testProvider.getTests().isNotEmpty &&
                                          textEditingController.text
                                              .trim()
                                              .isNotEmpty)
                                      ? const Color(0xFF0088FF)
                                      : const Color(0xFFD9D9D9),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    sendUrl(testProvider);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_upward,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScenarioButton(
                        onPressed: () {
                          onScenarioButtonPressed(
                              testProvider, TestVariantType.existence);
                        },
                        text: "Existence",
                        type: TestVariantType.existence,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      ScenarioButton(
                        onPressed: () {
                          onScenarioButtonPressed(
                              testProvider, TestVariantType.attributeCheck);
                        },
                        text: "Correctness",
                        type: TestVariantType.attributeCheck,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      ScenarioButton(
                        onPressed: () {
                          onScenarioButtonPressed(
                              testProvider, TestVariantType.interactionCheck);
                        },
                        text: "Clickability",
                        type: TestVariantType.interactionCheck,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      ScenarioButton(
                        onPressed: _redirectComponentScanDialog,
                        text: "Integration",
                        type: TestVariantType.componentScan,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 140),
                    child: Column(
                      children: widget.tiles.map((tileId) {
                        final idParts = tileId.split('|');
                        final id = idParts[0];
                        final type = idParts[1];

                        if (type == 'attr') {
                          return AttributeCheckTile(
                            key: ValueKey(tileId),
                            id: id,
                            onDelete: () {
                              setState(() {
                                widget.tiles.remove(tileId);
                              });
                            },
                          );
                        } else if (type == "ex") {
                          return SmartInputTile(
                            key: ValueKey(tileId),
                            id: id,
                            onDelete: () {
                              setState(() {
                                widget.tiles.remove(tileId);
                              });
                            },
                            type: TestVariantType.existence,
                          );
                        } else if (type == "int") {
                          return SmartInputTile(
                            key: ValueKey(tileId),
                            id: id,
                            onDelete: () {
                              setState(() {
                                widget.tiles.remove(tileId);
                              });
                            },
                            type: TestVariantType.interactionCheck,
                          );
                        } else {
                          return ComponentTestTile(
                            key: ValueKey(tileId),
                            id: tileId,
                            onDelete: () {
                              setState(() {
                                widget.tiles.remove(tileId);
                              });
                            },
                          );
                        }
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 50),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: widget.tiles.isEmpty
                  ? Text("")
                  : GestureDetector(
                      onTap: () {
                        testProvider.removeAllTests();
                        setState(() {
                          widget.tiles.clear();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: themeProvider.isDarkTheme
                                ? Color(0xFF303030)
                                : Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(45)),
                        width: 193,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            const Text(
                              'Delete all tests',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
