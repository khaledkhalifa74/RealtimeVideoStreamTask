import 'package:socket_io_client/socket_io_client.dart' as io;

class VideoRemoteDataSource {
  io.Socket? socket;

  void connectSocket({
    required Function(bool) onConnectionChange,
  }) {
    socket = io.io(
      "https://videosocketserver-production.up.railway.app",
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    /// Listen for connection events
    socket!.onConnect((_) {
      onConnectionChange(true);
    });

    socket!.onDisconnect((_) {
      onConnectionChange(false);
    });

    socket!.onConnectError((_) {
      onConnectionChange(false);
    });

    socket!.onError((_) {
      onConnectionChange(false);
    });

    socket!.connect();
  }

  void sendEvent(String event, dynamic data) {
    socket?.emit(event, data);
  }

  void onEvent(String event, Function(dynamic) handler) {
    socket?.on(event, handler);
  }

  void disconnect() {
    socket?.disconnect();
  }
}
