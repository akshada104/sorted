import 'package:flutter/material.dart';
import 'package:sorted/http/login_controller.dart';
import 'package:sorted/utils/colors.dart';
import 'package:sorted/view/home_view.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisibility = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          focusColor: primaryDarkBlueColor,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide:
                                  BorderSide(color: primaryDarkBlueColor)),
                          border: OutlineInputBorder(),
                          hoverColor: primaryDarkBlueColor,
                          labelText: 'Email',
                          labelStyle: TextStyle(color: primaryDarkBlueColor),
                          hintText: 'Please enter username'),
                      controller: usernameController,
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: true,
                      onChanged: (e) {},
                      autofocus: true,
                      textAlignVertical: TextAlignVertical.center,
                      validator: (value) {
                        value!.isEmpty ? 'Please Enter' : null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      obscureText: passwordVisibility,
                      decoration: InputDecoration(
                          focusColor: primaryDarkBlueColor,
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide:
                                  BorderSide(color: primaryDarkBlueColor)),
                          suffixIcon: IconButton(
                              onPressed: () {
                                passwordVisibility = !passwordVisibility;
                                setState(() {});
                              },
                              icon: Icon(
                                !passwordVisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: primaryDarkBlueColor,
                              )),
                          border: const OutlineInputBorder(),
                          labelText: 'Password',
                          labelStyle:
                              const TextStyle(color: primaryDarkBlueColor),
                          hintText: 'Please enter password'),
                      controller: passwordController,
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: true,
                      onChanged: (e) {},
                      autofocus: true,
                      textAlignVertical: TextAlignVertical.center,
                      validator: (value) {
                        value!.isEmpty ? 'Please Enter' : null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: TextButton(
                      onPressed: () {
                        login();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: primaryDarkBlueColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
                        ),
                        disabledBackgroundColor: secondaryDarkGreyColor,
                        disabledForegroundColor: secondaryGreyColor,
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      );

  Future<void> login() async {
    try {
      if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter username and password'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        Map<String, dynamic> res = {};
        isLoading = true;
        await LoginController()
            .login(
          email: usernameController.text.toString(),
          password: passwordController.text.toString(),
        )
            .then((value) {
          res = value;
          isLoading = false;
          print('res $res');
        });

        if (res['statusCode'] == 200) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomeView(),
            ),
          );
        } else {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invalid username or password'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
