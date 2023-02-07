import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  DocumentSnapshot<Map<String, dynamic>>? user;
  DocumentSnapshot<Map<String, dynamic>>? review;

  bool get isLoading => user == null || review == null;

  /// 1. Userドキュメントを取得する
  /// 2. Reviewドキュメントを取得する
  /// 3. それを画面上に表示させる

  Future<void> fetchReview() async {
    // 1. Userドキュメントを取得する

    user = await FirebaseFirestore.instance
        .collection('user')
        .doc('MxFQfEG625132EjoqzAe')
        .get();

    // 1.5 userドキュメントから review の reference 情報を取得している
    final reviewReference =
        user!.data()!['reference'] as DocumentReference<Map<String, dynamic>>;

    // 2. Reviewドキュメントを取得する
    review = await reviewReference.get();
    setState(() {});
  }

  void addPost() async {
    final ref = FirebaseFirestore.instance;
    final docRef = await ref.collection('review').doc('GUlxvkd2Ua36mH23LDcB');
    await ref.collection('user').doc('MxFQfEG625132EjoqzAe').set({
      'name': '田中太郎',
      'reference': docRef,
    });
  }

  @override
  void initState() {
    fetchReview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GettingStarted'),
      ),
      body: isLoading
          ? const SizedBox.shrink()
          : Column(
              children: [
                // 3. それを画面上に表示させる
                Text(user!.data()!['name']),
                Text(review!.data()!['comment']),
              ],
            ),
    );
  }
}
