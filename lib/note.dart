class Note{
  int id;
  int priority;
  String subject;
  String description;

  Note({required this.id, required this.priority, required this.subject, required this.description});

  // note from map
  factory Note.fromMap(Map<String, dynamic> element){
    return Note(
      id : element['id'],
      priority :  element['priority'],
      subject : element['subject'],
      description : element['description'],
    );
  }

}