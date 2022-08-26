import 'package:flutter/material.dart';
import 'package:marvel/model/marvel_model.dart';

@immutable
abstract class MarvelState {}

class MarvelInitial extends MarvelState {}

class MarvelLoading extends MarvelState {}

class MarvelLoaded extends MarvelState {
  late final MarvelModel? marvelModel;
  MarvelLoaded({this.marvelModel});
}

class MarvelError extends MarvelState {
  final String error;
  MarvelError(this.error);
}
