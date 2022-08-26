import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/components/app_colors.dart';

import 'cubit/marvel_cubit.dart';
import 'cubit/marvel_state.dart';

class CenterScreen extends StatefulWidget {
  const CenterScreen({Key? key}) : super(key: key);

  @override
  State<CenterScreen> createState() => _CenterScreenState();
}

class _CenterScreenState extends State<CenterScreen> {
  late MarvelCubit _cubit;
  int? _selectedIndex;
  String? _nameMovie;
  String? _imgUrL;
  String? _saga;

  @override
  void initState() {
    _cubit = BlocProvider.of<MarvelCubit>(context);
    callCubit();
    super.initState();
  }

  void callCubit() {
    _cubit.getMarvel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.vermelho,
      body: BlocConsumer<MarvelCubit, MarvelState>(
        listener: (context, state) {
          if (state is MarvelLoaded) {
            print("Sucesso");

            _selectedIndex = state.marvelModel!.data!.length;
          }
          if (state is MarvelError) {
            Scaffold.of(context);
            SnackBar(
              content: Text(state.error),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
                ),
                itemCount: _selectedIndex ?? 10,
                itemBuilder: (BuildContext contex, index) {
                  if (state is MarvelLoaded) {
                    _nameMovie = state.marvelModel!.data![index].title;
                    _imgUrL = state.marvelModel!.data![index].coverUrl;
                    _saga = state.marvelModel!.data![index].saga;
                  }
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage(_imgUrL!),
                            fit: BoxFit.scaleDown)),
                    child: Row(
                      children: [
                        Text(
                          _nameMovie ?? "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              backgroundColor: AppColors.vermelho),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          _saga ?? "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              backgroundColor: AppColors.vermelho),
                        ),
                      ],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
