import 'package:flutter/material.dart';
import 'package:joblyst/constant/colors.dart';
import 'package:joblyst/repository_login.dart'; // Import file LoginAPI
import 'package:joblyst/model_login.dart';

class LoginPage extends StatefulWidget {
  final String? message;

  const LoginPage({Key? key, this.message}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  String? message;
  bool _isObscure = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    message = widget.message;
  }

  Widget _inputField(String hintText, {bool isPassword = false, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.secondary4Color,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              TextFormField(
                controller: controller,
                enabled: true,
                obscureText: isPassword && _isObscure,
                decoration: InputDecoration(
                  hintText: hintText == 'Email' ? 'Enter your email' : 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.secondary3Color,
                  hintStyle: TextStyle(
                    color: AppColors.secondary5Color,
                  ),
                ),
              ),
              if (isPassword)
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _elevatedButton(String text, BuildContext context) {
    final loginAPI = LoginAPI('https://joblyst-api-cpe5hpucwa-uc.a.run.app');

    return Container(
      padding: const EdgeInsets.fromLTRB(8.0, 25.0, 8.0, 0.0),
      child: ElevatedButton(
        onPressed: () async {
          final loginData = Login(
            email: userController.text,
            password: passController.text,
          );

          final bool loginSuccess = await loginAPI.login(loginData);

          if (loginSuccess) {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/tag');
          } else {
            setState(() {
              message = "Login Gagal";
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!)));
          }
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(300, 50),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.secondary2Color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 60.0, 8.0, 0.0),
                child: SizedBox(
                  width: 200,
                  child: Image.asset('images/login.png'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0.0),
                child: Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 24, color: AppColors.primaryColor),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Text(
                  "Login your account",
                  style: TextStyle(fontSize: 16, color: AppColors.secondary1Color),
                ),
              ),
              _inputField("Email", controller: userController),
              _inputField("Password", controller: passController, isPassword: true),
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 45.0),
                    child: Text(
                      'Remember me',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.secondary1Color,
                      ),
                    ),
                  ),
                  SizedBox(width: 120),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.secondary1Color,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
              _elevatedButton("Login", context),
              if (message != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 20.0, 8.0, 0.0),
                  child: Text(
                    message!,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.secondary1Color,
                        thickness: 1,
                        indent: 35,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Or login using',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.secondary1Color,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.secondary1Color,
                        thickness: 1,
                        endIndent: 35,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/google.png', width: 30, height: 30),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Dont have account yet?',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.secondary4Color,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'Register Here',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}