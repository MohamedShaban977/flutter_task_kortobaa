import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectionCubit extends Cubit<ConnectionStates> {
  ConnectionCubit() : super(ConnectionInit());

  static ConnectionCubit get(context) => BlocProvider.of(context);

  final Connectivity _connectivity = Connectivity();

  void listenConnectionState() async {
    final state = await _connectivity.checkConnectivity();
    emit(state == ConnectivityResult.none
        ? ConnectionLost()
        : ConnectionSuccess());

    _connectivity.onConnectivityChanged.listen((event) => emit(
        event == ConnectivityResult.none
            ? ConnectionLost()
            : ConnectionSuccess()));
  }

//   void continueOfflineMode() async =>
//       emit(await _connectivity.checkConnectivity() == ConnectivityResult.none
//           ? ConnectionLost()
//           : ConnectionSuccess());
}

abstract class ConnectionStates {}

class ConnectionInit extends ConnectionStates {}

class ConnectionSuccess extends ConnectionStates {}

class ConnectionLost extends ConnectionStates {}
