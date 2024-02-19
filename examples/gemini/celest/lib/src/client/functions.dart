// Generated by Celest. This file should not be modified manually, but
// it can be checked into version control.
// ignore_for_file: type=lint, unused_local_variable, unnecessary_cast, unnecessary_import

library;

import 'dart:convert';

import 'package:celest/celest.dart';
import 'package:celest_backend/models.dart';
import 'package:celest_core/src/exception/cloud_exception.dart';

import '../../client.dart';

class CelestFunctions {
  final gemini = CelestFunctionsGemini();
}

class CelestFunctionsGemini {
  /// Returns a list of available models.
  Future<List<String>> availableModels() async {
    final $response = await celest.httpClient.post(
      celest.baseUri.resolve('/gemini/available-models'),
      headers: const {'Content-Type': 'application/json; charset=utf-8'},
    );
    final $body = (jsonDecode($response.body) as Map<String, Object?>);
    if ($response.statusCode == 200) {
      return ($body['response'] as Iterable<Object?>)
          .map((el) => (el as String))
          .toList();
    }
    final $error = ($body['error'] as Map<String, Object?>);
    final $code = ($error['code'] as String);
    final $details = ($error['details'] as Map<String, Object?>?);
    switch ($code) {
      case r'BadRequestException':
        throw Serializers.instance.deserialize<BadRequestException>($details);
      case r'InternalServerException':
        throw Serializers.instance
            .deserialize<InternalServerException>($details);
      case _:
        switch ($response.statusCode) {
          case 400:
            throw BadRequestException($code);
          case _:
            throw InternalServerException($code);
        }
    }
  }

  /// Prompts the Gemini [modelName] with the given [prompt] and [parameters].
  ///
  /// Returns the generated text.
  Future<String> generateContent({
    required String modelName,
    required String prompt,
    ModelParameters parameters = const ModelParameters(),
  }) async {
    final $response = await celest.httpClient.post(
      celest.baseUri.resolve('/gemini/generate-content'),
      headers: const {'Content-Type': 'application/json; charset=utf-8'},
      body: jsonEncode({
        r'modelName': modelName,
        r'prompt': prompt,
        r'parameters':
            Serializers.instance.serialize<ModelParameters>(parameters),
      }),
    );
    final $body = (jsonDecode($response.body) as Map<String, Object?>);
    if ($response.statusCode == 200) {
      return ($body['response'] as String);
    }
    final $error = ($body['error'] as Map<String, Object?>);
    final $code = ($error['code'] as String);
    final $details = ($error['details'] as Map<String, Object?>?);
    switch ($code) {
      case r'BadRequestException':
        throw Serializers.instance.deserialize<BadRequestException>($details);
      case r'InternalServerException':
        throw Serializers.instance
            .deserialize<InternalServerException>($details);
      case _:
        switch ($response.statusCode) {
          case 400:
            throw BadRequestException($code);
          case _:
            throw InternalServerException($code);
        }
    }
  }
}