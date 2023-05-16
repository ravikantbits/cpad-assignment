class Book {
  int? id;
  String? title;
  String? edition;
  String? author;
  String? publisher;
  String? publishedOn;

  Book(
      {this.id,
      this.title,
      this.edition,
      this.author,
      this.publisher,
      this.publishedOn});

  static Book fromMap(Map<String, dynamic> data) {
    return Book(
        id: data['id'],
        title: data['title'],
        edition: data['edition'],
        author: data['author'],
        publisher: data['publisher'],
        publishedOn: data['publishedOn']);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "edition": edition,
      "author": author,
      "publisher": publisher,
      "publishedOn": publishedOn
    };
  }
}
