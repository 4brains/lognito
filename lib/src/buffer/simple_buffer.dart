import 'package:lognito/src/buffer/buffer.dart';
import 'package:lognito/src/event/log_event.dart';
import 'package:lognito/src/output/output.dart';

class SimpleBuffer extends Buffer {
  List<LogEvent> events = [];

  SimpleBuffer(List<Output> outputs) : super(outputs);

  @override
  void addToBuffer(LogEvent event) {
    events.add(event);
    flush();
  }

  @override
  void dispose() {}

  @override
  void flush(){
    final List<LogEvent> currentEvents = events;
    events = [];
    outputs.forEach((output) {
      currentEvents.forEach((event) async {
        await output.log(event);
      });
    });
  }

  @override
  void init() {}
}
