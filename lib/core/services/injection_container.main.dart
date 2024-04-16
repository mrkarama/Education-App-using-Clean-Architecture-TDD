part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _onBoardingInit();
  await _authenticationInit();
}

Future<void> _onBoardingInit() async {
  final prefs = await SharedPreferences.getInstance();
  sl

    // App Logic
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: sl(),
        checkIfUserIsFirstTimer: sl(),
      ),
    )

    // Usecases
    ..registerLazySingleton(
      () => CacheFirstTimer(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => CheckIfUserIsFirstTimer(
        sl(),
      ),
    )

    // Repositories
    ..registerLazySingleton<OnBoardingRepository>(
      () => OnBoardingRepositoryImplementation(
        sl(),
      ),
    )

    // Datasources
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSourceImplementation(
        sl(),
      ),
    )

    // External dependencies
    ..registerLazySingleton(
      () => prefs,
    );
}

Future<void> _authenticationInit() async {
  sl

    // App Logic
    ..registerFactory(
      () => AuthenticationBloc(
        signIn: sl(),
        signUp: sl(),
        forgotPassword: sl(),
        updateUser: sl(),
      ),
    )

    // Usecases
    ..registerLazySingleton(
      () => SignIn(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => SignUp(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => ForgotPassword(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => UpdateUser(
        sl(),
      ),
    )

    // Repositories
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImplementation(
        sl(),
      ),
    )

    // Datasources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImplementation(
        authClient: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    )

    // External dependencies
    ..registerLazySingleton(
      () => FirebaseAuth.instance,
    )
    ..registerLazySingleton(
      () => FirebaseFirestore.instance,
    )
    ..registerLazySingleton(
      () => FirebaseStorage.instance,
    );
}
