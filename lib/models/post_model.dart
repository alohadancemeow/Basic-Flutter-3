import 'package:timeago/timeago.dart' as timeago;

class Post {
  String message;
  DateTime dateTimeCreated;

  Post({this.message, this.dateTimeCreated});

  //ถ้าต้องการคำนวณหรือทำอะไรบางอย่างก่อนส่งข้อมูลออกไป
  //ให้ใช้ get method
  String get timeAgo {
    //เวลาปัจจุบัน
    var now = DateTime.now();
    //ระยะห่างระหว่างเวลาปัจจุบันกับเวลาที่สร้าง
    var duration = now.difference(this.dateTimeCreated);
    //ระยะห่าง - เวลาปัจจุบัน
    var ago = now.subtract(duration);

    var message = timeago.format(ago, locale: "th");
    // var message = timeago.format(ago, locale: "th_short");
    return message;
  }
}
