import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool showSearchIcon = true, showClearIcon = false, nothingFoundSvg = false;
  TextEditingController searchInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        // to dismiss virtual keypad if the user focus in not in the search bar
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
            setState(() {
              showClearIcon = false;
              showSearchIcon = true;
            });
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                  color: Colors.white,

                  //search elements row
                  child: Row(
                    children: [
                      //back btn
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_outlined,
                            size: 25,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),

                      //search container
                      Expanded(
                        child: Container(
                          height: 45,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            children: [
                              //search icon
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Visibility(
                                  visible: showSearchIcon,
                                  child: Icon(
                                    Icons.search,
                                    size: 25,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ),

                              //search text field
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: TextField(
                                    onTap: () => setState(() {
                                      showSearchIcon = false;
                                      showClearIcon = true;
                                    }),
                                    onSubmitted: (_) {
                                      setState(() {
                                        nothingFoundSvg = true;
                                      });
                                    },
                                    controller: searchInputController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search item or member',
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade400,
                                      ),
                                      suffixIcon: Visibility(
                                        visible: showClearIcon,
                                        child: IconButton(
                                          onPressed: () {
                                            searchInputController.clear();
                                            setState(() {
                                              showSearchIcon = true;
                                              showClearIcon = false;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.clear_rounded,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: nothingFoundSvg,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Nothing found',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 40,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/svg/empty.svg',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
