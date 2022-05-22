import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_app/res/custom_colors.dart';
import 'package:flutter_app_app/screens/edit_screen.dart';
import 'package:flutter_app_app/utils/database.dart';
import 'package:readmore/readmore.dart';

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// 1- ui of ItemList that show in DashboardScreen [ Title , Description , Image ]///
    return StreamBuilder<QuerySnapshot>(
      /// 2- code to read data content from firebase and display them in screen ///
      stream: Database.readItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var noteInfo = snapshot.data!.docs[index].data();
              String docID = snapshot.data!.docs[index].id;
              String title = noteInfo['title'];

              String description = noteInfo['description'];
              String image = noteInfo['image'];

              return Container(
                decoration: BoxDecoration(
                  color: CustomColors.firebaseWhite.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  trailing: IconButton(
                    alignment: Alignment.topRight,
                    icon: Icon(
                      Icons.edit,
                      size: 20,
                    ),

                    /// 3- navigator to EditScreen for editing data content when click any itemlist to re-correction and update data to firebase ///
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditScreen(
                          currentTitle: title,
                          currentDescription: description,
                          currentImage: image,
                          documentId: docID,
                        ),
                      ),
                    ),
                  ),

                  // onTap: () => Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => EditScreen(
                  //       currentTitle: title,
                  //       currentDescription: description,
                  //       currentImage: image,
                  //       documentId: docID,
                  //     ),
                  //   ),
                  // ),
                  title: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        color: CustomColors.firebaseTealAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  leading: Image.network(
                    image,
                    width: 40,
                  ),
                  subtitle: ReadMoreText(
                    description,
                    style: TextStyle(
                        color: CustomColors.firebaseWhite,
                        fontWeight: FontWeight.bold),
                    trimLines: 3,
                    colorClickableText: CustomColors.firebaseRedAccent,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'more',
                    trimExpandedText: 'less',
                    moreStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.firebaseYellowAccent),
                  ),
                ),
              );
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              CustomColors.firebaseOrange,
            ),
          ),
        );
      },
    );
  }
}