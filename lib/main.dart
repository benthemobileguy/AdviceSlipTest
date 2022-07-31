import 'package:advice_slip_test/bloc/connectivity/connected_bloc.dart';
import 'package:advice_slip_test/favourites/bloc/favourites_bloc.dart';
import 'package:advice_slip_test/favourites/data/repository/favourites-repository.dart';
import 'package:advice_slip_test/home/bloc/advice_bloc.dart';
import 'package:advice_slip_test/home/data/repository/advice_repository.dart';
import 'package:advice_slip_test/home/presentation/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  //Because hydrated bloc communicates with the native code, we must first ensure everything is natively initialised.
  HydratedBlocOverrides.runZoned(
    () => runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AdviceRepository()),
        RepositoryProvider(
          create: (context) => FavouritesRepository(),
        )
      ],
      child: MyApp(),
    )),
    createStorage: () async {
      WidgetsFlutterBinding.ensureInitialized();
      return HydratedStorage.build(
        storageDirectory: await getApplicationDocumentsDirectory(),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  final ConnectedBloc _connectedBloc = ConnectedBloc();
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey[900],
        backgroundColor: Colors.grey[900],
        scaffoldBackgroundColor: Colors.grey[900],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.grey[900],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _connectedBloc),
          BlocProvider(
              create: (context) => AdviceBloc(
                    RepositoryProvider.of<AdviceRepository>(context),
                  )..add(LoadAdviceEvent())),
          BlocProvider(
              create: (context) => FavouritesBloc(
                    RepositoryProvider.of<FavouritesRepository>(context),
                  )),
        ],
        child: const Home(),
      ),
    );
  }
}
