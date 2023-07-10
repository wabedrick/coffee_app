import 'dart:convert';
import 'dart:io';

import '../Pages/Models/users.dart';
import 'package:http/http.dart' as http;

const String loginApi = 'https://kayegrace14.pythonanywhere.com/api/login';
const String captureApi =
    'https://kayegrace14.pythonanywhere.com/api/register-batch';
const String getImage = 'https://kayegrace14.pythonanywhere.com/api/classify';

Future<List<User>?> fetchUsers(
    {int? currentPage, int? userId, String? email}) async {
  var url = "";

  url = "loginApi/$email";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Map<String, dynamic> userJson = jsonDecode(response.body);
    List<dynamic> userList = userJson["results"];
    print(response);
    return userList.map((user) => User.fromJson(user)).toList();
  } else {
    print(response);
    return null;
  }
}

Future<Map<String, dynamic>> loginUser(
    {String? email, String? password}) async {
  print("this is teh email, please: $email");
  print("this is teh password, please: $password");
  final response = await http.post(
    Uri.parse("https://kayegrace14.pythonanywhere.com/api/login/"),
    body: jsonEncode({
      'email': email!.trim().toLowerCase(),
      'password': password,
    }),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = json.decode(response.body);
    print("this is the response data: $responseData");
    return {"data": responseData, "message": "succes"};
  } else {
    print("this is the failed response: ${response.body}");
    return {"message": "failed"};
  }
}

Future<Map<String, dynamic>> submitBatch(Map<String, dynamic> formData) async {
  String apiUrl = 'https://kayegrace14.pythonanywhere.com/api/register-batch/';

  final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
  };

  final Map<String, dynamic> body = formData;

  final http.MultipartRequest request =
      http.MultipartRequest('POST', Uri.parse(apiUrl));

  for (String key in body.keys) {
    if (key == 'image') {
      final file = File(formData["image"]);
      final http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath(
        key,
        file.path,
      );
      request.files.add(multipartFile);
    } else {
      request.fields[key] = "${body[key]}";
      // request.fields.addAll({key: body[key]});
    }
  }

  request.headers.addAll(headers);

  final http.Response response =
      await http.Response.fromStream(await request.send());

  print(
      "responses is: ${response.body}------------------------------------------------------------------------------");
  if (response.statusCode == 201) {
    Map<String, dynamic> data = jsonDecode(response.body);
    return {"status": "done", "data": data};
  } else {
    return {'status': "failed"};
  }
}

Future<Map<String, dynamic>> getBatchDetails({String? batchString}) async {
  var url = "https://kayegrace14.pythonanywhere.com/api/get-batch/$batchString";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = json.decode(response.body);
    print("this is the response data: $responseData");
    return {"data": responseData, "message": "success"};
  } else {
    print("this is the failed response: ${response.body}");
    return {"message": "failed"};
  }
}

Future<String> updateBatch(User user, String batchString) async {
  const String apiUrl =
      'https://kayegrace14.pythonanywhere.com/api/batch-exporter-update/';

  final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
  };
  Map<String, dynamic> body = {};

  body = {
    "exporter": user.id,
    "batch_string": batchString,
  };

  final http.MultipartRequest request =
      http.MultipartRequest('PUT', Uri.parse(apiUrl));

  for (String key in body.keys) {
    request.fields[key] = "${body[key]}";
  }

  request.headers.addAll(headers);

  final http.Response response =
      await http.Response.fromStream(await request.send());
  if (response.statusCode == 200) {
    print("responses status code: ${response.statusCode}");
    print("responses body: ${response.body}");
    return 'done';
  } else {
    print("responses status code: ${response.statusCode}");
    print("responses body: ${response.body}");
    return 'failed';
  }
}

Future<String> updateBuyerBatch(User user, String batchString) async {
  const String apiUrl =
      'https://kayegrace14.pythonanywhere.com/api/batch-buyer-update/';

  final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
  };
  Map<String, dynamic> body = {};

  body = {
    "buyer": user.id,
    "batch_string": batchString,
  };

  final http.MultipartRequest request =
      http.MultipartRequest('PUT', Uri.parse(apiUrl));

  for (String key in body.keys) {
    request.fields[key] = "${body[key]}";
  }

  request.headers.addAll(headers);

  final http.Response response =
      await http.Response.fromStream(await request.send());
  if (response.statusCode == 200) {
    print("responses status code: ${response.statusCode}");
    print("responses body: ${response.body}");
    return 'done';
  } else {
    print("responses status code: ${response.statusCode}");
    print("responses body: ${response.body}");
    return 'failed';
  }
}

Future<Map<String, dynamic>> registerUser(Map<String, dynamic> formData) async {
  String apiUrl = 'https://kayegrace14.pythonanywhere.com/api/register-buyer/';

  final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
  };

  final Map<String, dynamic> body = formData;

  print("this is the body: $body");

  final http.MultipartRequest request =
      http.MultipartRequest('POST', Uri.parse(apiUrl));

  for (String key in body.keys) {
    request.fields[key] = "${body[key]}";
  }

  request.headers.addAll(headers);

  final http.Response response =
      await http.Response.fromStream(await request.send());

  print(
      "responses is: ${response.body}------------------------------------------------------------------------------");
  if (response.statusCode == 201) {
    Map<String, dynamic> data = jsonDecode(response.body);
    return {"status": "done", "data": data};
  } else {
    return {'status': "failed"};
  }
}
