part of 'connectivity_bloc.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();
}

class ConnectivityInitial extends ConnectivityState {
  @override
  List<Object> get props => [];
}

class ConnectivitySuccess extends ConnectivityState {
  @override
  List<Object> get props => [];
}

class ConnectivityFail extends ConnectivityState {
  @override
  List<Object> get props => [];
}
