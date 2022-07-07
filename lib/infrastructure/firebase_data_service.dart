import 'package:firebase_database/firebase_database.dart';
import 'package:greezy/domain/services/services.dart';

class FirebaseDataServiceImpl implements FirebaseDataService {
  final _database = FirebaseDatabase.instance;

  @override
  Future<int> getServerTimeOffset() async {
    int offset = 0;
    final source = await FirebaseDatabase.instance.ref().child(".info/serverTimeOffset").once();
    offset = source.snapshot.value as int;
    int estimatedServerTimeInMs = DateTime.now().millisecondsSinceEpoch + offset;
    return estimatedServerTimeInMs;
  }
}