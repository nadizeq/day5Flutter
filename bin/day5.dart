import 'dart:io'; 
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

void main(List<String> arguments) {

  
    final channel = IOWebSocketChannel.connect(
      'wss://ws.binaryws.com/websockets/v3?app_id=30354');

  channel.stream.listen((event) {
    final decodedMessage = jsonDecode(event);

    //this is an array
    final activeSymbol = decodedMessage['active_symbols'];

    var activeSymbolID;

    print('List of Symbol ID: \n');

    for (var i =0;i<10;i++){
      activeSymbolID = activeSymbol[i]['symbol'];
      print(activeSymbolID);
    }

    channel.sink.close();
    displayTickInfo();

        
  });

      channel.sink.add('{"active_symbols":"brief","product_type":"basic"}');
      
      
}

void displayTickInfo(){
  final channel = IOWebSocketChannel.connect(
      'wss://ws.binaryws.com/websockets/v3?app_id=1089');



  channel.stream.listen((tick) {
    final decodedMessage = jsonDecode(tick); //convert to readable json

    
    final tickName = decodedMessage['tick']['symbol'];
    final tickPrice = decodedMessage['tick']['quote'];
    final tickServerTimeAsEpoch = decodedMessage['tick']['epoch'];
    final serverTime =
        DateTime.fromMillisecondsSinceEpoch(tickServerTimeAsEpoch * 1000);
    print('\nName: $tickName Price: $tickPrice Time: $serverTime');
    channel.sink.close();
  });

  
  print('\nEnter symbol id to display tick Details: ');
  String?  symbolID = stdin.readLineSync(); 

  channel.sink.add('{ "ticks": "$symbolID", "subscribe": 1}'); 
}