import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:get/get.dart';

class CallView{

  Future getLogs()
  async{
    Box box = await Hive.openBox('calllogs');
    return box.values.toList();
  }

  Future deletelog(log_id)
  async{
    Box box = await Hive.openBox('calllogs');
    box.delete(log_id);
  }

  Future createcall(contact_id,context,call_type)
  async{
    Box user = await Hive.openBox('user');
    Box contacts = await Hive.openBox('contacts');
    Box box = await Hive.openBox('calllogs');

    final response = await http.get(
      Uri.parse('http://217.21.78.14:8000/mz_cl/create/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authrorization': 'token ${user.get("token")}'
      },
    );
    if(response.statusCode == 200){

      dynamic data = jsonDecode(response.body);

      data["contact"] = contacts.get(contact_id);
      data["call_type"] = call_type;

      box.put(data["call_id"], data);
      GFToast.showToast("Call Created", context,toastPosition: GFToastPosition.BOTTOM);
      Get.back();
    }

    else{
      GFToast.showToast(response.statusCode.toString(), context);

    }
  }
}