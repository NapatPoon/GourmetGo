// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import './food_allergy.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  bool acceptedTerms = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 30),
            Text(
              'Create an account',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text('Name',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Enter Name',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
              ),
            ),
            SizedBox(height: 20.0),
            Text('Email',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Enter Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Text('Password',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: 'Enter Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Text('Confirm Password',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Enter Confirm Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0),
            Row(children: <Widget>[
              Checkbox(
                value: acceptedTerms,
                onChanged: (bool? value) {
                  setState(() {
                    acceptedTerms = value!;
                  });
                },
                // checkColor: Colors.teal,
                activeColor: Colors.teal,
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      acceptedTerms = !acceptedTerms;
                    });
                  },
                  child: const Text('Accept the terms and conditions')),
            ]),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: acceptedTerms
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoodAllergy()));
                    }
                  : null, // Button is disabled if terms are not accepted
              child: const Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                foregroundColor: Colors.white,
                backgroundColor: acceptedTerms
                    ? Colors.teal
                    : Colors.grey, // Button color changes based on acceptance
              ),
            ),
            Divider(),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              },
              child: Text('Already have an account? Sign In',
                  style: TextStyle(color: Colors.teal)),
            ),
          ],
        ),
      ),
    );
  }
}
