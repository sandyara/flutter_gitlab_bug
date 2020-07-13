
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttergitlabbug/model/api_error_response.dart';
import 'package:fluttergitlabbug/model/api_exceptions.dart';
import 'package:fluttergitlabbug/service/secure_storage.dart';
import 'package:http/http.dart';

class ApiBase {

  var client = new Client();
  SecureStorage _secureStorage = SecureStorage();

  // SERIALIZE & ASYNC FUNCTION
  String serialize(Object obj) {
    String serialized = '';
    if (obj == null) {
      serialized = '';
    } else {
      serialized = json.encode(obj);
    }
    return serialized;
  }

   Future<Response> sendAsync(String method, String path, Object body, {bool authentication = false}) async {

    String baseUrl = await _secureStorage.getBaseUrl();
    var url = Uri.parse(baseUrl + path);

    print(url);
    var requestMessage = Request(method,url);
    Map<String, String> headerParams = {};
    try  {
      if (body != null) {
        if (body is String) {
          headerParams["Content-Type"] = "application/x-www-form-urlencoded";
          requestMessage.body = body;
        }
        else if (body is MultipartRequest) {
          headerParams['Accept'] = "application/json";
        }
        else {
          headerParams['Accept'] = "application/json";
          headerParams["Content-Type"] = "application/json";
          requestMessage.body = serialize(body);
        }
      }

      if (authentication) {
        headerParams['Authorization'] = 'Bearer ' + await _secureStorage.getAccessToken();
      }

      print("HEADER ${headerParams}");
      requestMessage.headers.addAll(headerParams);
      Response response;
      try {

        if(body is MultipartRequest){
          body.headers.addAll(headerParams);
          response =  await Response.fromStream(await client.send(body));
        }
        else{
          response=  await Response.fromStream(await client.send(requestMessage));
        }

        print("RESPONSE" + response.body);
        print("RESPONSE" + response.statusCode.toString());
      }
      catch (e) {
        var error = ApiException(_handleConnectionError());
        if ((error!=null && error.error!=null)) {
          if(error.error.getSingleMessage()!=null){
//            locator<DialogService>().showDialog(description: error.error.getSingleMessage());
          }
        }
      }

      if(response!=null){
        if (response.statusCode == 200 || response.statusCode == 201) {
          return response;
        }
        else if (response.statusCode >= 400) {
          var error = await _handleApiError(response, false);
          if (error!=null) {
            if(error.getSingleMessage()!=null){
//              locator<DialogService>().showDialog(description: error.getSingleMessage());
            }
          }
        }
      }
      return null;
    }
    finally{

    }

  }

  ErrorResponse _handleConnectionError() {
    var result = new ErrorResponse();
    result.statusCode = 502;
    result.message = "There is a problem connecting to the server.";
    return result;
  }

  Future<ErrorResponse> _handleApiError(Response response, bool tokenError) async {
    //TokenError and BadRequest || Forbidden || UnAuthorized
    if ((tokenError && response.statusCode == 400) || response.statusCode == 403 || response.statusCode == 401){
      //handle logout here

      //TODO: Event Bus Service
//      locator<EventBusService>().eventBus.fire(new LoggedOutEvent(_user,"Please login again as we had issue with the request."));
      return null;
    }

    Map<String, Object> responseJObject;
    if (_isJsonResponse(response)) {
      responseJObject = json.decode(response.body);
    }
    return ErrorResponse.fromResponse(responseJObject, response.statusCode, tokenError);
  }

  bool _isJsonResponse(Response response) {
    return (response.headers["content-type"]?.contains("json"));
  }

}