import 'package:midsem/pages/modQuiz.dart';
import 'package:midsem/service/database.dart';
import 'package:midsem/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Administrator extends StatefulWidget {
  const Administrator({super.key});

  @override
  State<Administrator> createState() => _AdministratorState();
}

class _AdministratorState extends State<Administrator> {
  int myIndex = 0;
  late Stream<QuerySnapshot<Map<String, dynamic>>> quizStream;
  late DatabaseService databaseService;

  Widget quizList() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: StreamBuilder(
          stream: quizStream,
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            return snapshot.data == null
                ? Container()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemExtent: 180,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 16.0),
                            child: QuizTile(
                              noOfQuestions: snapshot.data!.docs.length,
                              imageUrl: snapshot.data!.docs[index]
                                  .data()['quizImgUrl'],
                              title: snapshot.data!.docs[index]
                                  .data()['quizTitle'],
                              description:
                                  snapshot.data!.docs[index].data()['quizDesc'],
                              id: snapshot.data!.docs[index].id,
                            ),
                          ),
                          Divider(
                            color: Theme.of(context)
                                .primaryColor, // Use the color of your theme
                            thickness: 2.0, // Adjust the thickness as needed
                            height: 2, // Use 0 to get a full line
                          ),
                        ],
                      );
                    },
                  );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    // Initialize the database service with a unique ID
    databaseService = DatabaseService(uid: Uuid().v4());

    // Initialize quizStream with an empty stream
    quizStream = Stream.empty();

    // Load quiz data into quizStream
    databaseService.getQuizData2().then((value) {
      setState(() {
        quizStream = value;
      });
    });
    super.initState();

    databaseService.getQuizData2().then((value) {
      quizStream = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppLogo(),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: quizList(),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String? imageUrl, title, id, description;
  final int noOfQuestions;

  QuizTile({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.id,
    required this.noOfQuestions,
  });

  @override
  Widget build(BuildContext context) {
    // Store the quizId
    String quizId = id ?? ""; // Default value if id is null

    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ModifyQuizPage(quizId: quizId),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Image.network(
                imageUrl ?? "", // Use a default value if imageUrl is null
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                color: Colors.black26,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title ?? "", // Use a default value if title is null
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        description ??
                            "", // Use a default value if description is null
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
