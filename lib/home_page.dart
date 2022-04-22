import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController cWord = TextEditingController();

  Future<String> getAllQuotes(String word) async {
    final response = await http.get(
        Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/$word"));
    if (response.statusCode == 200) {
      return response.body;
    }
    return "Something Went Wrong";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cWord.text = "Book";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: const TextStyle(color: Colors.white),
          controller: cWord,
          cursorColor: Colors.white,
          decoration: const InputDecoration(
              hintText: "Search For Word",
              prefixIcon: Icon(
                Icons.work,
                color: Colors.white,
              ),
              hintStyle: TextStyle(color: Colors.white)),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: FutureBuilder(
        future: getAllQuotes(cWord.text),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.toString());
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
