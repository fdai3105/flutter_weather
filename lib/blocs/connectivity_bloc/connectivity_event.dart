part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();
}

class CheckConnectivityEvent extends ConnectivityEvent {
  @override
  List<Object> get props => [];
}
