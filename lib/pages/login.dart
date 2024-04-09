// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:gourmet_app/auth/auth_service.dart';
import 'package:gourmet_app/pages/homepage.dart';
import './signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _comfirmerdPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Image.asset(
                'assets/logo.png', // Replace with your asset image path
                height: 100.0,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'HELLO',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Welcome Back!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 48.0),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Email'),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Enter Password',
                border: OutlineInputBorder(),
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Add forgot password logic
              },
              child: Text('Forgot Password?',
                  style: TextStyle(color: Colors.teal)),
            ),
            ElevatedButton(
              onPressed: () async {
                final message = await AuthService().login(
                    email: _emailController.text,
                    password: _passwordController.text);
                if (message!.contains('Success')) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Homepage()));
                }
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
              },
              // ignore: sort_child_properties_last
              child: Text('Sign In'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal, // Text color
              ),
            ),
            Divider(),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              },
              child: Text('Don\'t have an account? Sign Up',
                  style: TextStyle(color: Colors.teal)),
            ),
          ],
        ),
      ),
    );
  }
}
