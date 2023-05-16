import 'package:assignment_ravikant/add.dart';
import 'package:assignment_ravikant/book.dart';
import 'package:assignment_ravikant/db_util.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  void loadBooks() {
    DBUtil.getBooks().then((value) {
      setState(() {
        books = [];
        for (var element in value) {
          books.add(Book.fromMap(element));
        }
      });
    }).catchError((error) {
      print("Error in DB call: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFeeeeee),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),
              Text(
                "Book Shelf",
                style: TextStyle(fontSize: 30, color: Colors.amber.shade900),
              ),
              SizedBox(height: height * 0.01),
              Expanded(
                child: books.isEmpty
                    ? Center(
                        child: Text(
                          "No book available !",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (ctx, index) {
                          return Card(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 8.0,
                                  top: 8.0,
                                  bottom: 28.0),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset('images/books.png',
                                              height: height * 0.06),
                                          // const Icon(
                                          //   Icons.menu_book,
                                          //   size: 64,
                                          //   color: Colors.amberAccent,
                                          // ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  books[index].title ?? '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                ),
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      books[index].author ?? '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,
                                                    ),
                                                    Text(
                                                      books[index].publisher ??
                                                          '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: height * 0.005,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      books[index].edition ??
                                                          '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium,
                                                    ),
                                                    Text(
                                                      books[index]
                                                              .publishedOn ??
                                                          '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.indigo,
                                          ),
                                          onTap: () => Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child: Add(
                                                          book: books[index])))
                                              .then((_) => loadBooks()),
                                        ),
                                        SizedBox(
                                          height: height * 0.001,
                                        ),
                                        GestureDetector(
                                          child: const Icon(
                                            Icons.delete_forever,
                                            color: Colors.deepOrange,
                                          ),
                                          onTap: () {
                                            Book toDelete = books[index];
                                            showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            'Do you want to delete \'${toDelete.title}\'?',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium,
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                height * 0.01,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () =>
                                                                    Navigator.pop(
                                                                        context),
                                                                child:
                                                                    const Text(
                                                                  "Cancel",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .indigo),
                                                                ),
                                                              ),
                                                              ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    DBUtil.deleteBook(
                                                                            toDelete)
                                                                        .then(
                                                                            (value) {
                                                                      if (value ==
                                                                          1) {
                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                            content:
                                                                                Text("${toDelete.title} deleted !")));
                                                                        loadBooks();
                                                                        Navigator.pop(
                                                                            context);
                                                                      } else {
                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                            content:
                                                                                Text("Unable to delete ${toDelete.title} !")));
                                                                        Navigator.pop(
                                                                            context);
                                                                      }
                                                                    }).catchError(
                                                                            (error) {
                                                                      print(
                                                                          "Error in delete: $error");
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              SnackBar(content: Text("Unable to delete ${toDelete.title} !")));
                                                                      Navigator.pop(
                                                                          context);
                                                                    });
                                                                  },
                                                                  style: ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all(Colors
                                                                              .deepOrange),
                                                                      foregroundColor:
                                                                          MaterialStateProperty.all(Colors
                                                                              .white)),
                                                                  child: const Text(
                                                                      'Delete'))
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                          // return ListTile(
                          //   title: Text(books[index].title ?? ''),
                          //   leading: Text(books[index].id.toString()),
                          // );
                        },
                        itemCount: books.length,
                      ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Add(book: Book())))
            .then((_) => loadBooks()),
        tooltip: 'Add Book',
        backgroundColor: Colors.amber.shade900,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
