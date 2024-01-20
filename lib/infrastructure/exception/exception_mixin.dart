import 'dart:async';

import 'package:flutter/services.dart';
import 'package:umi_sea/infrastructure/exception/exception_enum.dart';
import 'package:umi_sea/infrastructure/exception/network_exception.dart';
import 'package:umi_sea/infrastructure/exception/server_error_exception.dart';

mixin ExceptionMethods {
  String getErrorMessage(Exception exception) =>
      switch (exception.runtimeType) {
        PlatformException => ExceptionEnum.platformError.errorMessage,
        TimeoutException => ExceptionEnum.timeoutError.errorMessage,
        NetworkException => ExceptionEnum.networkError.errorMessage,
        ServerErrorException => ExceptionEnum.serverError.errorMessage,
        _ => ExceptionEnum.exception.errorMessage,
      };
}
