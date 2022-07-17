import 'dart:convert';

import 'package:fieldnxttest/Model/usermodel.dart';
import 'package:fieldnxttest/Screen/HomeScreen/homescreen.dart';
import 'package:fieldnxttest/Screen/WebView/webview.dart';
import 'package:fieldnxttest/Utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _obscureText = true;
  Future<UserModel>postData (ctx) async {
    var response = await http.post(Uri.parse("$BASE_URL/login"), headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "username": _usernameController.text,
      "password": _passwordController.text,
      "appVersion": "1.10"
    });
    var data = UserModel.fromJson(jsonDecode(response.body));
    print(response.body);
    print(data.message);
    if (data.message == "success"){
      final _sharedprfs = await SharedPreferences.getInstance();
      _sharedprfs.setString('id',data.data!.id.toString());
      _sharedprfs.setBool("login", true);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(data: data.data!,)));
    }
    else{
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          content: Text(data.message.toString())));
    }
    return data;
  }

  logout() async {
    var response = await http.post(Uri.parse("$BASE_URL/logout"),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "_id": "NAdc4nbJu5ChhFF2p"
    });
    final _sharedprfs = await SharedPreferences.getInstance();
                  await _sharedprfs.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/loginBackground.png"),
                  fit: BoxFit.cover)),
        ),
        SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.08,
                    top: screenHeight * 0.15,
                    right: screenWidth * 0.08,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Log in",
                        style:
                            TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: screenHeight * 0.08,
                      ),
                      const Text(
                        "Welcome back to fieldNXT",
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                      SizedBox(
                        height: screenHeight * 0.08,
                      ),
                      const Text(
                        "Username",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          hintText: "Email Id / username",
                        ),
                        validator: (value)=>value!.isEmpty ? "is Empty" : null,
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      const Text(
                        "Password",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty) {
                            return "is Empty";
                          }
                           else if(value.length<6){
                            return "Please enter a valid password";
                           }                          
                            return null;
                        },
                      ),
                      SizedBox(
                        height: screenHeight * 0.08,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.08,
                    right: screenWidth * 0.08,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if(_formkey.currentState!.validate()){
                            postData(context);
                          }
                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white,fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF2949F0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "forgotpassword ?",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.black45),
                        ),
                        style: TextButton.styleFrom(primary: Colors.black),
                      ),
                      SizedBox(
                        height: screenHeight * 0.14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "powered by",
                            style: TextStyle(color: Colors.black45),
                          ),
                          TextButton(
                            onPressed: (){},
                            child: const Text(
                              "fildnNXT",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.black45),
                            ),
                            style: TextButton.styleFrom(primary: Colors.black),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
