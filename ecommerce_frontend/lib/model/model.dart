import 'dart:async';
import 'dart:convert';
import 'package:ecommerce_frontend/model/object/Maglia.dart';
import 'package:ecommerce_frontend/model/object/OrdineMaglia.dart';
import 'package:ecommerce_frontend/model/support/RegistrationReq.dart';
import 'package:ecommerce_frontend/model/support/constants.dart';

import 'manager/RestManager.dart';
import 'object/Ordine.dart';
import 'object/User.dart';
import "support/authData.dart";

enum LogInResult {
  logged,
  wrong_credentials_error,
  user_not_fully_setupped_error,
  unknown_error,
}

class Model {
  static Model sharedInstance = Model();

  RestManager _restManager = RestManager();

  AuthData? _authData;

  Future<LogInResult> logIn(String email, String password) async {
    try{
      Map<String, String> params = Map();
      params["grant_type"] = "password";
      params["client_id"] = Constants.CLIENT_ID;
      params["username"] = email;
      params["password"] = password;
      params["client_secret"] = Constants.CLIENT_SECRET;
      String result = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      _authData = AuthData.fromJson(jsonDecode(result));
      if ( _authData!.hasError() ) {
        if ( _authData!.error == "Invalid user credentials" ) {
          return LogInResult.wrong_credentials_error;
        }
        else if ( _authData!.error == "Account is not fully set up" ) {
          return LogInResult.user_not_fully_setupped_error;
        }
        else {
          return LogInResult.unknown_error;
        }
      }
      _restManager.token = _authData!.accessToken;
      Timer.periodic(Duration(seconds: (_authData!.expiresIn - 50)), (Timer t) {
        _refreshToken();
      });
      return LogInResult.logged;
    }
    catch (e) {
      return LogInResult.unknown_error;
    }

  }

  Future<bool> _refreshToken() async {
    try {
      Map<String, String> params = Map();
      params["grant_type"] = "refresh_token";
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["refresh_token"] = _authData!.refreshToken;
      String result = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      _authData = AuthData.fromJson(jsonDecode(result));
      if ( _authData!.hasError() ) {
        return false;
      }
      _restManager.token = _authData!.accessToken;
      return true;
    }
    catch (e) {
      return false;
    }
  }

  Future<bool> logOut() async {
    try{
      Map<String, String> params = Map();
      _restManager.token = null;
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["refresh_token"] = _authData!.refreshToken;
      await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGOUT, params, type: TypeHeader.urlencoded);
      return true;
    }
    catch (e) {
      return false;
    }
  }

  Future<bool> purchase(List<OrdineMaglia> li) async {
    if (_restManager.token!=null) {
      print("object");
      User u = await getUser();
      print(u.carrello);
      if(u.carrello == -1){
        Ordine o = await createOrdine(u);
      }
      Map<String, String> params = Map();
      params["Authorization"]="Bearer ${_restManager.token!}";
      String result = await _restManager.makePostRequestAuthorization(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PAYMENT, params, li);
      if(result == "Pagamento effettuato") {
        return true;
      }
    }
    return false;
  }

  Future<List<Maglia>> getAllProduct() async {
    String? tokenC = await bearerClient();
    Map<String, String> params = Map();
    params["Authorization"]="Bearer ${tokenC}";
    params["min"] = "1";
    List<dynamic> result = jsonDecode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ALL_SHIRTS, params)) as List;
    List<Maglia> maglie = result.map((pObjs) => Maglia.fromJson(pObjs)).toList();
    return maglie;
  }

  Future<Ordine> createOrdine(User u) async{
    if(u.carrello != -1) {
      throw new Exception("Errore");
    }
    Map<String, String> params = Map();
    params["Authorization"]="Bearer ${_restManager.token!}";
    String result = await _restManager.makePostRequestAuthorization(Constants.ADDRESS_STORE_SERVER, Constants.ADD_ORDER, params, null, type: TypeHeader.json);
    Ordine ord = Ordine.fromJson(jsonDecode(result));
    return ord;
  }


  Future<String?>? bearerClient() async{
    Map<String, String> params = Map();
    params["client_id"] = Constants.CLIENT_ID;
    params["client_secret"] = Constants.CLIENT_SECRET;
    params["grant_type"] = "client_credentials";
    String result = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, "/realms/ecommerce-realm/protocol/openid-connect/token", params, type: TypeHeader.urlencoded);
    _authData = AuthData.fromJson(jsonDecode(result));
    return _authData!.accessToken;
  }


  Future<User?>? addUser(User user, String password) async {
    RegistrationReq s=new RegistrationReq(user: user,password: password);
    String? tokenC = await bearerClient();
    Map<String, String> params = Map();
    params["Authorization"] = "Bearer $tokenC";
    try {
      String rawResult = await _restManager.makePostRequestAuthorization(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER,params, s, type: TypeHeader.json);
      if ( rawResult.contains("L'email fornita è associata ad un altro account") ) {
        return null;
      }
      else {
        return User.fromJson(jsonDecode(rawResult));
      }
    }
    catch (e) {
      return null;
    }
  }

  Future<User> getUser() async {
    Map<String, String> params = Map();
    params["Authorization"] = "Bearer ${_restManager.token!}";
    String result = await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_GET_USER, params);
    User u = User.fromJson(jsonDecode(result));
    return u;
  }


}