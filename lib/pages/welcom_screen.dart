import 'package:flutter/material.dart';
import 'package:mysqpl_with_flutter/widgets/button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                height: 190,
                child: Image.asset('images/logo.png'),
              ),
              SizedBox(
                height: 50,
              ),
              MyButton(
                text: "Login",
                color:
                    Color(0xFF24786D), // Use Color constructor to specify color
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              SizedBox(
                height: 8,
              ),
              MyButton(
                text: "Register",
                color:
                    Color(0xFF24786D), // Use Color constructor to specify color
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
