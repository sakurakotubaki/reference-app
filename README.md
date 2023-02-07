# review_app
userコレクションからreivewコレクションのデータをreference型を使って呼び出す。

```
- reivew
 - "美味しかったです"(commentフィールド)
 - "佐藤"(nameフィールド)

- user
 - "田中太郎"(nameフィールド)
 - review/GUlxvkd2Ua36mH23LDcB(referenceフィールド)
```

## referenceを扱う方法
```dart
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
```

# 画面に描画するコード
```dart
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
```
