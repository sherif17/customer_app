class questionInfo {
  final int position;
  final String name;
  final String description;

  questionInfo(
    this.position, {
    this.name,
    this.description,
  });
}

List<questionInfo> questions = [
  questionInfo(
    1,
    name: 'question1',
    description: "Can I Help You ?",
  ),
  questionInfo(2, name: 'question2', description: " Can I Help You ?"),
  questionInfo(3, name: 'question3', description: " Can I Help You ?"),
  questionInfo(4, name: 'question4', description: " Can I Help You ?"),
  questionInfo(5, name: 'question5', description: " Can I Help You ?"),
  questionInfo(6, name: 'question6', description: " Can I Help You ?"),
  questionInfo(7, name: 'question7', description: " Can I Help You ?"),
  questionInfo(8, name: 'question8', description: " Can I Help You ?"),
  questionInfo(9, name: 'question9', description: " Can I Help You ?"),
  questionInfo(10, name: 'question10', description: " Can I Help You ?"),
];
