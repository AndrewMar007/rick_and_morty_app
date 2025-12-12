import 'package:fpdart/fpdart.dart';
import 'package:rick_and_morty_app/core/exceptions/exceptions.dart';
import 'package:rick_and_morty_app/core/network/network_info.dart';
import 'package:rick_and_morty_app/model/character_model.dart';
import 'package:rick_and_morty_app/services/character_service/character_service.dart';

import '../../core/exceptions/failures.dart';


abstract class CharacterViewModel {
  Future<Either<Failure, List<CharacterModel>>> fetchListOfCharacters(
      int page);
  Future<Either<Failure, List<CharacterModel>>> fetchCharacterByName(String name);
  Future<Either<Failure, List<CharacterModel>>> findCharacterById(List<int> id);
}

class CharacterViewModelImpl
    implements CharacterViewModel {
  final CharacterService service;
  final NetworkInfo networkInfo;
  CharacterViewModelImpl(
      {required this.service, required this.networkInfo});

  @override
  Future<Either<Failure, List<CharacterModel>>> fetchCharacterByName(
      String name) async {
    if (await networkInfo.isConnected()) {
      try {
        final data = await service.fetchCharacterByName(name);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, List<CharacterModel>>> fetchListOfCharacters(
      int page) async {
    if(await networkInfo.isConnected()){
      try{
        final data = await service.fetchListOfCharacters(page);
        return Right(data);
      } on ServerException{
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }
  
  @override
  Future<Either<Failure, List<CharacterModel>>> findCharacterById(List<int> id) async{
    if(await networkInfo.isConnected())
    {
      try{
        final data = await service.findCharacterById(id);
        return Right(data);
      } on ServerException{
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
