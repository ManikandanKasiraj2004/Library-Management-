import 'dart:io';

                        //main function

void main() {
  var library = Library();

  while (true) {
    print('\nLibrary Menu:');
    print('1. Add Book');
    print('2. Update Book');
    print('3. Remove Book');
    print('4. Display All Media');
    print('5. Display Books');
    print('6. Add Magazine');
    print('7. Update Magazine');
    print('8. Remove Magazine');
    print('9. Display Magazines');
    print('10. Borrow a Book');
    print('11. Return a Book');
    print('12. Register User');
    print('13. Exit');
    stdout.write('Enter your choice: ');

    var choice = int.tryParse(stdin.readLineSync()!) ?? 0;

    switch (choice) {
      case 1:
        stdout.write('Enter book title: ');
        var title = stdin.readLineSync()!;
        stdout.write('Enter book author: ');
        var author = stdin.readLineSync()!;
        stdout.write('Enter book year: ');
        var year = int.tryParse(stdin.readLineSync()!) ?? 0;
        stdout.write('Enter book stock: ');
        var stock = int.tryParse(stdin.readLineSync()!) ?? 0;
        var newBook = Book(title, year, author, stock);
        library.addMedia(newBook);
        break;
      case 2:
        stdout.write('Enter the title of the book to update: ');
        var updateTitle = stdin.readLineSync()!;
        stdout.write('Enter the year of the book to update: ');
        var updateYear = int.tryParse(stdin.readLineSync()!) ?? 0;
        stdout.write('Enter new title (leave blank to keep current): ');
        var newTitle = stdin.readLineSync()!;
        stdout.write('Enter new year (0 to keep current): ');
        var newYear = int.tryParse(stdin.readLineSync()!) ?? 0;
        library.updateMedia(updateTitle, updateYear, newTitle: newTitle.isNotEmpty ? newTitle : null, newYear: newYear != 0 ? newYear : null);
        break;
      case 3:
        stdout.write('Enter the title of the book to remove: ');
        var removeTitle = stdin.readLineSync()!;
        stdout.write('Enter the year of the book to remove: ');
        var removeYear = int.tryParse(stdin.readLineSync()!) ?? 0;
        library.removeMedia(removeTitle, removeYear);
        break;
      case 4:
        library.displayAllMedia();
        break;
      case 5:
        library.displayBooks();
        break;
      case 6:
        stdout.write('Enter magazine title: ');
        var title = stdin.readLineSync()!;
        stdout.write('Enter magazine issue number: ');
        var issueNumber = int.tryParse(stdin.readLineSync()!) ?? 0;
        stdout.write('Enter magazine year: ');
        var year = int.tryParse(stdin.readLineSync()!) ?? 0;
        stdout.write('Enter magazine stock: ');
        var stock = int.tryParse(stdin.readLineSync()!) ?? 0;
        var newMagazine = Magazine(title, year, issueNumber, stock);
        library.addMedia(newMagazine);
        break;
      case 7:
        stdout.write('Enter the title of the magazine to update: ');
        var updateTitle = stdin.readLineSync()!;
        stdout.write('Enter the year of the magazine to update: ');
        var updateYear = int.tryParse(stdin.readLineSync()!) ?? 0;
        stdout.write('Enter new title (leave blank to keep current): ');
        var newTitle = stdin.readLineSync()!;
        stdout.write('Enter new year (0 to keep current): ');
        var newYear = int.tryParse(stdin.readLineSync()!) ?? 0;
        library.updateMedia(updateTitle, updateYear, newTitle: newTitle.isNotEmpty ? newTitle : null, newYear: newYear != 0 ? newYear : null);
        break;
      case 8:
        stdout.write('Enter the title of the magazine to remove: ');
        var removeTitle = stdin.readLineSync()!;
        stdout.write('Enter the year of the magazine to remove: ');
        var removeYear = int.tryParse(stdin.readLineSync()!) ?? 0;
        library.removeMedia(removeTitle, removeYear);
        break;
      case 9:
        library.displayMagazines();
        break;
      case 10:
        stdout.write('Enter your name: ');
        var userName = stdin.readLineSync()!;
        stdout.write('Enter book title: ');
        var title = stdin.readLineSync()!;
        stdout.write('Enter book year: ');
        var year = int.tryParse(stdin.readLineSync()!) ?? 0;
        library.borrowMedia(userName, title, year);
        break;
      case 11:
        stdout.write('Enter book title: ');
        var returnTitle = stdin.readLineSync()!;
        stdout.write('Enter book year: ');
        var returnYear = int.tryParse(stdin.readLineSync()!) ?? 0;
        library.returnMedia(returnTitle, returnYear);
        break;
      case 12:
        stdout.write('Enter your name: ');
        var userName = stdin.readLineSync()!;
        var newUser = User(userName);
        library.addUser(newUser);
        print('User $userName registered successfully.');
        break;
      case 13:
        print('Exiting library system.');
        return;
      default:
        print('Invalid choice. Please enter a number between 1 and 13.');
    }
  }
}


                        //abstract class

