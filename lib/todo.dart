class Todo {
  final String title;
  final String desc;

  Todo(this.desc,this.title);

  Map<String, dynamic> toJson() => {
    'title': title,
    'desc': desc,
  };

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      json['title'] as String,
      json['desc'] as String,
    );
  }
}