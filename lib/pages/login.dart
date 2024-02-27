// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import './signup.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              obscureText: true,
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
              onPressed: () {
                // TODO: Add sign-in logic
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
