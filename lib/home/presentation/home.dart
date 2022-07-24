import 'package:advice_slip_test/home/bloc/advice_bloc.dart';
import 'package:advice_slip_test/home/data/repository/advice_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdviceBloc(
        RepositoryProvider.of<AdviceRepository>(context),
      )..add(LoadAdviceEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('The Advice App',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),),
          leading: IconButton(
            icon: const Icon(Icons.favorite_outlined),
            onPressed: () {

            },
          ),
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
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        state.advice.slip!.advice!,
                        textAlign: TextAlign.center,
                      ),
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.brown
                          ),
                          onPressed: () {

                          },
                          child: Text('Save',
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent
                      ),
                      onPressed: () {
                        BlocProvider.of<AdviceBloc>(context).add(LoadAdviceEvent());
                      },
                      child: Text('Load New Advice',
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),),
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
      ),
    );
  }
}