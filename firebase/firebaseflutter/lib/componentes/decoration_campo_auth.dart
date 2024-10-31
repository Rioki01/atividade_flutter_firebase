import 'package:flutter/material.dart';

InputDecoration getAuthenticationInputDecoration(String Label){
  return InputDecoration(
    hintText: Label,
    fillColor: Colors.white,
    filled: true,
    contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
  );
}