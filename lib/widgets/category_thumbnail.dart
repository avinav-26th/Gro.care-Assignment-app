import 'package:flutter/material.dart';
import '../screens/shorts_gridview_screen.dart';

class CategoryThumbnail extends StatefulWidget {
  final String categoryName;
  final List<String> thumbnailList;
  final int thumbnailListSize;
  const CategoryThumbnail({
    Key? key,
    required this.categoryName,
    required this.thumbnailList,
    required this.thumbnailListSize,
  }) : super(key: key);

  @override
  State<CategoryThumbnail> createState() => _CategoryThumbnailState();
}

class _CategoryThumbnailState extends State<CategoryThumbnail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Text(
              widget.categoryName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ShortsGridViewScreen(categoryName: widget.categoryName),
              ));
            },
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                //thumbnail view container
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.21,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.21,
                            // width: 200,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              child: Image.network(widget.thumbnailList[0]),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.21,
                            // width: 200,
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(14),
                              child: Image.network(widget.thumbnailList[1]),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.21,
                            // width: 200,
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(14),
                              child: Image.network(widget.thumbnailList[2]),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.21,
                            // width: 200,
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(14),
                              child: Image.network(widget.thumbnailList[3]),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.21,
                            // width: 200,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              child: Image.network(widget.thumbnailList[4]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //more items container
                Container(
                  height: MediaQuery.of(context).size.height * 0.21,
                  width: MediaQuery.of(context).size.width * 0.33,
                  decoration: BoxDecoration(
                    color: Colors.black26.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '+ ${widget.thumbnailListSize} more',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
