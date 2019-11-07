/* Code by AVDISX */

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mail_send_mailer/send_mail.dart';

class MailSend extends StatefulWidget {
  @override
  _MailSendState createState() => _MailSendState();
}

class _MailSendState extends State<MailSend> {
  final formKey = GlobalKey<FormState>();

  String nameSurname, email, subject, message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send mail with 'mailer' Plugin"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            //color: Colors.greenAccent.shade100,
            ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: validateName,
                  onSaved: (a) => nameSurname = a,
                  decoration: InputDecoration(
                    labelText: "Name/İsim",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.account_circle),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (a) => email = a,
                  decoration: InputDecoration(
                    labelText: "e-mail",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: validateName,
                  onSaved: (a) => subject = a,
                  decoration: InputDecoration(
                    labelText: "Subject/Konu",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.subject),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: validateName,
                  onSaved: (a) => message = a,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Message/Mesaj",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.message),
                  ),
                  maxLines: 4,
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton.icon(
                  icon: Icon(Icons.send),
                  label: Text("Send / Gönder"),
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      bool sendingStatus = await sendMail(
                          nameSurname, email, subject, message, context);
                      showSnackbar(sendingStatus);
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text("Clear / Temizle"),
                  onPressed: () {
                    formKey.currentState.reset();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String validateName(String value) {
    if (value.length < 6)
      return 'En az 6 karakter olmalıdır.\nMinimum 6 character';
    final RegExp nameExp = new RegExp(r'^[A-za-z ]+$');
    if (!nameExp.hasMatch(value)) return 'Lütfen geçerli bir isim giriniz.';
    return null;
  }

  String validateEmail(String value) {
    if (value.isEmpty) return 'e-mail boş bırakılamaz\ne-mail cannot be blank';

    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    //final RegExp nameExp = new RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');

    if (!regExp.hasMatch(value))
      return 'Geçersiz e-mail adresi\nInvalid email address';
    return null;
  }

  void showSnackbar(bool sendingStatus) {
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      margin: EdgeInsets.all(8),
      borderRadius: 15,
      backgroundGradient: LinearGradient(
        colors: [Colors.lightBlueAccent, Colors.green],
      ),
      backgroundColor: Colors.red,
      boxShadows: [
        BoxShadow(
          color: Colors.blue[800],
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
      //title: "Mesaj Bildirimi",
      message: sendingStatus == true
          ? "Mesaj Gönderildi. En kısa sürede geri dönüş sağlanacaktır.\nMessage Sent. Return will be provided as soon as possible."
          : "Mesaj Gönderilmede Hata Oluştu.\nError Sending Message.",
      icon: Icon(
        sendingStatus == true ? Icons.done_all : Icons.error,
        size: 28.0,
        color: Colors.white,
      ),
      duration: Duration(seconds: 3),
      //leftBarIndicatorColor: Colors.blue[300],
    )..show(context);
  }
}

//String name, String email, String subject, String message,BuildContext context
