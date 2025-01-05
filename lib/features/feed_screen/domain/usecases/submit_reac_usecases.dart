import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/model/submit_react_req.dart';
import '../repositories/feed_repository.dart';

class SubmitReacUsecases {
  final FeedRepository repository;

  SubmitReacUsecases({required this.repository});

  Future<Either<Failure, String>> call(SubmitReactReq req) async {
    return await repository.submitReact(req);
  }
}
