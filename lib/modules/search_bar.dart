import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

int toggle = 0;

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _con;
  late TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _con = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 375),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 375),
      height: 35,
      width: (toggle == 0) ? 48.0 : 325.0,
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        color: Colors.blue[700],
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: -10.0,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 375),
            top: -3.0,
            right: 7.0,
            curve: Curves.easeOut,
            child: AnimatedOpacity(
              opacity: (toggle == 0) ? 0.0 : 1.0,
              duration: Duration(milliseconds: 200),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: AnimatedBuilder(
                  child: IconButton(
                    icon: Icon(Icons.close),
                    splashRadius: 5,
                    onPressed: () {
                      setState(() {
                        if (toggle == 0) {
                          toggle = 1;
                          _con.forward();
                        } else {
                          toggle = 0;
                          _textEditingController.clear();
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          _con.reverse();
                        }
                      });
                    },
                    color: Colors.white,
                  ),
                  builder: (context, widget) {
                    return Transform.rotate(
                      angle: _con.value * 2.0 * 3.14,
                      child: widget,
                    );
                  },
                  animation: _con,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 375),
            left: (toggle == 0) ? 20.0 : 40.0,
            curve: Curves.easeOut,
            top: 11.0,
            child: AnimatedOpacity(
              opacity: (toggle == 0) ? 0.0 : 1.0,
              duration: Duration(milliseconds: 200),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 32.0,
                  width: 200.0,
                  child: Theme(
                    data: ThemeData(
                        inputDecorationTheme: InputDecorationTheme(
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                    )),
                    child: TextField(
                      controller: _textEditingController,
                      cursorRadius: Radius.circular(10.0),
                      cursorWidth: 2.0,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: 'Search...',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                        alignLabelWithHint: false,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Material(
              borderRadius: BorderRadius.circular(30.0),
              child: IconButton(
                splashRadius: 19.0,
                iconSize: 25,
                icon: Icon(
                  Icons.search,
                  color: Colors.blue[900],
                ),
                onPressed: () {
                  setState(
                    () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      if (toggle == 0) {
                        toggle = 1;
                        _con.forward();
                      } else {
                        searchInfo(context);
                        toggle = 0;
                        _textEditingController.clear();
                        _con.reverse();
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
