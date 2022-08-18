import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:get/get.dart';

class GroupView{

  Future getBox()
  async{
    Box box = await Hive.openBox('groups');
    return box;
  }

  Future deletegroup(group_id)
  async{
    Box box = await Hive.openBox('groups');
    box.delete(group_id);
  }

  Future creategroup(_selectedContacts,_updatedContacts,title,context)
  async{
      Box user = await Hive.openBox('user');
      Box box = await Hive.openBox('groups');

      final response = await http.post(
        Uri.parse('http://217.21.78.14:8000/mz_rm/room/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authrorization': 'token ${user.get("token")}'
        },
        body: jsonEncode(<dynamic, dynamic>{
          "title":title,
          "participants": _updatedContacts,
          "status":"upcoming",
          "image":null,
          "description":"",
          "group":true,
          "meeting":false,
          "private":false,
        }),
      );
      if(response.statusCode == 200){
        // print(response.body);
        GFToast.showToast("Group Created", context,toastPosition: GFToastPosition.BOTTOM);
        dynamic data = jsonDecode(response.body);
        data["deleted"] = false;
        box.put(data["room_id"], data);
        Get.back();
      }

      else{
        GFToast.showToast(response.statusCode.toString(), context);

      }
  }
}