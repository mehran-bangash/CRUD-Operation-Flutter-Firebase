import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practise_app/pages/add_detail.dart';
import 'package:practise_app/services/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Stream? streamMessage;

  TextEditingController namecontroller=TextEditingController();
  TextEditingController agecontroller=TextEditingController();
  TextEditingController locationcontroller=TextEditingController();

  getLoadData() async {
    Stream dataStream = await DatabaseMethod().getUserdata();
    setState(() {
      streamMessage = dataStream;
    });
  }

  @override
  void initState() {
    super.initState();
    getLoadData();
  }

  Widget showUserDetail() {
    return streamMessage != null
        ? StreamBuilder(
      stream: streamMessage,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data.docs[index];
              return Container(
                margin: EdgeInsets.all(7),
                  child: Material(
                elevation: 5,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            children:[
                              Text(
                                "Name :" + document["Name"],
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                          SizedBox(width: 200,),
                          Container(
                            child: IconButton(onPressed: () {
                              namecontroller.text=document["Name"];
                              agecontroller.text=document["Age"];
                              locationcontroller.text=document["Location"];
                              EditUserDetail(document["Id"]);

                            }, icon: Icon(Icons.edit,color: Colors.black,)),
                          ),
                              Container(
                                child: IconButton(onPressed: () async{
                            await      DatabaseMethod().deleteUserData(document["Id"]);

                                }, icon: Icon(Icons.delete,color: Colors.black,)),
                              )
                          
                          
                        ]),
                        Text(
                          "Age :" + document["Age"],
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Location:" + document["Location"],
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              )
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    )
        : Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddDetail(),));
        },
      ),
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 92, 39, 176),
        title: Text(
          "Practise App ",
          style: GoogleFonts.poppins(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [


            Expanded(
              child:  Container(child:showUserDetail() ,)  ,

            ),

        ],
      ),
    );
  }
  Future EditUserDetail(String id)=>showDialog(context: context, builder: (context) => AlertDialog(
    content: Container(child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Row(children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child:Icon(Icons.cancel) ,),
        const SizedBox(width: 60,),
        Text(
          "Edit",
          style: GoogleFonts.nunito(
              fontSize: 18,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "Detail",
          style: GoogleFonts.nunito(
              fontSize: 18,
              color: Colors.orange,
              fontWeight: FontWeight.bold),
        ),
      ],),
     const SizedBox(height: 20,),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Name",
              style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: TextField(
          controller: namecontroller,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20))),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Age",
              style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: TextField(
          controller: agecontroller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20))),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Location",
              style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: TextField(
          controller: locationcontroller,
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20))),
        ),
      ),const SizedBox(height: 30,),
        ElevatedButton(
          style: ButtonStyle(
              minimumSize: WidgetStateProperty.all(Size(100, 50)),
              overlayColor:
              WidgetStateProperty.all(Colors.orangeAccent),
              backgroundColor:
              WidgetStateProperty.all(Colors.white)),
          child: Text(
            "Update Detail",
            style: GoogleFonts.nunito(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () async{
           Map<String ,dynamic>UpdateInfo={
             "Name":namecontroller.text,
             "Age":agecontroller.text,
             "Id":id,
             "Location":locationcontroller.text
           };
           setState(() {

           });
          await DatabaseMethod().updateUserData(id, UpdateInfo).then((value) => Navigator.pop(context),);
          },
        ),

    ],),),




  ),);
}
