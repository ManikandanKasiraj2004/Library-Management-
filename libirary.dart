// Abstract Media class
abstract class Media {
  String title;
  int year;

  Media(this.title, this.year);

  void displayDetails(); // Abstract method
}

// Subclass Book
class Book extends Media {
  String author;
  int stock; // Added stock for books

  Book(String title, int year, this.author, {this.stock = 0}) : super(title, year);

  @override
  void displayDetails() {
    print('Book: $title ($year), by $author, Stock: $stock');
  }
}

// Subclass Magazine
class Magazine extends Media {
  int issueNumber;

  Magazine(String title, int year, this.issueNumber) : super(title, year);

  @override
  void displayDetails() {
    print('Magazine: $title ($year), Issue $issueNumber');
  }
}