abstract class Media {
  String title;int year;User? borrower;DateTime? dueDate;
  Media(this.title, this.year);
  void displayDetails();
  bool isBorrowed() {
    return borrower != null;
  }
  void borrow(User user) {
    borrower = user;dueDate = DateTime.now().add(Duration(days: 14));
  }
  bool returnMedia() {
    if (borrower != null) {borrower!.returnMedia(this);borrower = null;dueDate = null;
      return true;
    }
    return false;
  }
  bool isOverdue() {
    if (dueDate != null) {
      return DateTime.now().isAfter(dueDate!);
    }
    return false;
  }
  int calculatePenaltyDays() {
    if (isOverdue()) {
      return DateTime.now().difference(dueDate!).inDays;
    }
    return 0;
  }
}

                                          // Book subclass


class Book extends Media {
  String author;int stock;
  Book(String title, int year, this.author, this.stock) : super(title, year);
  @override
  void displayDetails() {
    print('Book: $title, Author: $author, Year: $year, Stock: $stock');
  }
}

                                          // Magazine subclass

class Magazine extends Media {
  int issueNumber;
  int stock;

  Magazine(String title, int year, this.issueNumber, this.stock) : super(title, year);

  @override
  void displayDetails() {
    print('Magazine: $title, Issue Number: $issueNumber, Year: $year, Stock: $stock');
  }
}

                                               // User class

class User {
  String name;
  Map<String, List<Media>> borrowedBooks;

  User(this.name) : borrowedBooks = {};

  void borrowMedia(Media media) {
    String category = media is Book ? 'Books' : 'Magazines';
    if (!borrowedBooks.containsKey(category)) {
      borrowedBooks[category] = [];
    }
    borrowedBooks[category]!.add(media);
  }

  bool returnMedia(Media media) {
    String category = media is Book ? 'Books' : 'Magazines';
    if (borrowedBooks.containsKey(category)) {
      bool removed = borrowedBooks[category]!.remove(media);
      if (borrowedBooks[category]!.isEmpty) {
        borrowedBooks.remove(category);
      }
      return removed;
    }
    return false;
  }

  bool hasBorrowed(Media media) {
    String category = media is Book ? 'Books' : 'Magazines';
    return borrowedBooks.containsKey(category) && borrowedBooks[category]!.contains(media);
  }

  List<Media> getBorrowedBooks() {
    List<Media> allBorrowed = [];
    borrowedBooks.values.forEach((list) => allBorrowed.addAll(list));
    return allBorrowed;
  }
}

                                        // Library class
class Library {
  Set<Media> mediaCollection = {};
  List<User> users = [];

  void addMedia(Media media) {
    mediaCollection.add(media);
    print('Media added successfully.');
  }

  void updateMedia(String title, int year, {String? newTitle, int? newYear}) {
    Media? mediaToUpdate = findMediaByTitleAndYear(title, year);
    if (mediaToUpdate != null) {
      if (newTitle != null) mediaToUpdate.title = newTitle;
      if (newYear != null) mediaToUpdate.year = newYear;
      print('Media updated successfully.');
    } else {
      print('Media not found.');
    }
  }

  void removeMedia(String title, int year) {
    Media? mediaToRemove = findMediaByTitleAndYear(title, year);
    if (mediaToRemove != null) {
      mediaCollection.remove(mediaToRemove);
      print('Media removed successfully.');
    } else {
      print('Media not found.');
    }
  }

  void displayAllMedia() {
    for (var media in mediaCollection) {
      media.displayDetails();
    }
  }

  void displayBooks() {
    print('\nBooks in the library:');
    mediaCollection.whereType<Book>().forEach((book) {
      book.displayDetails();
    });
  }

  void displayMagazines() {
    print('\nMagazines in the library:');
    mediaCollection.whereType<Magazine>().forEach((magazine) {
      magazine.displayDetails();
    });
  }

  Media findMediaByTitleAndYear(String title, int year) {
    var media = mediaCollection.firstWhere(
          (media) => media.title == title && media.year == year,
      orElse: () => Book('Unknown', 0, 'Unknown Author', 0),
    );
    return media;
  }

  User findUserByName(String name) {
    var user = users.firstWhere((user) => user.name == name, orElse: () => User('Unknown'));
    return user;
  }

  void addUser(User user) {
    users.add(user);
  }

  void borrowMedia(String userName, String title, int year) {
    User? user = findUserByName(userName);
    if (user == null) {
      print('User not found. Please register first.');
      return;
    }

    Media? media = findMediaByTitleAndYear(title, year);
    if (media == null) {
      print('Media not found.');
      return;
    }

    if (media.isBorrowed()) {
      print('This media is already borrowed.');
      return;
    }

    media.borrow(user);
    user.borrowMedia(media);
    print('Borrowed successfully.');
  }

  void returnMedia(String title, int year) {
    Media? media = findMediaByTitleAndYear(title, year);
    if (media == null) {
      print('Media not found.');
      return;
    }
    User? borrower = media.borrower;
    if (borrower == null) {
      print('No user has borrowed this media.');
      return;
    }
    print('Return Media:');
    media.displayDetails();
    print('Borrower Information:');
    print('User: ${borrower.name}');
    print('Borrowed Books:');
    borrower.getBorrowedBooks().forEach((borrowedMedia) {
      borrowedMedia.displayDetails();
    });

    bool returned = media.returnMedia();
    if (returned) {
      int penaltyDays = media.calculatePenaltyDays();
      if (penaltyDays > 0) {
        print('Returned late! Penalty: $penaltyDays days');
      } else {
        print('Returned successfully.');
      }
    } else {
      print('Error in returning media.');
    }
  }
}

