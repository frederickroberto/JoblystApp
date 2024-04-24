import 'package:flutter/material.dart';
import 'package:joblyst/constant/colors.dart';
import 'package:joblyst/model_register.dart';
import 'package:joblyst/repository_register.dart';

class RegisterPage extends StatefulWidget {
  final String? message;

  const RegisterPage({Key? key, this.message}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final passController1 = TextEditingController();
  String? message;
  bool _isObscure = true;
  bool _passwordError = false;
  bool _confirmPasswordError = false;

  final registerAPI = RegisterAPI('https://joblyst-api-cpe5hpucwa-uc.a.run.app');

  @override
  void initState() {
    super.initState();
    message = widget.message;
  }

  void _checkPasswordLength(String value) {
    setState(() {
      _passwordError = value.length < 8;
    });
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
                onChanged: isPassword ? _checkPasswordLength : null,
                decoration: InputDecoration(
                  hintText: hintText == 'Username'
                      ? 'Enter your username'
                      : hintText == 'Email'
                      ? 'Enter your email'
                      : hintText == 'Password'
                      ? 'Enter your password'
                      : 'Confirm your password',
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
    return Container(
      padding: const EdgeInsets.fromLTRB(8.0, 25.0, 8.0, 0.0),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            if (passController.text != passController1.text) {
              setState(() {
                _confirmPasswordError = true;
                message = "Password tidak cocok";
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!)));
            } else {
              Register registerData = Register(
                email: emailController.text,
                username: userController.text,
                password: passController.text,
              );

              bool registerSuccess = await registerAPI.register(registerData);

              if (registerSuccess) {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/tag');
              } else {
                setState(() {
                  message = "Registrasi gagal";
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!)));
              }
            }
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 60.0, 8.0, 0.0),
                  child: SizedBox(
                    width: 200,
                    child: Image.asset('images/register.png'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0.0),
                  child: Text(
                    "Create an account!",
                    style: TextStyle(fontSize: 24, color: AppColors.primaryColor),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: Text(
                    "Let's create account together",
                    style: TextStyle(fontSize: 16, color: AppColors.secondary1Color),
                  ),
                ),
                _inputField("Username", controller: userController),
                _inputField("Email", controller: emailController),
                _inputField("Password", controller: passController, isPassword: true),
                _inputField("Confirm Password", controller: passController1, isPassword: true),
                _elevatedButton("Register", context),
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
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.secondary4Color,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'Login Here',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
