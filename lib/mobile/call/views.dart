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

  Future createcall(_selectedContacts,_updatedContacts,title,context)
  async{
    Box user = await Hive.openBox('user');
    Box box = await Hive.openBox('meetings');

    final response = await http.post(
      Uri.parse('http://217.21.78.14:8000/mz_cl/call/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authrorization': 'token ${user.get("token")}'
      },
    );
    if(response.statusCode == 200){
      GFToast.showToast("Call Created", context,toastPosition: GFToastPosition.BOTTOM);
      dynamic data = jsonDecode(response.body);
      box.put(data["call_id"], data);
      Get.back();
    }

    else{
      GFToast.showToast(response.statusCode.toString(), context);

    }
  }
}