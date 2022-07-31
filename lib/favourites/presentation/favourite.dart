import 'package:advice_slip_test/favourites/bloc/favourites_bloc.dart';
import 'package:advice_slip_test/favourites/data/repository/favourites-repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final _todoTitleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _todoTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouritesBloc(
        RepositoryProvider.of<FavouritesRepository>(context),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Favourites",
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: FavouritesList(),
          ),
        ),
      ),
    );
  }
}

class FavouritesList extends StatelessWidget {
  const FavouritesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritesBloc, FavouritesState>(
      builder: (context, state) {
        if (state is FavouritesLoaded) {
          if (state.listOfFavourites.isEmpty) {
            return Center(
              child: Text(
                "Nothing found",
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: state.listOfFavourites.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Dismissible(
                  background: Container(
                    color: Colors.redAccent,
                  ),
                  key: Key(state.listOfFavourites[index].slip!.id.toString()),
                  onDismissed: (direction) {
                    context.read<FavouritesBloc>().add(RemoveFavourites(
                        state.listOfFavourites[index].slip!.id.toString()));
                  },
                  child: ListTile(
                    tileColor: Colors.black87,
                    title: Text(
                      state.listOfFavourites[index].slip!.advice!,
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.5,
                              fontWeight: FontWeight.normal),
                        )
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
