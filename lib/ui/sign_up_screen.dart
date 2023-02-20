import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'main_wrapper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  void dispose() {
    super.dispose();
  }

  bool register = true;

  double _opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Lottie.asset('assets/animations/wave_loop.json',
              height: height * 0.2, width: double.infinity, fit: BoxFit.fill),
          SizedBox(
            height: height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Sign Up',
              style: GoogleFonts.ubuntu(
                  fontSize: height * 0.035,
                  color: Theme.of(context).unselectedWidgetColor),
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.only(left: 20),
          //   child: Text(
          //     'Create Account',
          //     style: GoogleFonts.ubuntu(
          //         fontSize: height * 0.035,
          //         color: Theme.of(context).unselectedWidgetColor),
          //   ),
          // ),
          SizedBox(
            height: height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    controller: nameController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      } else if (value.length < 4) {
                        return 'at least enter 4 characters ';
                      } else if (value.length > 13) {
                        return 'maximum character is 13';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // TextFormField(
                  //   decoration: const InputDecoration(
                  //     prefixIcon: Icon(Icons.email),
                  //     hintText: 'Gmail',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(15),
                  //       ),
                  //     ),
                  //   ),
                  //   controller: emailController,
                  //   validator: (String? value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter gmail';
                  //     }
                  //     return null;
                  //   },
                  // ),

                  TextFormField(
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_open),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      hintText: 'Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    controller: passwordController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 7) {
                        return 'at least enter 8 characters ';
                      } else if (value.length > 13) {
                        return 'maximum character is 13';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    'Login to your account',
                    style: GoogleFonts.ubuntu(
                        fontSize: 15, color: Colors.grey, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  register
                      ? signupBtn()
                      : const SizedBox(
                          height: 55,
                          width: 55,
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  AnimatedOpacity(
                    opacity: _opacity,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutCubic,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          'your username and password do not match',
                          style: GoogleFonts.ubuntu(
                              color: Colors.redAccent, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget signupBtn() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(
                15,
              )),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            setState(() {
              register = false;
            });
            if (nameController.text == 'parham' &&
                passwordController.text == '12345678') {
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  setState(() {
                    register = true;
                    _opacity = 0;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        duration: Duration(seconds: 1),
                        dismissDirection: DismissDirection.vertical,
                        content: Text(
                          'Successfull',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        backgroundColor: Color.fromARGB(255, 130, 130, 130),
                      ),
                    );
                    Future.delayed(
                      const Duration(milliseconds: 1500),
                      () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const MainRapper())),
                    );
                  });
                },
              );
            } else {
              setState(() {
                Future.delayed(const Duration(seconds: 1), () {
                  setState(() {
                    register = true;
                    _opacity = 1;
                  });
                });
              });
            }
          }
        },
        child: const Text(
          'Login',
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
    );
  }
}
