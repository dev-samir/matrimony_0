import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:matrimony_0/create_account.dart';
import 'package:matrimony_0/home.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:matrimony_0/login.dart';

void main() {
  runApp(MaterialApp(
    home: Homepage(),
  ));
}
