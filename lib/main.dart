import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast_app/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primaryColor: Colors.black,primarySwatch: Colors.blue),
        initialRoute: RouteManager.getPodcastDetailsScreen(),
        getPages: RouteManager.appRoutes,
      ),
    );
  }
}
