class Task {
  final String id;
  final String name;
  final String description;
  final int percentage;
  final String status;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.percentage,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'],
      percentage: json['percentage'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'percentage': percentage,
      'status': status,
    };
  }
}