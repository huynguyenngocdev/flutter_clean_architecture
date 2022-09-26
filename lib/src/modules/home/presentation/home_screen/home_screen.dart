import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/src/core/utils/extensions/build_context.dart';
import 'package:flutter_clean_architecture/src/modules/app/routes.dart';
import 'package:flutter_clean_architecture/src/modules/home/presentation/bloc/film_bloc/film_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

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
            Expanded(
                child: BlocConsumer<FilmBloc, FilmState>(
                    builder: (ctx, state) {
                      if (state.status.toString() == 'loadSuccess') {
                        return ListView.separated(
                            itemBuilder: (context, index) => ListTile(
                                leading:
                                    Image.network(state.films[index].image),
                                title: Text(state.films[index].image)),
                            separatorBuilder: (context, index) =>
                                const Divider(height: 1),
                            itemCount: state.films.length);
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    listener: (ctx, state) {})),
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
