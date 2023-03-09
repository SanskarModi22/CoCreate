// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/host_service.dart';
import '../models/document_model.dart';
import '../models/error_model.dart';

final documentRepositoryProvider = Provider((ref) => DocumentRepo(dio: Dio()));

class DocumentRepo {
  final Dio _dio;

  DocumentRepo({required Dio dio}) : _dio = dio;

  Future<ErrorModel> createDocument(String token) async {
    ErrorModel error = ErrorModel(error: 'Something went wrong', data: null);
    try {
      var res = await _dio.post('$host/doc/create',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'x-auth-token': token
          }),
          data: {'createdAt': DateTime.now().millisecondsSinceEpoch});

      switch (res.statusCode) {
        case 200:
          error = ErrorModel(
              error: null, data: DocumentModel.fromJson(jsonEncode(res.data)));
          break;
        default:
          print('error in docurt');
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> getDocument(String token) async {
    ErrorModel error = ErrorModel(error: 'Something went wrong', data: null);
    try {
      var res = await _dio.get(
        '$host/doc/me',
        options: Options(
          headers: {'Content-Type': 'application/json', 'x-auth-token': token},
        ),
      );
// print(res.statusCode);

      switch (res.statusCode) {
        case 200:
          List<DocumentModel> document = [];
          // print(res.data);
          for (int i = 0; i < res.data.length; i++) {
            document.add(DocumentModel.fromJson(jsonEncode(res.data[i])));
          }
          // print(document);
          error = ErrorModel(error: null, data: document);
          break;
        default:
          print('error in document2');
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> updateTitle({
    required String token,
    required String id,
    required String title,
  }) async {
    ErrorModel error = ErrorModel(error: 'Something went wrong', data: null);
    try {
      var res = await _dio.post('$host/doc/title',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'x-auth-token': token
            },
          ),
          data: jsonEncode({'id': id, 'title': title}));
      // print(res.data);
      switch (res.statusCode) {
        case 200:
          error = ErrorModel(
              error: null, data: DocumentModel.fromJson(jsonEncode(res.data)));
          break;
        default:
          print('Error In Document');
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> getDocumentById(String token, String id) async {
    ErrorModel error = ErrorModel(error: 'Something went wrong', data: null);
    try {
      var res = await _dio.get(
        '$host/doc/$id',
        options: Options(
          headers: {'Content-Type': 'application/json', 'x-auth-token': token},
        ),
      );
      switch (res.statusCode) {
        case 200:
          // print(res.data);
          error = ErrorModel(
              error: null, data: DocumentModel.fromJson(jsonEncode(res.data)));
          break;
        default:
          throw 'This document does not exist,please create a new one';
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }
}
