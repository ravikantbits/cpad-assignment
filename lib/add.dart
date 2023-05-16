import 'package:assignment_ravikant/book.dart';
import 'package:assignment_ravikant/db_util.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Add extends StatefulWidget {
  const Add({super.key, required this.book});

  final Book book;

  @override
  AddState createState() {
    return AddState();
  }
}

class AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFeeeeee),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Form(
              key: _formKey,
              child: LayoutBuilder(builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * 0.04),
                          Text(
                            widget.book.id == null
                                ? "Add new book"
                                : "Modify book details",
                            style: TextStyle(
                                fontSize: 30, color: Colors.amber.shade900,
                            )
                          ),
                          SizedBox(height: height * 0.04),
                          TextFormField(
                              initialValue: widget.book.title,
                              decoration: const InputDecoration(
                                  labelText: "Book Title"),
                              validator: (value) =>
                                  value!.isEmpty ? "Enter valid title" : null,
                              onSaved: (value) => widget.book.title = value!),
                          SizedBox(height: height * 0.04),
                          TextFormField(
                              initialValue: widget.book.edition,
                              decoration: const InputDecoration(
                                  labelText: "Book Edition"),
                              validator: (value) =>
                                  value!.isEmpty ? "Enter valid edition" : null,
                              onSaved: (value) => widget.book.edition = value!),
                          SizedBox(height: height * 0.04),
                          TextFormField(
                              initialValue: widget.book.author,
                              decoration:
                                  const InputDecoration(labelText: "Author"),
                              validator: (value) => value!.isEmpty
                                  ? "Enter valid Author name"
                                  : null,
                              onSaved: (value) => widget.book.author = value!),
                          SizedBox(height: height * 0.04),
                          TextFormField(
                              initialValue: widget.book.publisher,
                              decoration:
                                  const InputDecoration(labelText: "Publisher"),
                              validator: (value) => value!.isEmpty
                                  ? "Enter valid Publisher"
                                  : null,
                              onSaved: (value) =>
                                  widget.book.publisher = value!),
                          SizedBox(height: height * 0.04),
                          TextFormField(
                              initialValue: widget.book.publishedOn,
                              decoration: const InputDecoration(
                                  labelText: "Year of publish"),
                              validator: (value) =>
                                  value!.isEmpty ? "Enter valid year" : null,
                              onSaved: (value) =>
                                  widget.book.publishedOn = value!),
                          SizedBox(height: height * 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // GestureDetector(
                              //   onTap: () => Navigator.pop(context),
                              //   child: const Text(
                              //     "< Back",
                              //     style: TextStyle(
                              //         fontSize: 22, color: Colors.indigo),
                              //   ),
                              // ),
                              NeumorphicButton(
                                margin: const EdgeInsets.only(top: 12),
                                onPressed: () => Navigator.pop(context),
                                style: NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.roundRect(const BorderRadius.all(Radius.circular(5))),
                                  color: Colors.amber.shade900,
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                ),
                              ),
                              NeumorphicButton(
                                margin: const EdgeInsets.only(top: 12),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState?.save();

                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 30.0, bottom: 30.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const CircularProgressIndicator(),
                                                SizedBox(height: height * 0.04),
                                                const Text("Saving ..."),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                    DBUtil.upsert(widget.book).then((value) {
                                      print("ID: $value");

                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(widget.book.id ==
                                                      null
                                                  ? "${widget.book.title} added !"
                                                  : "Details updated for ${widget.book.title} !")));
                                      widget.book.id = value;
                                      Navigator.pop(context);
                                    });

                                    // Future.delayed(const Duration(seconds: 3),
                                    //     () {
                                    //   Navigator.pop(context); //pop dialog
                                    // });
                                  }
                                },
                                style: NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.roundRect(const BorderRadius.all(Radius.circular(5))),
                                  color: Colors.green,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })),
        ),
      ),
    );
  }
}
