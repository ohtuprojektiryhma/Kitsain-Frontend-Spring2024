import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitsain_frontend_spring2023/LoginController.dart';
import 'package:kitsain_frontend_spring2023/views/homepage2.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  const TopBar({
    super.key,
    required this.title,
    this.addFunction,
    this.addIcon = Icons.add,
    required this.helpFunction,
    required this.backgroundImageName,
    required this.titleBackgroundColor,
  });

  final String title;
  final Function? addFunction;
  final IconData addIcon;
  final Function helpFunction;
  final String backgroundImageName;
  final Color titleBackgroundColor;

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _TopBarState extends State<TopBar> {
  final _loginController = Get.put(LoginController());
  VisualDensity _topIconsDensity = VisualDensity(horizontal: -4.0, vertical: -4.0);

  _openAccountSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Signed in as'),
          content: Text(
            '${_loginController.googleUser.value?.email}',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('CANCEL')),
            TextButton(
              onPressed: () {
                _signOut();
              },
              child: Text('LOG OUT'),
            ),
          ],
        );
      },
    );
  }

  _openSettings() {
    // todo
  }

  _signOut() async {
    await _loginController.googleSignInUser.value?.signOut();
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage2()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: widget.preferredSize,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        //color: Colors.green,
        padding: const EdgeInsets.only(left: 15, top: 25, bottom: 1, right: 15),
        decoration: BoxDecoration(
          image: DecorationImage(
            //image: AssetImage("assets/images/pantry_banner_2.jpg"),
            //image: AssetImage("assets/images/ue_banner_darker_3.png"),
            image: AssetImage(widget.backgroundImageName),
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.64,
              child: Text(
                ' ${widget.title} ${'\u200e'}',
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    backgroundColor: widget.titleBackgroundColor,
                ),
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      visualDensity: _topIconsDensity,
                      padding: EdgeInsets.zero,
                      onPressed: () => widget.helpFunction(),
                      icon: const Icon(Icons.help_outline),
                    ),
                    IconButton(
                      visualDensity: _topIconsDensity,
                      padding: EdgeInsets.zero,
                      onPressed: () => _openSettings(),
                      icon: const Icon(Icons.settings),
                    ),
                    IconButton(
                      visualDensity: _topIconsDensity,
                      padding: EdgeInsets.zero,
                      onPressed: () => _openAccountSettings(context),
                      icon: const Icon(Icons.account_circle),
                    ),
                  ],
                ),
                if (widget.addFunction != null)
                  Container(
                    height: 48,
                    width: 48,
                    child: FloatingActionButton(
                      onPressed: () => widget.addFunction!(),
                      child: Icon(widget.addIcon),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
