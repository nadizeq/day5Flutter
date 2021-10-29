import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:convert';



void main(List<String> arguments) {

  //String activeSymbolID = "WLDAUD";

  final channel = IOWebSocketChannel.connect('wss://ws.binaryws.com/websockets/v3?app_id=1089');
  channel.stream.listen((event) {
    

    final decodedMessage = jsonDecode(event);
    final activeSymbol = decodedMessage['active_symbols'];

    print(activeSymbol[0]['symbol']);
    
    displayTickStream(activeSymbol[0]['symbol']);
    channel.sink.close();
    
  });

  channel.sink.add('{"active_symbols":"brief","product_type":"basic"}');


  
}

void displayTickStream(activeSymbolID){

  
  final channel = IOWebSocketChannel.connect('wss://ws.binaryws.com/websockets/v3?app_id=30354');

  channel.stream.listen((message) { 
  final decodedMessage = jsonDecode(message);
  //final ticksData = decodedMessage[''];
  // final getQuote = decodedMessage['quote'];
  // final getEpoch = decodedMessage['epoch'];
  // final getSymbol = decodedMessage['symbol'];

  print(decodedMessage);
  channel.sink.close();
});

channel.sink.add('{"ticks":"$activeSymbolID","subscribe":0}');


}