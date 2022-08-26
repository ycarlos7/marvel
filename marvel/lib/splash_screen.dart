import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvel/center_screen.dart';
import 'package:marvel/components/app_colors.dart';
import 'package:marvel/repository/marvel_repository.dart';

import 'cubit/marvel_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  nextScreen() {
    Future.delayed(
      Duration(seconds: 1),
      (() {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => MarvelCubit(
                MarvelRepositoryImplementation(context),
              ),
              child: const CenterScreen(),
            ),
          ),
        );
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.vermelho,
      body: Center(
        child: SvgPicture.asset('images/svg/marvel.svg'),
      ),
    );
  }
}
