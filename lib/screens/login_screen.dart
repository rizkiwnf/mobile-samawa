import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_samawa/main.dart';
import 'package:mobile_samawa/screens/home_screen.dart';
import 'package:mobile_samawa/screens/register_screen.dart';
import 'package:mobile_samawa/services/auth_service.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool loading = false;

    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          centerTitle: true,
          backgroundColor: Colors.teal[800],
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              loading
                  ? CircularProgressIndicator()
                  : Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });

                          if (emailController.text == "" ||
                              passwordController == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("All Fields are required"),
                              backgroundColor: Colors.red,
                            ));
                          } else {
                            User? result = await AuthService().signInBasic(
                                emailController.text,
                                passwordController.text,
                                context);
                            if (result != null) {
                              print("success");
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()),
                                  (route) => false);
                            }
                          }
                          setState(() {
                            loading = false;
                          });
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber[300], // Background color
                        ),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  child: Text("Not Have an Account ? Register Here")),
              loading
                  ? CircularProgressIndicator()
                  : SignInButton(Buttons.google, text: "Continue with Google",
                      onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      User? result = await AuthService().signInWithGoogle();
                      if (result != null) {
                        print("success");
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                            (route) => false);
                      }
                      setState(() {
                        loading = false;
                      });
                    })
            ],
          ),
        ));
  }
}
