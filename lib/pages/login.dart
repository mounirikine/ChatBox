import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mysqpl_with_flutter/widgets/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              
                Container(
                  height: 190,
                  child: Image.asset('images/logo.png'),
                ),
                SizedBox(
                  height: 50,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your Email',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your Password',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                MyButton(
                  text: "Login",
                  color: Color(0xFF24786D),
                  onTap: () async {
                      setState(() {
                      showSpinner = true;
                    });
                    try {
                      final userCredential =
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                      if (userCredential.user != null) {
                        Navigator.pushNamed(context, '/chat');
                          setState(() {
                      showSpinner = false;
                    });
                      } else {
                        print('Email or Password is incorrect');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
