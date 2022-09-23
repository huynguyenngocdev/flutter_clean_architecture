import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/core/utils/extensions/build_context.dart';
import 'package:flutter_clean_architecture/src/modules/app/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(context.res().helloWorld),
            ElevatedButton(
                onPressed: () {
                  AppNavigator.push(Routes.secondScreen);
                },
                child: const Text("Navigate to... ->"))
          ],
        ),
      ),
    );
  }
}
