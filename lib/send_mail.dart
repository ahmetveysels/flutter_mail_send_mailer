import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<bool> sendMail(String name, String email, String subject,
    String messages, BuildContext context) async {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Mesaj Gönderiliyor...\nMessage Sending",
                style: TextStyle(color: Colors.white),
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }));
  bool sendStates;
  try {
    String _username = 'name@yourcompany.com';
    String _password = 'password';

    final smtpServer = new SmtpServer('smtp.yourcompany.com',
        username: _username,
        password: _password,
        ignoreBadCertificate: false,
        ssl: false,
        allowInsecure: true);

    /* final smtpServer=hotmail(_username, _password); */

    String date = DateTime.now().toString();
    String sendmail = "info@yourcompany.com";
    String konu = subject;
    String mesajIcerigi =
        "Date/Tarih: $date \nSender name/ Gönderen İsim: $name \nSender e-mail/email: $email \nMesage/Mesaj: $messages";

    // Create our message.
    final message = Message()
      ..from = Address("$_username")
      ..recipients.add('$sendmail')
      ..subject = konu
      ..text = mesajIcerigi;

    try {
      final sendReport = await send(message, smtpServer);
      sendStates = true;
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      sendStates = false;
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  } catch (Exception) {
    //Handle Exception
  } finally {
    Navigator.pop(context);
  }
  return sendStates;
}
