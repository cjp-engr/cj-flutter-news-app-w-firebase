import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:news_app_with_firebase/constants/constants.dart';
import 'package:news_app_with_firebase/models/news.dart';
import 'package:news_app_with_firebase/models/user_custom_error.dart';

class SavedNewsRepository {
  final FirebaseFirestore firebaseFirestore;
  SavedNewsRepository({
    required this.firebaseFirestore,
  });

  String get _userUid {
    final fb_auth.User user = authNewsRepo.currentUser!;
    final uid = user.uid;
    return uid;
  }

  Future<void> saveNews(News news) async {
    try {
      await usersRef.doc(_userUid).collection('news').doc('savedNews').set(
        {
          news.id!: {
            'id': news.id,
            'title': news.title,
            'creators': news.creators,
            'description': news.description,
            'content': news.content,
            'publishedDate': news.publishedDate,
            'imageUrl': news.imageUrl,
            'countries': news.countries,
            'categories': news.categories,
            'fullDescription': news.fullDescription,
            'isSaved': news.isSaved,
          }
        },
        SetOptions(merge: true),
      );
      //return news.id!;
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> removeSavedNews(String id) async {
    try {
      await usersRef
          .doc(_userUid)
          .collection('news')
          .doc('savedNews')
          .update({id: FieldValue.delete()})
          .then((value) => log('News unsaved'))
          .catchError((error) => log('Failed to delete'));
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<dynamic> readSavedNews() async {
    try {
      DocumentSnapshot documentSnapshot = await usersRef
          .doc(_userUid)
          .collection('news')
          .doc('savedNews')
          .get();
      if (documentSnapshot.exists) {
        var data = documentSnapshot.data() as Map;

        return data;
      }
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }
}
