class Message {

  final String message;
  final String id;

  Message(this.message, this.id);
  //بسبب ان البيانات ال راجعه جاسون داتا
  factory Message.fromJson(jsonData){
    //الحاجه ال راجعه
    return Message(jsonData['message'],jsonData['id']);
    }
}