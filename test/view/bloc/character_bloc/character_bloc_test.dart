import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/core/exceptions/failures.dart';
import 'package:rick_and_morty_app/model/character_model.dart';
import 'package:rick_and_morty_app/view/bloc/character_bloc/character_bloc.dart';
import 'package:rick_and_morty_app/view/bloc/character_bloc/character_bloc_event.dart';
import 'package:rick_and_morty_app/view/bloc/character_bloc/character_bloc_state.dart';
import 'package:rick_and_morty_app/view_model/character_view_model/character_view_model.dart';

import '../../../values/values_test.dart';

class MockCharacterViewModel extends Mock implements CharacterViewModel {}

void main() {
  late CharacterBlocList characterBlocList;
  late CharacterBlocFindByName characterBlocFindByName;
  late CharacterBlocFindById characterBlocFindById;
  late MockCharacterViewModel mockCharacterViewModel;

  setUp(() {
    mockCharacterViewModel = MockCharacterViewModel();
    characterBlocList =
        CharacterBlocList(characterViewModel: mockCharacterViewModel);
    characterBlocFindByName =
        CharacterBlocFindByName(characterViewModel: mockCharacterViewModel);
    characterBlocFindById =
        CharacterBlocFindById(characterViewModel: mockCharacterViewModel);
  });

  group("GetCharacterListEvent", () {
    const list = CharacterModelValues.listOfCharacters;
    test("initial State should be InitState", () {
      expect(characterBlocList.state, isA<InitState>());
    });
    test("should get data for FetchCharacterListEvent", () async {
      when(() => mockCharacterViewModel.fetchListOfCharacters(any()))
          .thenAnswer((_) async => const Right(list));
      characterBlocList.add(GetCharacterListEvent());
      await untilCalled(
          () => mockCharacterViewModel.fetchListOfCharacters(any()));
      verify(() => mockCharacterViewModel.fetchListOfCharacters(1));
    });

    final listShort = <CharacterModel>[
      const CharacterModel(
        id: 1,
        name: "Rick",
        status: "Alive",
        species: "  Human",
        type: "",
        gender: "Male",
        image: "",
        location: {"name": "Earth", "url": ""},
        episode: [],
        url: "",
        created: "",
      ),
    ];
    final page10 = List.generate(
      10,
      (i) => CharacterModel(
        id: i + 1,
        name: "Char $i",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        image: "",
        location: const {"name": "Earth", "url": ""},
        episode: const [],
        url: "",
        created: "",
      ),
    );

    blocTest<CharacterBlocList, CharacterBlocState>(
      'paginates: page1(15) then page2(short) => combined list, hasMore false',
      build: () {
        when(() => mockCharacterViewModel.fetchListOfCharacters(1))
            .thenAnswer((_) async => Right(page10)); // hasMore true
        when(() => mockCharacterViewModel.fetchListOfCharacters(2))
            .thenAnswer((_) async => Right(listShort)); // hasMore false
        return CharacterBlocList(characterViewModel: mockCharacterViewModel);
      },
      act: (bloc) async {
        bloc.add(GetCharacterListEvent()); //page 1
        await bloc.stream
            .firstWhere((s) => s is FetchListOfCharactersLoadedState);
        bloc.add(GetCharacterListEvent()); // page 2
      },
      expect: () => [
        isA<LoadingState>(),
        isA<FetchListOfCharactersLoadedState>()
            .having((s) => s.characterModelList.length, 'len', 10)
            .having((s) => s.hasMore, 'hasMore', true),
        isA<FetchListOfCharactersLoadedState>()
            .having((s) => s.characterModelList.length, 'len', 11)
            .having((s) => s.hasMore, 'hasMore', false)
      ],
      verify: (_) {
        verify(() => mockCharacterViewModel.fetchListOfCharacters(1)).called(1);
        verify(() => mockCharacterViewModel.fetchListOfCharacters(2)).called(1);
      },
    );
    blocTest<CharacterBlocList, CharacterBlocState>(
      'emits [LoadingState, FetchListOfCharactersLoadedState] when first page success (<10 => hasMore false)',
      build: () {
        when(() => mockCharacterViewModel.fetchListOfCharacters(any()))
            .thenAnswer((_) async => Right(listShort));
        return CharacterBlocList(characterViewModel: mockCharacterViewModel);
      },
      act: (bloc) => bloc.add(GetCharacterListEvent()),
      expect: () => [
        isA<LoadingState>(),
        isA<FetchListOfCharactersLoadedState>()
            .having((s) => s.characterModelList, 'list', equals(listShort))
            .having((s) => s.hasMore, 'hasMore', false),
      ],
      verify: (_) {
        verify(() => mockCharacterViewModel.fetchListOfCharacters(1)).called(1);
      },
    );

    blocTest(
      "should emit, [Loading, Error] when getting data fails",
      build: () =>
          CharacterBlocList(characterViewModel: mockCharacterViewModel),
      act: (bloc) {
        when(() => mockCharacterViewModel.fetchListOfCharacters(any()))
            .thenAnswer((_) async => const Left(ServerFailure()));
        bloc.add(GetCharacterListEvent());
      },
      expect: () => [
        isA<LoadingState>(),
        isA<ErrorState>()
            .having((s) => s.failure, 'failure', isA<ServerFailure>()),
      ],
    );

    blocTest(
      "should emit, [Loading, Error] when no internet connection",
      build: () =>
          CharacterBlocList(characterViewModel: mockCharacterViewModel),
      act: (bloc) {
        when(() => mockCharacterViewModel.fetchListOfCharacters(any()))
            .thenAnswer((_) async => const Left(InternetFailure()));
        bloc.add(GetCharacterListEvent());
      },
      expect: () => [
        isA<LoadingState>(),
        isA<ErrorState>()
            .having((s) => s.failure, 'failure', isA<InternetFailure>()),
      ],
    );
  });

  group("GetCharacterByNameEvent", () {
    const name = "rick";
    final list10 = List.generate(
      10,
      (i) => CharacterModel(
        id: i + 1,
        name: "Char $i",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        image: "",
        location: const {"name": "Earth", "url": ""},
        episode: const [],
        url: "",
        created: "",
      ),
    );
    test("initial State should be InitState", () {
      expect(characterBlocFindByName.state, isA<InitState>());
    });
    test("should get data for GetCharacterByNameEvent", () async {
      when(() => mockCharacterViewModel.fetchCharacterByName(any()))
          .thenAnswer((_) async => Right(list10));
      characterBlocFindByName.add(GetCharacterByNameEvent(name: name));
      await untilCalled(
          () => mockCharacterViewModel.fetchCharacterByName(any()));
      verify(() => mockCharacterViewModel.fetchCharacterByName(name));
    });
    blocTest<CharacterBlocFindByName, CharacterBlocState>(
        "should emit [LoadingState, GetCharacterByNameLoadedState] when fetching data is success",
        build: () =>
            CharacterBlocFindByName(characterViewModel: mockCharacterViewModel),
        act: (bloc) {
          when(() => mockCharacterViewModel.fetchCharacterByName(any()))
              .thenAnswer((_) async => Right(list10));
          bloc.add(GetCharacterByNameEvent(name: name));
        },
        expect: () => [
              isA<LoadingState>(),
              isA<FetchCharacterByNameLoadedState>()
                  .having((s) => s.charactersList, 'list', equals(list10))
            ]);
    blocTest<CharacterBlocFindByName, CharacterBlocState>(
        "should emit [LoadingState, ErrorState when getting data fails]",
        build: () =>
            CharacterBlocFindByName(characterViewModel: mockCharacterViewModel),
        act: (bloc) async {
          when(() => mockCharacterViewModel.fetchCharacterByName(name))
              .thenAnswer((_) async => Left(ServerFailure()));
          bloc.add(GetCharacterByNameEvent(name: name));
        },
        expect: () => [
              isA<LoadingState>(),
              isA<ErrorState>()
                  .having((s) => s.failure, 'failure', isA<ServerFailure>())
            ]);
    blocTest<CharacterBlocFindByName, CharacterBlocState>(
        "should emit [LoadingState, ErrorState when no internet connection ]",
        build: () =>
            CharacterBlocFindByName(characterViewModel: mockCharacterViewModel),
        act: (bloc) async {
          when(() => mockCharacterViewModel.fetchCharacterByName(name))
              .thenAnswer((_) async => const Left(InternetFailure()));
          bloc.add(GetCharacterByNameEvent(name: name));
        },
        expect: () => [
              isA<LoadingState>(),
              isA<ErrorState>()
                  .having((s) => s.failure, 'failure', isA<InternetFailure>())
            ]);
  });

  group("FindCharacterByIdEvent", () {
    final list10 = List.generate(
      10,
      (i) => CharacterModel(
        id: i + 1,
        name: "Char $i",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        image: "",
        location: const {"name": "Earth", "url": ""},
        episode: const [],
        url: "",
        created: "",
      ),
    );
    List<int> listOfIds = [1, 2, 3];
    test("initial state should be IniState ", () {
      expect(characterBlocFindById.state, isA<InitState>());
    });
    test("should get data for FindCharacterByIdEvent", () async {
      when(() => mockCharacterViewModel.findCharacterById(any()))
          .thenAnswer((_) async => Right(list10));
      characterBlocFindById.add(FindCharacterByIdEvent(id: listOfIds));
      await untilCalled(() => mockCharacterViewModel.findCharacterById(any()));
      verify(() => mockCharacterViewModel.findCharacterById(listOfIds));
    });

    blocTest<CharacterBlocFindById, CharacterBlocState>(
      "should emit [LoadingState, FindCharacterByIdLoadedState] when getting data success",
      build: () =>
          CharacterBlocFindById(characterViewModel: mockCharacterViewModel),
      act: (bloc) {
        when(() => mockCharacterViewModel.findCharacterById(any()))
            .thenAnswer((_) async => Right(list10));
        bloc.add(FindCharacterByIdEvent(id: listOfIds));
      },
      expect: () => [
        isA<LoadingState>(),
        isA<FindCharacterByIdLoadedState>()
            .having((s) => s.list, 'list', equals(list10))
      ],
    );

    blocTest<CharacterBlocFindById, CharacterBlocState>(
        "should emit [LoadingState, ErrorState] when getting data failed",
        build: () =>
            CharacterBlocFindById(characterViewModel: mockCharacterViewModel),
        act: (bloc) {
          when(() => mockCharacterViewModel.findCharacterById(any()))
              .thenAnswer((_) async => const Left(ServerFailure()));
          bloc.add(FindCharacterByIdEvent(id: listOfIds));
        },
        expect: () => [
              isA<LoadingState>(),
              isA<ErrorState>()
                  .having((s) => s.failure, "failure", isA<ServerFailure>())
            ]);

    blocTest<CharacterBlocFindById, CharacterBlocState>(
        "should emit [LoadingState, ErrorState] when no internet connection",
        build: () =>
            CharacterBlocFindById(characterViewModel: mockCharacterViewModel),
        act: (bloc) {
          when(() => mockCharacterViewModel.findCharacterById(any()))
              .thenAnswer((_) async => const Left(InternetFailure()));
          bloc.add(FindCharacterByIdEvent(id: listOfIds));
        },
        expect: () => [
              isA<LoadingState>(),
              isA<ErrorState>()
                  .having((s) => s.failure, "failure", isA<InternetFailure>())
            ]);
  });
}
