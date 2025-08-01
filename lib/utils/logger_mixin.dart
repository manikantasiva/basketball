// ignore_for_file: avoid_print

mixin LoggerMixin {
  void logger(String msg){
    var timnestamp = DateTime.now();
    print("here it is loggier $timnestamp ,,, msg: $msg");

  }
}



