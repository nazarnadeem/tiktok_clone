import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/views/screens/search_screen.dart';
import 'package:tiktok_clone/views/screens/video_screen.dart';
import 'views/screens/add_video_screen.dart';
import 'views/screens/profile_screen.dart';

// PAGES
List<Widget> pages = [
  VideoScreen(),
  const AddVideoScreen(),
  SearchScreen(),
  ProfileScreen(
    uid: authController.user.uid,
  ),
];

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// Firebase

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firebaseFirestore = FirebaseFirestore.instance;

// Controllers

var authController = AuthController.instance;
