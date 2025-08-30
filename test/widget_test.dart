import 'package:http/http.dart' as http;

void main() async {
  await getDataUser();
}

Future getDataUser() async {
  var response = await http.get(
    Uri.parse('https://reqres.in/api/users/1'),
    headers: {'x-api-key': 'reqres-free-v1'},
  );

  print(response);
  if (response.statusCode != 200) {
    print('ERROR 400');
  } else {
    print(response.body);
  }
  //   10 :15
}
