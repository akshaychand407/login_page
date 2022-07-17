import 'package:fieldnxttest/Model/usermodel.dart';
import 'package:fieldnxttest/Screen/lognScreen/login.dart';
import 'package:fieldnxttest/Utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final Data data;
  const HomeScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  logout() async {
    var response = await http.post(Uri.parse("$BASE_URL/logout"),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "_id": "NAdc4nbJu5ChhFF2p"
    });
    final sharedprfs = await SharedPreferences.getInstance();
                  await sharedprfs.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () => logout(), icon: const Icon(Icons.logout_sharp)),
        SizedBox(
          width: 10,
        )
      ]),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://media.istockphoto.com/vectors/male-icon-vector-user-person-profile-avatar-symbol-in-circle-flat-vector-id960699452?k=20&m=960699452&s=170667a&w=0&h=7TnT_9Tb1Q9tlcO9gZepE4VNgonu_-C41Do5SxSVfSY='),
              ),
              Text(
                  widget.data.firstName.toString() +
                      widget.data.lastName.toString(),
                  style: const TextStyle(
                    fontSize: 25,
                  )),
              const SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Color.fromARGB(255, 108, 159, 226),
                ),
              ),
              Text(
                widget.data.role.toString(),
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Color.fromARGB(255, 108, 159, 226),
                ),
              ),
              Card(
                color: Colors.white,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: const Icon(
                    Icons.work,
                    color: Color.fromARGB(255, 108, 159, 226),
                  ),
                  title: Text(
                    widget.data.empCode.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Card(
                  color: Colors.white,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ListTile(
                    leading: const Icon(
                      Icons.phone,
                      color: Color.fromARGB(255, 108, 159, 226),
                    ),
                    title: Text(
                      widget.data.contactNo.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
