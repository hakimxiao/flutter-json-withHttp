// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latihan_json/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<UserModel?> getDataUser() async {
    var response = await http.get(
      Uri.parse('https://reqres.in/api/users/4'),
      headers: {'x-api-key': 'reqres-free-v1'},
    );

    print(response);
    if (response.statusCode != 200) {
      print('ERROR 400');
      return null;
    } else {
      print(response.body);
      Map<String, dynamic> data =
          (json.decode(response.body) as Map<String, dynamic>);
      return UserModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Latihan JSON Serializable')),
      body: FutureBuilder<UserModel?>(
        future: getDataUser(),
        // snapshot adalah tempat dari get data api
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data!.data.avatar),
                      radius: 50,
                    ),
                    Text('ID -> DATA : ${snapshot.data!.data.id}'),
                    Text(
                      'NAME -> DATA :${snapshot.data!.data.firstName} ${snapshot.data!.data.lastName}',
                    ),
                    Text('EMAIL -> DATA :${snapshot.data!.data.email}'),
                    SizedBox(height: 20),
                    Text('URL -> SUPPORT :${snapshot.data!.support.url}'),
                    Text('TEXT -> SUPPORT :${snapshot.data!.support.text}'),
                  ],
                ),
              );
            } else {
              return Text('GAGAL MENGAMBIL DATA');
            }
          }
        },
      ),
    );
  }
}

// *** DATA MENTAH STRING JSON TIDAK BISA DI AMBIL LANGSUNG ***
//  MAKA SOLUSINYA AMBIL DATA YANG DIBUTUHKAN SAJA TAPI ADA MASALAH KARENA BODY NYA BERTIPE STRING
//  AGAR KITA BISA MENGGUNAKAN DATA TERSEBUT PERLU KITA RUBAH KE BENTUK MAP MENGGUNAKAN JSON DECODE

//  MENGIRIM  ->  BUTUH JSON ENCODE     (MERUBAH DARI DATA KE STRING JSON)
//  MENERIMA  ->  BUTUH JSON DECODE     (MERUBAH DARI STRING JSON KE MAPPING DLL)

// @____DECODE____@ :
/**
   return json.decode(response.body);

   Saat kita melakukkan decode maka data akan berubah ke dynamic nah oleh karena itu kita dapat konvert ulang 
   ke tipe data sesuai misalnya mapping.
     Maka rancangan function dan pemanggilan nya akan menjadi begini 
       -- FUNCTION : 
           Future<Map<String, dynamic>?> getDataUser() {}
       -- PEMANGGILAN : 
             body: FutureBuilder<Map<String, dynamic>?>(
                       future: getDataUser(),
                        // snapshot adalah tempat dari get data api
                        builder: (context, snapshot) => Text('${snapshot.data}'),
                ),
 **/

//  ### TIPS ###
/**
  Jika sebuah future builder kita memungkinkan data null maka untuk mengantisipasi error data null 
  kita memberikan sebuah kondisi render dimana jika kondisi status nya 200 maka akan di render 
  jika belum maka akan render hal lain.

      SELALU INGAT TENTANG 3 KONDISI (1. WAITING, 2. ADA DATA, 3. TIDAK ADA DATA) -> 3 hal ini wajib di pantau

       builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              return Text('${snapshot.data}');
            } else {
              return Text('GAGAL MENGAMBIL DATA');
            }
          }
        },
 */
