import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


class LogProvider extends ChangeNotifier{
  bool _log=false;

  bool get log=>_log;

  void LogIn() async{
    _log=true;
    notifyListeners();
  }

  void  LogOut()  async{
    _log=false;
    notifyListeners();
  }

  static LogProvider of(BuildContext context, {bool listen=true}){
    return Provider.of<LogProvider>(
      context,
      listen:listen,
    );
  }
}