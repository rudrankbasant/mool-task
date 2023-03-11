import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mool_task/data/model/signup_user.dart';
import 'package:mool_task/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/auth/auth_cubit.dart';
import '../methods/custom_flushbar.dart';

class AuthScreen extends StatefulWidget {

  @override
  State<AuthScreen> createState() => _AuthScreen();
}

class _AuthScreen extends State<AuthScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();
  var showConfirmPassword = false;

  void signUpUser() async {
    SignupUser user = SignupUser(
        username: usernameController.text.trim(),
        fullname: fullnameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim());

    BlocProvider.of<AuthCubit>(context).signUp(user, context);
  }

  void loginUser() {
    BlocProvider.of<AuthCubit>(context).login(
      usernameController.text.trim(),
      passwordController.text.trim(),
      context
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<AuthCubit>();
      cubit.checkAlreadySignedIn();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is SignInSuccess) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('jwtToken', state.jwtToken.toString());
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Loading...',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  )
                ],
              ),
            );
          }else if(state is SignInState){
            loginUser();
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Loading...',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  )
                ],
              ),
            );
          } else {
            return LayoutBuilder(builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                  BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 90),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: Text("Mool Task Authentication",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ),
                            SizedBox(height: 40),
                            Padding(
                                padding:
                                const EdgeInsets.fromLTRB(20, 10, 20, 5),
                                child: TextField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: usernameController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    label: Text(
                                      "Username",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7)),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    hintText: 'Username',
                                  ),
                                )),
                            Visibility(
                              visible: showConfirmPassword,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20, 10, 20, 5),
                                  child: TextField(
                                    style:
                                    const TextStyle(color: Colors.white),
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                      label: Text(
                                        "Email",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7))),
                                      hintText: 'Email',
                                    ),
                                  )),
                            ),
                            Visibility(
                              visible: showConfirmPassword,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20, 10, 20, 5),
                                  child: TextField(
                                    style:
                                    const TextStyle(color: Colors.white),
                                    controller: fullnameController,
                                    decoration: const InputDecoration(
                                      label: Text(
                                        "Full Name",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7))),
                                      hintText: 'Full Name',
                                    ),
                                  )),
                            ),

                            Padding(
                                padding:
                                const EdgeInsets.fromLTRB(20, 10, 20, 5),
                                child: TextField(
                                  obscureText: true,
                                  style: const TextStyle(color: Colors.white),
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: const InputDecoration(
                                    label: Text(
                                      "Password",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7)),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    hintText: 'Password',
                                  ),
                                )),
                            Visibility(
                              visible: showConfirmPassword,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20, 10, 20, 5),
                                  child: TextField(
                                    obscureText: true,
                                    style:
                                    const TextStyle(color: Colors.white),
                                    controller: cpasswordController,
                                    keyboardType:
                                    TextInputType.visiblePassword,
                                    decoration: const InputDecoration(
                                      label: Text(
                                        "Confirm Password",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7))),
                                      hintText: 'Confirm Password',
                                    ),
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (usernameController.text.trim().isNotEmpty &&
                                    passwordController.text
                                        .trim()
                                        .isNotEmpty) {
                                  if (showConfirmPassword) {
                                    if (cpasswordController.text
                                        .trim()
                                        .isNotEmpty && emailController.text.trim().isNotEmpty && fullnameController.text.trim().isNotEmpty){
                                      if (passwordController.text.trim() ==
                                          cpasswordController.text.trim()) {
                                        signUpUser();
                                      } else {
                                        showCustomFlushbar("Error!", "Passwords don't match", context);
                                      }
                                    } else {
                                      showCustomFlushbar("Error!", "Please Enter email and password", context);
                                    }
                                  } else {
                                    loginUser();
                                  }
                                } else {
                                  showCustomFlushbar("Error!", "Please Enter email and password", context);
                                }
                              },
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20, 20, 20, 5),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: const Color(0xff466FFF),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          showConfirmPassword
                                              ? const Text(
                                            "Sign Up",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight:
                                              FontWeight.w500,
                                            ),
                                          )
                                              : const Text(
                                            "Sign In",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight:
                                              FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showConfirmPassword = !showConfirmPassword;
                            });
                          },
                          child: Padding(
                              padding:
                              const EdgeInsets.fromLTRB(20, 10, 20, 50),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      showConfirmPassword
                                          ? const Text(
                                        "Already have an account? Login",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                          : const Text(
                                        "Don't have an account? Sign Up",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
          }
        },
      ) ,
    );
  }
}