import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserList extends StatelessWidget {
  final String apiUrl =
      "https://run.mocky.io/v3/f3feef1c-9bfa-43fd-b2a0-bbe9abadb4f6";

  Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(Uri.parse(apiUrl));
    return jsonDecode(result.body)['clients'];
  }

  String _name(dynamic user) {
    return user['name'];
  }

  String _company(dynamic user) {
    return user['company'] as String;
  }

  String _orderId(dynamic user) {
    return user['orderId'] as String;
  }

  String _invoicePaid(dynamic user) {
    return user['invoicepaid'] as String;
  }

  String _invoicePending(dynamic user) {
    return user['invoicePending'] as String;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: FutureBuilder<List<dynamic>>(
            future: fetchUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(_name(snapshot.data[index])),
                              subtitle: Text(_company(snapshot.data[index]) +
                                  "\ninvoicePending : " +
                                  _invoicePending(snapshot.data[index]) +
                                  "\ninvoicePaid : " +
                                  _invoicePaid(snapshot.data[index])),
                              trailing: Text("orderId : "+_orderId(snapshot.data[index])),
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
