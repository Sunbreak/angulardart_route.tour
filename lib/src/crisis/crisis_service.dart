import 'crisis.dart';
import 'mock_crises.dart';

class CrisisService {
  Future<List<Crisis>> getAll() async => mockCrises;

  Future<List<Crisis>> getAllSlowly() {
    return Future.delayed(Duration(seconds: 2), getAll);
  }

  Future<Crisis> get(int id) async =>
      (await getAll()).firstWhere((crisis) => crisis.id == id);
}
