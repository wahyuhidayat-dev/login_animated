import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF2C394B),
        body: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String correctPassword = 'admin';
  String animatedType = 'idle';

  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final emailfocusNode = FocusNode();
  final passwordfocusNode = FocusNode();

  @override
  void initState() {
    passwordfocusNode.addListener(() {
      if (passwordfocusNode.hasFocus) {
        setState(() {
          animatedType = 'hands_up';
        });
      } else {
        setState(() {
          animatedType = 'hands_down';
        });
      }
    });

    emailfocusNode.addListener(() {
      emailfocusNode.hasFocus
          ? setState(() {
              animatedType = 'test';
            })
          : setState(() {
              animatedType = 'idle';
            });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 100),
            height: 300,
            width: 300,
            child: FlareActor(
              'assets/Teddy.flr',
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: animatedType,
              callback: (animation) {
                setState(() {
                  animatedType = 'idle';
                });
              },
            ),
          ),
          //! Input email
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xFFEEEEEE)),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      contentPadding: EdgeInsets.all(20)),
                  focusNode: emailfocusNode,
                  controller: emailController,
                ),
              ],
            ),
          ),
          Divider(),
          //! Input password
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xFFEEEEEE)),
            child: Column(
              children: [
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      contentPadding: EdgeInsets.all(20)),
                  focusNode: passwordfocusNode,
                  controller: passwordController,
                )
              ],
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              signIn();
            },
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFFF8485E),
              ),
              child: Center(
                  child: Text(
                'Login',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              )),
            ),
          )
        ],
      ),
    );
  }

  void signIn() {
    if (animatedType == 'hands_up') {
      setState(() {
        animatedType = 'hands_down';
      });
    }

    if (passwordController.text.compareTo(correctPassword) == 0) {
      setState(() {
        animatedType = "success";
      });
    } else {
      setState(() {
        animatedType = "fail";
      });
    }
  }
}
