import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:film_caffe_aplikacija/models/EventReservationList.dart';
import 'package:film_caffe_aplikacija/models/Reservation.dart';
import 'package:film_caffe_aplikacija/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:film_caffe_aplikacija/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:film_caffe_aplikacija/services/auth_service.dart';
import 'package:film_caffe_aplikacija/screens/home.dart';
import 'package:film_caffe_aplikacija/wrapper.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'models/SpecialOffer.dart';
import 'models/email.dart';
import 'package:film_caffe_aplikacija/models/event.dart';
import 'package:film_caffe_aplikacija/models/Table.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  await Firebase.initializeApp();

  await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
 // var firebaseAppCheck=FirebaseAppCheck.instance;

  runApp(MultiProvider(
    providers: [
        //Provider<AuthService>(create: (_)=>AuthService(firebaseAuth: (FirebaseAuth.instance))),
        //StreamProvider(create: (context)=>context.read<AuthService>().authStateChanges, initialData: null)
        StreamProvider<User?>.value(value: AuthService().authStateChanges,
            initialData: null),
        StreamProvider<List<Email>?>.value(
            value: DatabaseService().adminEmails, initialData: null),
      StreamProvider<List<Event>?>.value(
          value: DatabaseService().events, initialData: null),
      StreamProvider<List<String>?>.value(
        value: DatabaseService().adminUserId,initialData: null,
      ),
      StreamProvider<List<TableCaffe>?>.value(
        value: DatabaseService().tableModles,initialData: null,
      ),
      StreamProvider<List<TablesLayout>?>.value(
        value: DatabaseService().tablesLayout,initialData: null,
      ),
      StreamProvider<List<FreeTable>?>.value(
        value: DatabaseService().freeTables,initialData: null,
      ),
      StreamProvider<List<PendingReservation>?>.value(
        value: DatabaseService().pendingReservations,initialData: null,
      ),
      StreamProvider<List<ApprovedReservation>?>.value(
        value: DatabaseService().approvedReservations,initialData: null,
      ),
      StreamProvider<List<SpecialOffer>?>.value(
        value: DatabaseService().specialOffers,initialData: null,
      ),
    ],
    child: MaterialApp(
      home:AuthWrapper()
    ),
  ));
}

