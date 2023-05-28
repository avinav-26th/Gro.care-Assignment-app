// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gro_care_assignment_app/models/shorts_model.dart';
import 'package:gro_care_assignment_app/screens/search_screen.dart';
import 'package:gro_care_assignment_app/widgets/shorts_player_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class ShortsMainScreen extends StatefulWidget {
  final List<Post> postDetails;
  final int startIndex;
  const ShortsMainScreen(
      {Key? key, required this.postDetails, required this.startIndex})
      : super(key: key);

  @override
  State<ShortsMainScreen> createState() => _ShortsMainScreenState();
}

class _ShortsMainScreenState extends State<ShortsMainScreen> {
  Color likeBtnColor = Colors.white,
      dislikeBtnColor = Colors.white,
      subscribeBtnColor = Colors.red;
  double iconSize = 33;
  TextStyle textStyle1 = const TextStyle(
    color: Colors.white,
    fontSize: 15,
  );
  bool likeBtnSwitch = false, dislikeBtnSwitch = false, subscribeSwitch = false;
  String subscribeText = 'Subscribe';

  void showAlertDialog(BuildContext context, int index) {
    Widget cancelButton = TextButton(
      child: const Text(
        'Cancel',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        'Unsubscribe',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      onPressed: () {
        setState(() {
          subscribeText = 'Subscribe';
          subscribeBtnColor = Colors.red;
          subscribeSwitch = false;
        });
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text(
        'Unsubscribe from\n@${widget.postDetails[index].creator.handle}?',
        style: const TextStyle(fontSize: 19),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (widget.postDetails.isNotEmpty)
          ? Scaffold(
              body: PageView.builder(
                //to make the whole page scrollable
                itemCount: 10,
                controller: PageController(
                    initialPage: widget.startIndex, viewportFraction: 1),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Stack(
                    //to put all other elements on top of the video
                    children: [
                      ShortsPlayer(
                        shortsUrl:
                            widget.postDetails[index].submission.mediaUrl,
                      ),

                      //all stacked options
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //upper options row
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // back-arrow + shorts-heading row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    'Shorts',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),

                              //search + camera + menu row
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //search btn
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchScreen(),
                                      ));
                                    },
                                    icon: const Icon(
                                      Icons.search_rounded,
                                      color: Colors.white,
                                    ),
                                  ),

                                  //camera btn
                                  IconButton(
                                    onPressed: () async {
                                      await ImagePicker().pickImage(
                                          source: ImageSource.camera);
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                    ),
                                  ),

                                  //menu btn
                                  IconButton(
                                    onPressed: () {
                                      showBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              color: const Color(0xff1A1818),
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      showBottomSheet(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return Container(
                                                              color: const Color(
                                                                  0xff1A1818),
                                                              width: double
                                                                  .infinity,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(25),
                                                                child: Text(
                                                                  widget
                                                                      .postDetails[
                                                                          index]
                                                                      .submission
                                                                      .description
                                                                      .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        25),
                                                            child: Icon(
                                                              Icons
                                                                  .notes_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 27,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Description',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        25),
                                                            child: Icon(
                                                              Icons
                                                                  .closed_caption_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 27,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Captions',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        25),
                                                            child: Icon(
                                                              Icons
                                                                  .do_not_disturb_alt_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 27,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Don\'t recommend this channel',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        25),
                                                            child: Icon(
                                                              Icons
                                                                  .outlined_flag_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 27,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Report',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        25),
                                                            child: Icon(
                                                              Icons
                                                                  .feedback_outlined,
                                                              color:
                                                                  Colors.white,
                                                              size: 27,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Send feedback',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.more_vert_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          //lower-operations row
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                //video content details
                                Column(
                                  children: [
                                    // userprofile details
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(widget
                                              .postDetails[index].creator.pic),
                                          radius: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            '@${widget.postDetails[index].creator.handle}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (subscribeSwitch) {
                                              showAlertDialog(context, index);
                                            } else {
                                              setState(() {
                                                subscribeText = 'Subscribed';
                                                subscribeBtnColor = Colors.black
                                                    .withOpacity(0.7);
                                                subscribeSwitch = true;
                                              });
                                            }
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(left: 8),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: subscribeBtnColor,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              subscribeText,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        widget
                                            .postDetails[index].submission.title
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                //like + dislike + comments + share options
                                SizedBox(
                                  child: Column(
                                    children: [
                                      //like btn
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 25),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (likeBtnSwitch) {
                                                likeBtnSwitch = false;
                                                widget.postDetails[index]
                                                    .reaction.count--;
                                                likeBtnColor = Colors.white;
                                              } else {
                                                likeBtnSwitch = true;
                                                widget.postDetails[index]
                                                    .reaction.count++;
                                                likeBtnColor = Colors.blue;
                                                if (dislikeBtnSwitch) {
                                                  dislikeBtnColor =
                                                      Colors.white;
                                                }
                                              }
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.thumb_up_rounded,
                                                color: likeBtnColor,
                                                size: iconSize,
                                              ),
                                              Text(
                                                widget.postDetails[index]
                                                    .reaction.count
                                                    .toString(),
                                                style: textStyle1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      //dislike btn
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 25),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (dislikeBtnSwitch) {
                                                dislikeBtnSwitch = false;
                                                dislikeBtnColor = Colors.white;
                                              } else {
                                                dislikeBtnSwitch = true;
                                                dislikeBtnColor = Colors.blue;
                                                if (likeBtnSwitch) {
                                                  widget.postDetails[index]
                                                      .reaction.count--;
                                                  likeBtnColor = Colors.white;
                                                  likeBtnSwitch = false;
                                                }
                                              }
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.thumb_down_rounded,
                                                color: dislikeBtnColor,
                                                size: iconSize,
                                              ),
                                              Text(
                                                'Dislike',
                                                style: textStyle1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      //comment btn
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 25),
                                        child: InkWell(
                                          // onTap: (){
                                          //   setState(() {
                                          //     //open modal box
                                          //   });
                                          // },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.comment_rounded,
                                                color: Colors.white,
                                                size: iconSize,
                                              ),
                                              Text(
                                                widget.postDetails[index]
                                                    .comment.count
                                                    .toString(),
                                                style: textStyle1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      //save btn
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 25),
                                        child: InkWell(
                                          // onTap: (){
                                          //   setState(() {
                                          //     //open share modal box
                                          //   });
                                          // },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.bookmark_border_rounded,
                                                color: Colors.white,
                                                size: iconSize,
                                              ),
                                              Text(
                                                'Save',
                                                style: textStyle1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // share btn
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 25),
                                        child: InkWell(
                                          onTap: () {
                                            Share.share(widget
                                                .postDetails[index]
                                                .submission
                                                .mediaUrl);
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.share_rounded,
                                                color: Colors.white,
                                                size: iconSize,
                                              ),
                                              Text(
                                                'Share',
                                                style: textStyle1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
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
            ),
    );
  }
}
