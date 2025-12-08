import 'package:fpdart/fpdart.dart';
import 'package:rick_and_morty_app/core/exceptions/exceptions.dart';
import 'package:rick_and_morty_app/core/exceptions/failures.dart';
import 'package:rick_and_morty_app/core/network/network_info.dart';
import 'package:rick_and_morty_app/model/episode_model.dart';
import 'package:rick_and_morty_app/services/episode_service/episode_service.dart';

String internetFailureMessage = "No internet connection";
String serverFailureMessage = "Server Failure";

abstract class EpisodeViewModel {
  Future<Either<Failure, List<EpisodeModel>>> fetchEpisodesList(List<int> episodes);
}

class EpisodeViewModelImpl extends EpisodeViewModel {
  final NetworkInfo networkInfo;
  final EpisodeService service;
  EpisodeViewModelImpl({required this.networkInfo, required this.service});
  @override
  Future<Either<Failure ,List<EpisodeModel>>> fetchEpisodesList(List<int> episodes) async {
    if(await networkInfo.isConnected()){
      try{
        final data = await service.fetchEpisodesList(episodes);
        return Right(data);
      } on ServerException{
        return Left(ServerFailure(failure: serverFailureMessage));
      }
    } else {
      return Left(InternetFailure(failure: internetFailureMessage));
    }
  }
}
