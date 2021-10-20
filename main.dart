import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  ));
}

class MyAppAnasayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnaEkran(),
    );
  }
}

class AnaEkran extends StatefulWidget {
  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {


  String commentName = "";
  String commentSurname = "";

  String email = "";
  String yorumm = "";
  String data = "";
  String name = "";


  void initState() {
    super.initState();
    
    //Receiving the email of the account entered
    email = FirebaseAuth.instance.currentUser!.email.toString();
    print(email);

    //get first and last name
    FirebaseFirestore.instance
        .collection("Users") //get "users" collection
        .doc(email) //get email doc
        .get()
        .then((gelenVeri) {
      setState(() {
        commentName = gelenVeri.data()!['name']; //get name
        commentSurname = gelenVeri.data()!['surname']; //get surname
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 33, 33,1),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( //list records in database with streambuilder
            stream: FirebaseFirestore.instance
                .collection("Users") //"Users" collection
                .doc(email)// Email doc
                .collection("Shares")//"Shares" collection
                .snapshots(),
            builder: (context, veriler) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: veriler.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot dokumanVerisi = veriler.data!.docs[index];

                    return SingleChildScrollView(
                        child: SizedBox(
                      height: 700.0,
                      width: 350.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            height: 550,
                            child: Card(
                           
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Stack(
                                      children: <Widget>[

                                        Container(
                                          width: 350.0,
                                          height:230.0,
                                          child: Image.network(

                                              veriler.data!.docs[index]
                                                  .data()['Url'] ??
                                              "https://www.indyturk.com/sites/default/files/styles/1368x911/public/article/main_image/2019/09/25/175131-673560213.png?itok=C-5dwxza"),

                                        ),

                                        Stack(
                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
                                                  width: 70.0,
                                                  height: 70.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all( Radius.circular(50.0)),
                                                    border: Border.all(
                                                      color: Color.fromRGBO(156, 204, 101, 1),
                                                      width: 6.0,
                                                    ),
                                                  ),

                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        veriler.data!.docs[index]
                                                            .data()['totalParticipants'].toString(),
                                                        style: TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.white,
                                                        ),

                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),

                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 170, 0, 0),
                                          child: Row(

                                            children: <Widget>[
                                              CircleAvatar(
                                                radius: 30.0,
                                                backgroundImage: NetworkImage(
                                                  veriler.data!.docs[index]
                                                      .data()['profilePhoto'] ??
                                                      'https://e7.pngegg.com/pngimages/969/831/png-clipart-female-silhouette-drawing-silhouette-animals-silhouette.png',
                                                ),
                                              ),



                                              Container(
                                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                child: Text(
                                                  veriler.data!.docs[index]
                                                      .data()['name'] + " " +
                                                      veriler.data!.docs[index]
                                                          .data()['surname'],
                                                  style: TextStyle(
                                                    backgroundColor: Colors.white,
                                                    color: Color.fromRGBO(
                                                        3, 155, 229, 1),
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],

                                    ),


                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 15, 0, 0),
                                            child: Container(
                                              child: Text(
                                                "Etkinlik adı: ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 15, 0, 0),
                                            child: Container(
                                              child: Text(
                                                veriler.data!.docs[index]
                                                    .data()['activityName'] ??
                                                    'default data',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 15, 0, 0),
                                            child: Container(
                                              child: Text(
                                                "Etkinlik tarihi: ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 15, 0, 0),
                                            child: Container(
                                              child: Text(
                                                veriler.data!.docs[index]
                                                    .data()['activityDate'] ??
                                                    'default data',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 15, 0, 0),
                                            child: Container(
                                              child: Text(
                                                "Etkinlik saati: ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 15, 0, 0),
                                            child: Container(
                                              child: Text(
                                                veriler.data!.docs[index]
                                                    .data()['activityHour'] ??
                                                    'default data',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 15, 0, 0),
                                            child: Container(
                                              child: Text(
                                                "Etkinlik ücreti: ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 15, 0, 0),
                                            child: Container(
                                              child: Text(
                                                veriler.data!.docs[index]
                                                    .data()['activityPay'] ??
                                                    'default data',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[

                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,

                                                children: <Widget>[

                                                  StreamBuilder<
                                                      QuerySnapshot<Map<
                                                          String,
                                                          dynamic>>>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                        "Users")
                                                        .doc(email)
                                                        .collection(
                                                        "Events")
                                                        .snapshots(),
                                                    builder: (context,
                                                        veri) {
                                                      bool pres2 = false;
                                                      for (var id in veri
                                                          .data!.docs) {
                                                        if (veriler.data!
                                                            .docs[index]
                                                            .id ==
                                                            id.id) {

                                                          pres2 = true;
                                                        }
                                                      }
                                                      return IconButton(
                                                        icon: Icon(Icons
                                                            .thumb_up),
                                                        color: (pres2)
                                                            ? Colors.green
                                                            : Colors
                                                            .blueGrey,
                                                        onPressed: () {
                                                          if (pres2) {
                                                            //Activity is delete
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                "Users")
                                                                .doc(
                                                                email)
                                                                .collection(
                                                                "Events")
                                                                .doc(
                                                                veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .id)
                                                                .delete();
                                                          } else {
                                                            setState(() {
                                                              //Activity added
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                  "Users")
                                                                  .doc(
                                                                  email)
                                                                  .collection(
                                                                  "Events")
                                                                  .doc(
                                                                  veriler
                                                                      .data!
                                                                      .docs[index]
                                                                      .id)
                                                                  .set({
                                                                'name': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['name'],
                                                                'surname': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['surname'],
                                                                'activityDate': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['activityDate'],
                                                                'pPhoto': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['pPhoto'],
                                                                'activityHour': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['activityHour'],
                                                                'activityName': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['activityName'],
                                                                'activityPay': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['activityPay'],
                                                                'picUrl': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['picUrl'],
                                                                'totalParticipants': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['totalParticipants']
                                                              })
                                                                  .whenComplete(() =>
                                                                  print(
                                                                      'etkinlik eklendi'));

                                                             

                                                              if(tip=="İşletme Sahibi")
                                                                {
                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (BuildContext context) {
                                                                        return AlertDialog(
                                                                          title: Text("TEKLİF EKRANI"),
                                                                          content: new ListView(
                                                                            shrinkWrap: true,
                                                                            padding: const EdgeInsets.all(8.0),
                                                                            children: <Widget>[

                                                                              Container(
                                                                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                                                                  width: 250.0,
                                                                                  height: 200.0,
                                                                                child:Column(
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 240.0,
                                                                                        child: TextField(
                                                                                            controller: teklifFiyat,
                                                                                            style: TextStyle(
                                                                                              color: Colors.black,
                                                                                            ),
                                                                                            decoration: InputDecoration(
                                                                                              focusedBorder: OutlineInputBorder(
                                                                                                borderSide: BorderSide(color: Colors.indigo,),
                                                                                              ),
                                                                                              labelText: 'Teklifinizi giriniz',
                                                                                              labelStyle: TextStyle(
                                                                                                color: Colors.indigo,
                                                                                              ),
                                                                                            ),
                                                                                          ),

                                                                                    ),
                                                                                    Container(
                                                                                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                                                                      child: RaisedButton(
                                                                                        child: Text('Etkinlik sahibine gönder'),
                                                                                        color: Colors.blueAccent,
                                                                                        onPressed: () {
                                                                                          setState(() {

                                                                                            FirebaseFirestore.instance
                                                                                                .collection("Users")
                                                                                                .doc(veriler
                                                                                                .data!
                                                                                                .docs[index]['email'])
                                                                                                .collection(
                                                                                            "Offers")
                                                                                                .doc()
                                                                                                .set({
                                                                                            'name': commentName,
                                                                                            'surname': commentSurname,
                                                                                            'email': email,
                                                                                              'offer': int.parse(teklifFiyat.text)
                                                                                            }).then((value) => Navigator.pop(context));

                                                                                          });

                                                                                        },
                                                                                      ),
                                                                                    ),

                                                                                  ],
                                                                                )

                                                                              )








                                                                            ],
                                                                          ),
                                                                        );
                                                                      });
                                                                }

                                                              else{
                                                                showDialog(
                                                                    context: context,
                                                                    builder: (BuildContext context) {
                                                                      return AlertDialog(
                                                                        title: Text("ÖDEME EKRANI"),
                                                                        content: new ListView(
                                                                          shrinkWrap: true,
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          children: <Widget>[


                                                                            Container(
                                                                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                                                              width: 250.0,

                                                                              child: Column(
                                                                                children: <Widget>[
                                                                                  Container(

                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: <Widget>[
                                                                                        Icon(
                                                                                          Icons.shopping_cart,
                                                                                          color: Colors.green,
                                                                                          size: 50,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: <Widget>[
                                                                                        Container(
                                                                                          width: 200,
                                                                                          padding: EdgeInsets.all(10),
                                                                                          child: TextField(
                                                                                            controller: kartIsim,
                                                                                            style: TextStyle(
                                                                                              color: Colors.black,
                                                                                            ),
                                                                                            decoration: InputDecoration(
                                                                                              focusedBorder: OutlineInputBorder(
                                                                                                borderSide: BorderSide(color: Colors.indigo,),
                                                                                              ),
                                                                                              labelText: 'Kart üzerindeki isim',
                                                                                              labelStyle: TextStyle(
                                                                                                color: Colors.indigo,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ]),

                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 200,
                                                                                        padding: EdgeInsets.all(10),
                                                                                        child: TextField(
                                                                                          controller: kartNumarasi,
                                                                                          style: TextStyle(
                                                                                            color: Colors.black,
                                                                                          ),
                                                                                          decoration: InputDecoration(
                                                                                            focusedBorder: OutlineInputBorder(
                                                                                              borderSide: BorderSide(color: Colors.indigo,),
                                                                                            ),
                                                                                            labelText: 'Kart numarası',
                                                                                            labelStyle: TextStyle(
                                                                                              color: Colors.indigo,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),

                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Container(
                                                                                        padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                                                                                        child: Text(

                                                                                            "Son kullanma tarihi:",
                                                                                            style:TextStyle(
                                                                                              color: Colors.indigo,

                                                                                            )
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),

                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: <Widget>[

                                                                                      Container(
                                                                                        width: 100,
                                                                                        padding: EdgeInsets.all(10),
                                                                                        child: TextField(
                                                                                          controller: kartAy,
                                                                                          style: TextStyle(
                                                                                            color: Colors.black,
                                                                                          ),
                                                                                          decoration: InputDecoration(
                                                                                            focusedBorder: OutlineInputBorder(
                                                                                              borderSide: BorderSide(color: Colors.indigo,),
                                                                                            ),
                                                                                            labelText: 'Ay',
                                                                                            labelStyle: TextStyle(
                                                                                              color: Colors.indigo,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),

                                                                                      Container(
                                                                                        width: 100,
                                                                                        padding: EdgeInsets.all(10),
                                                                                        child: TextField(
                                                                                          controller: kartYil,
                                                                                          style: TextStyle(
                                                                                            color: Colors.black,
                                                                                          ),
                                                                                          decoration: InputDecoration(
                                                                                            focusedBorder: OutlineInputBorder(
                                                                                              borderSide: BorderSide(color: Colors.indigo,),
                                                                                            ),
                                                                                            labelText: 'Yıl',
                                                                                            labelStyle: TextStyle(
                                                                                              color: Colors.indigo,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),


                                                                                    ],
                                                                                  ),



                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 200,
                                                                                        padding: EdgeInsets.all(10),
                                                                                        child: TextField(
                                                                                          controller: kartCVV,
                                                                                          style: TextStyle(
                                                                                            color: Colors.black,
                                                                                          ),
                                                                                          decoration: InputDecoration(
                                                                                            focusedBorder: OutlineInputBorder(
                                                                                              borderSide: BorderSide(color: Colors.indigo,),
                                                                                            ),
                                                                                            labelText: 'CVV',
                                                                                            labelStyle: TextStyle(
                                                                                              color: Colors.indigo,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),

                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: <Widget>[
                                                                                      Container(
                                                                                        child: RaisedButton(
                                                                                          child: Text('Ödeme Yap'),
                                                                                          color: Colors.amberAccent,
                                                                                          onPressed: () {
                                                                                            setState(() {
                                                                                              if(kartIsim.text.isEmpty || kartAy.text.isEmpty || kartNumarasi.text.isEmpty || kartYil.text.isEmpty || kartCVV.text.isEmpty)
                                                                                              {

                                                                                                print(index);
                                                                                                visibleText=true;
                                                                                              }
                                                                                              else
                                                                                              {



                                                                                              }

                                                                                            });
                                                                                          },
                                                                                        ),
                                                                                      ),



                                                                                    ],
                                                                                  ),

                                                                                  Row(
                                                                                    children: [
                                                                                      new Visibility(
                                                                                        child: Container(
                                                                                          child: Text("Boş alan bırakmayınız.",
                                                                                            style: TextStyle(
                                                                                              color: Colors.red,

                                                                                            ),

                                                                                          ),
                                                                                        ),
                                                                                        visible: visibleText,
                                                                                      ),
                                                                                    ],
                                                                                  ),

                                                                                ],

                                                                              ),
                                                                            ),




                                                                          ],
                                                                        ),
                                                                      );
                                                                    });

                                                              }

                                                            });
                                                          }
                                                        },
                                                        iconSize: 24.0,
                                                      );
                                                    },
                                                  ),


                                                  StreamBuilder<
                                                      QuerySnapshot<Map<
                                                          String,
                                                          dynamic>>>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                        "Users")
                                                        .doc(email)
                                                        .collection(
                                                        "favs")
                                                        .snapshots(),
                                                    builder: (context,
                                                        veri) {
                                                      bool pres = false;
                                                      for (var id in veri
                                                          .data!.docs) {
                                                        if (veriler.data!
                                                            .docs[index]
                                                            .id ==
                                                            id.id) {
                                                          pres = true;
                                                        }
                                                      }
                                                      return IconButton(
                                                        icon: Icon(Icons
                                                            .favorite),
                                                        color: (pres)
                                                            ? Colors.red
                                                            : Colors
                                                            .blueGrey,
                                                        onPressed: () {
                                                          if (pres) {
                                                            //FAVORİ SİLİNİYOR
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                "Users")
                                                                .doc(
                                                                email)
                                                                .collection(
                                                                "favs")
                                                                .doc(
                                                                veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .id)
                                                                .delete();
                                                          } else {
                                                            setState(() {
                                                              //FAVORİ EKLENİYOR
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                  "Users")
                                                                  .doc(
                                                                  email)
                                                                  .collection(
                                                                  "favs")
                                                                  .doc(
                                                                  veriler
                                                                      .data!
                                                                      .docs[index]
                                                                      .id)
                                                                  .set({
                                                                'name': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['name'],
                                                                'surname': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['surname'],
                                                                'activityDate': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['activityDate'],
                                                                'pPhoto': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['pPhoto'],
                                                                'activityHour': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['activityHour'],
                                                                'activityName': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['activityName'],
                                                                'activityPay': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['activityPay'],
                                                                'picUrl': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['picUrl'],
                                                                'totalParticipants': veriler
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()['totalParticipants']
                                                              })
                                                                  .whenComplete(() =>
                                                                  print(
                                                                      'favlandı'));
                                                            });
                                                          }
                                                        },
                                                        iconSize: 24.0,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                      ],
                                    ),



                                    Row(

                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            width: 335,
                                            child: new TextField(
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              keyboardType: TextInputType
                                                  .multiline,
                                              maxLines: null,
                                              onChanged: (String yorum) {
                                                yorumm = yorum;
                                              },
                                              decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                ),
                                                hintText: 'Yorum yapınız',
                                              ),
                                            ))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                          child: RaisedButton(
                                            child: Text('Gönder'),
                                            onPressed: () {
                                              setState(() {
                                                FirebaseFirestore.instance
                                                    .collection("Users")
                                                    .doc(email)
                                                    .collection(
                                                    "followShares")
                                                    .doc(veriler
                                                    .data!.docs[index].id)
                                                    .collection(
                                                    "Comments")
                                                    .doc()
                                                    .set({
                                                  'name': commentName,
                                                  'surname': commentSurname,
                                                  'comment': yorumm,
                                                });

                                                FirebaseFirestore.instance
                                                    .collection("Users")
                                                    .doc(veriler
                                                    .data!
                                                    .docs[index]['email'])
                                                    .collection(
                                                    "Comments")
                                                    .doc()
                                                    .set({
                                                  'name': commentName,
                                                  'surname': commentSurname,
                                                  'comment': yorumm,
                                                });
                                              });
                                              yorumController.clear();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),

                                    

                                  ],
                                ),
                                borderOnForeground: false,
                                elevation: 8,
                                color: Color.fromRGBO(50, 50, 50, 1)),
                          ),
                        ],
                      ),
                    ));
                  });
            }));
  }
}
