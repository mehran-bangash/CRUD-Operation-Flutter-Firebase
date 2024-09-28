import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {

  // Add user Detail from Registraion and store on FirebaseFirestore
  Future addUserDetail(String id, Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  } // it Add user deatil on firebaseDirestore

  // get User data from Firebase For the purpose of login page
  Future<QuerySnapshot> getUserDetail(String email) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("Email", isEqualTo: email)
        .get();
  }

  // add User detail on Firebase firestore ......Create
  Future addUserDetailHome(String id,Map<String,dynamic>userinfoMap )async{

    return await  FirebaseFirestore.instance.collection("UserInfo").doc(id).set(userinfoMap);

  }
// Show User Data   ..............           Read
  Future<Stream<QuerySnapshot>> getUserdata()async{
     return await FirebaseFirestore.instance.collection("UserInfo").snapshots();
  }

  Future updateUserData(String id ,Map<String ,dynamic>UpdateInfo)async{

    return await FirebaseFirestore.instance.collection("UserInfo").doc(id).update(UpdateInfo);
  }
  Future deleteUserData(String id )async{

    return await FirebaseFirestore.instance.collection("UserInfo").doc(id).delete();
  }





}
