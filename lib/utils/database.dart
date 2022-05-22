import 'package:cloud_firestore/cloud_firestore.dart';

/// 1-to define the main collection that stored all content ; after add a post and run the app . It will be visible in your firebase console .
final CollectionReference _mainCollection =
FirebaseFirestore.instance.collection('posts');

/// 2- in this class we will coding of CRUD methods . ///
class Database {
  ///  3- define the variable of ID document to divide the categories of posts ///
  static String? idDocs;

  /// 4- We will start coding the add method operation to add data content to firebase.///
  static Future<void> addItem({
    /// 5- define the content of post ///
    required String title,
    required String description,
    required String image,
  }) async {
    /// 6-the path of stored data in cloud firestore ///
    DocumentReference documentReferencer =
    _mainCollection.doc(idDocs).collection('items').doc();

    /// 7-to convert data to map ///
    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "image": image,
    };

    /// 8- We use the set() method on the documentReferencer to write new data to the Firestore, and we have passed the data as a map  ///
    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  /// 9- We will  coding the update method operation to update data content to firebase.///
  static Future<void> updateItem({
    required String title,
    required String description,
    required String docId,
    required String image,
  }) async {
    DocumentReference documentReferencer =
    _mainCollection.doc(idDocs).collection('items').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "image": image,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  /// 10- We will  coding the read method operation to read data content to firebase.///
  /// 11- here We will use Strem instead of Future to get latest data available in the database for automatically synchronize data ///

  static Stream<QuerySnapshot> readItems() {
    CollectionReference postsItemCollection =
    _mainCollection.doc(idDocs).collection('items');

    return postsItemCollection.snapshots();
  }

  /// 12- We will coding the delete method operation to delete data content to firebase.///

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
    _mainCollection.doc(idDocs).collection('items').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
