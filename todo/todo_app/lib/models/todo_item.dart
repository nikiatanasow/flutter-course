class TodoItem {
  final String title;
  final String details;
  final bool isCompleted;
  final String id;

  const TodoItem({this.title, this.details, this.isCompleted, this.id});

  TodoItem copy({String title, String details, bool isCompleted}) {
    return TodoItem(
        title: title ?? this.title,
        details: details ?? this.details,
        isCompleted: isCompleted ?? this.isCompleted,
        id: this.id);
  }

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['_id'],
      title: json['title'],
      details: json['description'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'title': title, 'description': details, 'isCompleted': isCompleted};
}
