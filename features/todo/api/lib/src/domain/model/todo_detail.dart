class TodoDetail {
  final int id;
  final String title;
  final bool completed;

  const TodoDetail({
    required this.id,
    required this.title,
    required this.completed,
  });

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
