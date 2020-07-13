class ErrorResponse {
  String message;
  Map<String, List<String>> validationErrors;
  int statusCode;

  ErrorResponse();

  ErrorResponse.fromResponse(Map<String, Object> response, int statusCode,
      [bool identityResponse = false]) {
    var errorModel;
    if (response != null) {
      if (response.containsKey("error_model") && identityResponse) {
        errorModel = _ErrorModel.fromJson(response["error_model"]);
      } else {
        errorModel = _ErrorModel.fromJson(response);
      }
    }
    if (errorModel != null) {
      message = errorModel.message;
      validationErrors = errorModel.errors;
    }
    statusCode = statusCode;
  }

  String getSingleMessage() {
    if (validationErrors == null) {
      return message;
    }
    for (var value in validationErrors.values) {
      if (value != null) {
        return value[0];
      }
    }
    return message;
  }

  @override
  String toString() {
    return message + getSingleMessage();
  }
}

class _ErrorModel {
  String message;
  Map<String, List<String>> errors;
  _ErrorModel.fromJson(Map<String, dynamic> json) {
    errors = new Map<String, List<String>>();
    message = json['message'];
    if (json['errors'] != null) {
      for (var key in json['errors'].keys) {
        errors[key] = List<String>.from(json['errors'][key]);
      }
    }
  }
}
