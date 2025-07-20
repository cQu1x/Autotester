import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inno_test/data/repositories/test_repository.dart';
import 'package:inno_test/domain/model/test.dart';

class InMemoryTestRepository extends TestRepository {
  final List<Test> _tests = [];

  @override
  Future<List<TestResult>> sendUrlForScan(
      {required String url,
      required List<String> tests,
      required bool designTest}) async {
    final response = await http.post(
      Uri.parse('https://innotest.tech/api/tests'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'url': url, 'tests': tests, 'needUIUX': designTest}),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = json['data'] as List<dynamic>;
      return data
          .map((e) => TestResult(
                test: e['test'],
                result: e['result'],
              ))
          .toList();
    } else {
      throw Exception('Failed to scan URL');
    }
  }

  @override
  void addTest(Test test) {
    _tests.add(test);
  }

  @override
  void removeTest(String id) {
    _tests.removeWhere((test) => test.id == id);
  }

  @override
  void removeAllTests() {
    _tests.clear();
  }

  @override
  List<Test> getTests() {
    return _tests;
  }
}
