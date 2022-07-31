import 'package:advice_slip_test/favourites/bloc/favourites_bloc.dart';
import 'package:advice_slip_test/home/bloc/advice_bloc.dart';
import 'package:advice_slip_test/home/data/model/advice_model.dart';
import 'package:advice_slip_test/widgets/custom-app-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const  Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar()
      ),
      body: BlocBuilder<AdviceBloc, AdviceState>(
        builder: (context, state) {
          if (state is AdviceLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AdviceLoadedState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ExpansionTile(
                    iconColor: Colors.white,
                    title: Text(
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      state.advice.slip!.advice!,
                      textAlign: TextAlign.center,
                    ),
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.brown),
                        onPressed: () {
                          loadNewAdvice(context);
                          const snackBar = SnackBar(
                            content: Text('Advice saved to favourites!'),
                          );
                          context.read<FavouritesBloc>().add(
                              AddFavourites(AdviceModel(slip: state.advice.slip!)));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Text(
                          'Save',
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                    onPressed: () {
                      loadNewAdvice(context);
                    },
                    child: Text(
                      'Load New Advice',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is AdviceErrorState) {
            return Center(
              child: Text(state.error.toString()),
            );
          }
          return Container();
        },
      ),
    );
  }

  void loadNewAdvice(BuildContext context) {
    BlocProvider.of<AdviceBloc>(context).add(LoadAdviceEvent());
  }
}


