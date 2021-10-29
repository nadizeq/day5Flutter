import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:convert';


void main(List<String> arguments) {
  final channel = IOWebSocketChannel.connect('wss://ws.binaryws.com/websockets/v3?app_id=30354');

  

  channel.stream.listen((message) {

    //symbol
    final decodedMessage = jsonDecode(message);

    //this is an array
    final activeSymbol = decodedMessage['active_symbols'];

    print(activeSymbol[0]['symbol']);
    //displayTickStream(activeSymbol[0]['symbol'],channel);

    /*var activeSymbolID;

    // ignore: omit_local_variable_types
    for (int i = 0;i<10;i++){
      
      activeSymbolID = activeSymbol[i]['symbol'];
      //print(activeSymbolID);
      displayTickStream(activeSymbolID, channel);
    }*/
    channel.sink.close();
    
   });

  //  displayTime(channel);

   channel.sink.add('{"active_symbols":"brief","product_type":"basic"}');
  channel.sink.add('{"forget_all": "ticks"}');

}

void displayTime(var channel){
//   final channel = IOWebSocketChannel.connect(
// 'wss://ws.binaryws.com/websockets/v3?app_id=1089');

channel.stream.listen((message) {
  final decodedMessage = jsonDecode(message);
  final serverTimeAsEpoch = decodedMessage['time'];
  final serverTime =
  DateTime.fromMillisecondsSinceEpoch(serverTimeAsEpoch * 1000);
  print('\n');
  print(serverTime);
  channel.sink.close();
});

channel.sink.add('{"time":1}');
}

void displayTickStream(activeSymbolID, channel){
//   final channel = IOWebSocketChannel.connect(
// 'wss://ws.binaryws.com/websockets/v3?app_id=1089');

channel.stream.listen((message) { 
  final decodedMessage = jsonDecode(message);
  //final ticksData = decodedMessage[''];
  final getQuote = decodedMessage['quote'];
  final getEpoch = decodedMessage['epoch'];
  final getSymbol = decodedMessage['symbol'];
  print(decodedMessage);
  //print(echo_req);
});

channel.sink.add('{"ticks":"$activeSymbolID","subscribe":0}');

}
