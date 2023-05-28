import 'dart:convert';
import '../models/shorts_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gro_care_assignment_app/widgets/category_thumbnail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> thumbnailUrlList = [];

  Future<ShortsModel> getShortsData() async {
    final response = await http.get(
        Uri.parse('https://internship-service.onrender.com/videos?page=2'));
    var responseData = jsonDecode(response.body.toString());

    List<String> tempList = [];
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(ShortsModel.fromJson(responseData).data.posts);
      }
      for (int index = 0; index < 5; index++) {
        tempList.add(ShortsModel.fromJson(responseData)
            .data
            .posts[index]
            .submission
            .thumbnail
            .toString());
      }
    } else {
      throw Exception('Failed to load');
    }
    setState(() {
      thumbnailUrlList = tempList;
    });
    return ShortsModel.fromJson(responseData);
  }

  @override
  void initState() {
    super.initState();
    getShortsData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 23,
                  child: Image.asset(
                    'assets/images/wybe_logo_v3.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            if (thumbnailUrlList.isNotEmpty)
              Expanded(
                child: SizedBox(
                  child: SingleChildScrollView(
                    // controller: ,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CategoryThumbnail(
                          categoryName: 'Favourites',
                          thumbnailList: thumbnailUrlList,
                          thumbnailListSize: 228,
                        ),
                        CategoryThumbnail(
                          categoryName: 'Love',
                          thumbnailList: thumbnailUrlList,
                          thumbnailListSize: 77,
                        ),
                        CategoryThumbnail(
                          categoryName: 'Travel',
                          thumbnailList: thumbnailUrlList,
                          thumbnailListSize: 101,
                        ),
                        CategoryThumbnail(
                          categoryName: 'Funny',
                          thumbnailList: thumbnailUrlList,
                          thumbnailListSize: 42,
                        ),
                        CategoryThumbnail(
                          categoryName: 'Motivational',
                          thumbnailList: thumbnailUrlList,
                          thumbnailListSize: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              const Expanded(
                child: Center(
                  child: SpinKitSpinningLines(
                    color: Colors.greenAccent,
                    size: 200,
                    lineWidth: 3,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
