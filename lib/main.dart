import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = lightTheme;

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme = _currentTheme == lightTheme ? darkTheme : lightTheme;
    notifyListeners();
  }

  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.deepPurple,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.deepPurple,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.deepPurple,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      home: const SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var emailError;
  var passwordError;

  void _handleSignUp() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SignUpPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  void _validateEmail(String email) {
    if (email.length > 50) {
      setState(() {
        emailError = "Email should not exceed 50 characters";
      });
    } else {
      setState(() {
        emailError = null;
      });
    }
  }

  void _validatePassword(String email) {
    if (email.length > 20) {
      setState(() {
        passwordError = "Password should not exceed 20 characters";
      });
    } else {
      setState(() {
        passwordError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset(
              'assets/signin.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(style: TextStyle(fontSize: 24), "Log In"),
                          CustomSwitch(
                            value: Provider.of<ThemeProvider>(context)
                                    .currentTheme ==
                                ThemeProvider.lightTheme,
                            onChanged: (value) {
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .toggleTheme();
                            },
                          ),
                        ]),
                    const SizedBox(height: 40),
                    TextField(
                        textAlign: TextAlign.center,
                        controller: emailController,
                        onChanged: _validateEmail,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: 'Email',
                          errorText: emailError,
                        )),
                    const SizedBox(height: 30),
                    TextField(
                        textAlign: TextAlign.center,
                        onChanged: _validatePassword,
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: 'Password',
                            errorText: passwordError)),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: FloatingActionButton(
                          backgroundColor: Colors.deepPurpleAccent.shade100,
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(70),
                          ),
                          child: const Text("Sign In")),
                    ),
                    const SizedBox(height: 20),
                    Row(children: [
                      const Text(
                          style: TextStyle(fontSize: 11),
                          "Don't have an account?"),
                      GestureDetector(
                          onTap: () {
                            _handleSignUp();
                          },
                          child: Text(
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.deepPurpleAccent.shade100),
                              "Sign Up"))
                    ]),
                    const SizedBox(height: 10),
                    Text(
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.deepPurpleAccent.shade100),
                        "Forgot Password?"),
                  ]))
        ],
      ),
    ));
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var emailError;
  var passwordError1;
  var passwordError2;

  void _handleSignIn() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SignInPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  void _validatePassword1(String email) {
    if (email.length > 20) {
      setState(() {
        passwordError1 = "Password should not exceed 20 characters";
      });
    } else {
      setState(() {
        passwordError1 = null;
      });
    }
  }

  void _validatePassword2(String email) {
    if (email.length > 20) {
      setState(() {
        passwordError2 = "Password should not exceed 20 characters";
      });
    } else {
      setState(() {
        passwordError2 = null;
      });
    }
  }

  void _validateEmail(String email) {
    if (email.length > 50) {
      setState(() {
        emailError = "Email should not exceed 50 characters";
      });
    } else {
      setState(() {
        emailError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset(
              'assets/signup.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(style: TextStyle(fontSize: 24), "Sign Up"),
                          CustomSwitch(
                            value: Provider.of<ThemeProvider>(context)
                                    .currentTheme ==
                                ThemeProvider.lightTheme,
                            onChanged: (value) {
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .toggleTheme();
                            },
                          ),
                        ]),
                    const SizedBox(height: 40),
                    TextField(
                        textAlign: TextAlign.center,
                        onChanged: _validateEmail,
                        controller: emailController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: 'Email',
                            errorText: emailError)),
                    const SizedBox(height: 20),
                    Row(children: [
                      SizedBox(
                          width: (MediaQuery.of(context).size.width - 110) / 2,
                          child: TextField(
                              textAlign: TextAlign.center,
                              onChanged: _validatePassword1,
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: 'Password',
                                  hintText: "Create Password",
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 11),
                                  errorText: passwordError1))),
                      const SizedBox(width: 30),
                      SizedBox(
                          width: (MediaQuery.of(context).size.width - 110) / 2,
                          child: TextField(
                              textAlign: TextAlign.center,
                              onChanged: _validatePassword2,
                              controller: confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  labelText: 'Password',
                                  hintText: "Confirm Password",
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 11),
                                  errorText: passwordError2)))
                    ]),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: FloatingActionButton(
                          backgroundColor: Colors.deepPurpleAccent.shade100,
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(70),
                          ),
                          child: const Text("Create Account")),
                    ),
                    const SizedBox(height: 20),
                    Row(children: [
                      const Text(
                          style: TextStyle(fontSize: 11), "Have an account?"),
                      GestureDetector(
                          onTap: () {
                            _handleSignIn();
                          },
                          child: Text(
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.deepPurpleAccent.shade100),
                              "Log In")),
                    ]),
                  ]))
        ],
      )),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  CustomSwitch({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onChanged(!value);
        },
        child: Stack(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          children: [
            Container(
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: value ? Colors.yellow : Colors.blue,
              ),
            ),
            Container(
              width: 30,
              height: 30,
              child: Icon(
                value ? Icons.wb_sunny : Icons.nightlight_round,
                color: Colors.white,
              ),
            ),
          ],
        ));
  }
}
