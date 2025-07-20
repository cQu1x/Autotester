class TestTile {
  final String testId;
  final bool isEditing;

  TestTile({required this.testId, required this.isEditing});

  @override
  String toString() {
    return "$testId, isEditing: $isEditing";
  }
}
