part of 'localization_bloc.dart';

@immutable
abstract class LocalizationEvent {}

class CheckPermission extends LocalizationEvent{}

class RequestPermission extends LocalizationEvent{}

class GetLocation extends LocalizationEvent{}