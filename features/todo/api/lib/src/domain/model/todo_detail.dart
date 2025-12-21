class TodoDetail {
  final int id;
  final String title;
  final bool completed;

  const TodoDetail({
    required this.id,
    required this.title,
    required this.completed,
  });

  TodoDetail copyWith({int? id, String? title, bool? completed}) {
    return TodoDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'completed': completed,
  };

  factory TodoDetail.fromJson(Map<String, dynamic> json) => TodoDetail(
    id: json['id'],
    title: json['title'],
    completed: json['completed'] == true,
  );
}
