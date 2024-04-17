import 'package:get_storage/get_storage.dart';

class OLocalStorage{
  static final OLocalStorage _instance=OLocalStorage._internal();


  factory OLocalStorage(){
    return _instance;
  }
  OLocalStorage._internal();
  final _storage=GetStorage();

  // method to save data
  Future<void> saveData<T>(String key,T value)async{
    await _storage.write(key,value);
  }
   //Generic method to read Data
  T? readData<T>(String key){
    _storage.read<T>(key);
    return null;
  }
  Future<void> removeData(String key)async{
    await _storage.remove(key);
  }
  Future<void> clearAll()async{
    await _storage.erase();
  }

}