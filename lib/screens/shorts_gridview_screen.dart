import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gro_care_assignment_app/screens/shorts_main_screen.dart';
import 'package:http/http.dart' as http;
import '../models/shorts_model.dart';

class ShortsGridViewScreen extends StatefulWidget {
  final String categoryName;
  const ShortsGridViewScreen({Key? key, required this.categoryName})
      : super(key: key);

  @override
  State<ShortsGridViewScreen> createState() => _ShortsGridViewScreenState();
}

class _ShortsGridViewScreenState extends State<ShortsGridViewScreen> {
  Future<ShortsModel> getShortsData() async {
    final response = await http.get(
        Uri.parse('https://internship-service.onrender.com/videos?page=2'));
    var responseData = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(ShortsModel.fromJson(responseData));
      }
    } else {
      throw Exception('Failed to load');
    }
    return ShortsModel.fromJson(responseData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          widget.categoryName,
          style: const TextStyle(
            color: Color(0xff0017B5),
            fontSize: 25,
          ),
        ),
      ),
      body: FutureBuilder<ShortsModel>(
          future: getShortsData(),
          builder: (context, snapshot) {
            return (snapshot.hasData)
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                    ),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 25,
                        mainAxisSpacing: 15,
                        mainAxisExtent: 250,
                      ),
                      itemCount: snapshot.data?.data.posts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ShortsMainScreen(
                                postDetails: snapshot.data!.data.posts,
                                 startIndex: index,
                              ),
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.greenAccent,
                              image: DecorationImage(
                                image: NetworkImage(snapshot.data!.data
                                    .posts[index].submission.thumbnail
                                    .toString()),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const Center(
                    child: SpinKitSpinningLines(
                      color: Colors.greenAccent,
                      size: 200,
                      lineWidth: 3,
                    ),
                  );
          }),
    );
  }
}
