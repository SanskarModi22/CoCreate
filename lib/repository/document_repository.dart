import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/host_service.dart';
import '../models/error_model.dart';

final documentRepositoryProvider = Provider((ref) => DocumentRepo(dio: Dio()));

class DocumentRepo {
  final Dio _dio;
  DocumentRepo({
    required Dio dio,
  }) : _dio = dio;

  Future<ErrorModel> createDocument(String token) async {
    ErrorModel error = ErrorModel(error: 'Something went wrong', data: null);
    try {
      var res = await _dio.post('$host/doc/create',
          options: Options(headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'x-auth-token': token,
          }),
          data: {'createdAt': DateTime.now().millisecondsSinceEpoch});
      print(res.statusCode);
      print(res.data);
      switch (res.statusCode) {
        case 200:
          error = ErrorModel(error: null, data: res.data);
          break;
        default:
          print('error in document');
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }
}
