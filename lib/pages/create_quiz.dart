import 'package:midsem/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:midsem/service/database.dart';
import 'package:midsem/pages/add_questions.dart';
import 'package:midsem/widget/widget.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const CreateQuiz());
  // Create an instance of the Uuid class
  var uuid = Uuid();

  // Generate a random UUID
  String randomUuid = uuid.v4();
  print('Random UUID: $randomUuid');
}

class CreateQuiz extends StatelessWidget {
  const CreateQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Page(),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  DatabaseService databaseService = new DatabaseService(uid: Uuid().v4());

  final _formKey = GlobalKey<FormState>();

  late String quizImgUrl, quizTitle, quizDesc;

  bool isLoading = false;
  late String quizId;

  createQuiz() {
    quizId = randomAlphaNumeric(16);
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> quizData = {
        "quizImgUrl": quizImgUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDesc
      };

      databaseService.addQuizData(quizData, quizId).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AddQuestion(quizId)),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading: BackButton(
        //   color: Colors.black54,
        // ),
        title: AppLogo(),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                validator: (val) =>
                    val!.isEmpty ? "Enter Quiz Image Url" : null,
                decoration:
                    InputDecoration(hintText: "Quiz Image Url (Optional)"),
                onChanged: (val) {
                  setState(() {
                    quizImgUrl = val;
                  });
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Quiz Title" : null,
                decoration: InputDecoration(hintText: "Quiz Title"),
                onChanged: (val) {
                  setState(() {
                    quizTitle = val;
                  });
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (val) =>
                    val!.isEmpty ? "Enter Quiz Description" : null,
                decoration: InputDecoration(hintText: "Quiz Description"),
                onChanged: (val) {
                  setState(() {
                    quizDesc = val;
                  });
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  createQuiz();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Create Quiz",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
