class ToDoResponseModel {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  const ToDoResponseModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory ToDoResponseModel.fromJson(Map<String, dynamic> json) {
    return ToDoResponseModel(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'title': title,
    'completed': completed,
  };
}
