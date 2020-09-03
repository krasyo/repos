import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.fill
                    )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Repos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                  Text('Github', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromRGBO(164, 164, 164, 100.0)
                      ),
                      labelText: 'Логин Github',
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[200])),
                      border: OutlineInputBorder()
                  ),
                  validator: (value) => RegExp(r'^[a-zA-Z0-9]+(?:-[a-zA-Z0-9]+)*$').hasMatch(_controller.text.trim())
                    ? null
                    : 'Не похоже на логин Github',
                )
              ),
            ),
            FlatButton(
              onPressed: () {
                if (this._formKey.currentState.validate())
                  Navigator.pushNamed(context, '/repos', arguments: _controller.text.trim());
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              color: Colors.black,
              child: Text('Репозитории', style: TextStyle(color: Colors.white, letterSpacing: 1.0))
            )
          ],
        ),
      )
    );
  }
}
