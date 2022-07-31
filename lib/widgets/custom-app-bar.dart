import 'package:advice_slip_test/bloc/connectivity/connected_bloc.dart';
import 'package:advice_slip_test/favourites/presentation/favourite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConnectedBloc connectedBloc = ConnectedBloc();
    return  BlocProvider<ConnectedBloc>(
      create: (context) => connectedBloc,
      child: Stack(
        children: [
          AppBar(
            title: Text(
              'The Advice App',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_outlined),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Favourite()));
                },
              ),
            ],
          ),
          BlocListener<ConnectedBloc, ConnectedState>(
            listener: (context, state) {
             if (state is ConnectedFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Internet Lost')));
              }
            },
            child: const SizedBox(),
          ),
        ],
      ),
    );
  }
}