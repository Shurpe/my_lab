import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:json_annotation/json_annotation.dart';
// lib/data/repositories/content_repository_interface.dart
import 'package:flutter_application_1/lib/domain/repositories/content/model/content.dart';

import 'model/content.dart';

abstract interface class ContentRepositoryInterface {
  Future<List<Content>> getContent();
}

