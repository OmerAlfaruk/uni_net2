



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:uni_link/features/domain/use_cases/storage/upload_image_to_storage_use_case.dart';
import 'features/data/data_sources/firebase_remote_data_src.dart';
import 'features/data/repositories/firebase_remote_data_src_impl.dart';
import 'features/data/repositories/firebase_repository_impl.dart';
import 'features/domain/repositories/firebase_repository.dart';
import 'features/domain/use_cases/firebase_usecases/post/create_post_usecase.dart';
import 'features/domain/use_cases/firebase_usecases/post/delete_post_usecase.dart';
import 'features/domain/use_cases/firebase_usecases/post/like_post_usecase.dart';
import 'features/domain/use_cases/firebase_usecases/post/read_posts_usecase.dart';
import 'features/domain/use_cases/firebase_usecases/post/read_single_post_usecase.dart';
import 'features/domain/use_cases/firebase_usecases/post/update_post_usecase.dart';
import 'features/domain/use_cases/firebase_usecases/user/create_user_usecase.dart';
import 'features/domain/use_cases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'features/domain/use_cases/firebase_usecases/user/get_single_user_usecase.dart';
import 'features/domain/use_cases/firebase_usecases/user/get_users_usecase.dart';
import 'features/domain/use_cases/firebase_usecases/user/is_sign_in_usecase.dart';
import 'features/domain/use_cases/firebase_usecases/user/sign_in_user_usecase.dart';
import 'features/domain/use_cases/firebase_usecases/user/sign_out_usecase.dart';
import 'features/domain/use_cases/firebase_usecases/user/sign_up_user_usecase.dart';
import 'features/domain/use_cases/firebase_usecases/user/update_user_usecase.dart';
import 'features/presentation/cubit/auth/auth_cubit.dart';
import 'features/presentation/cubit/credential/credential_cubit.dart';
import 'features/presentation/cubit/post/post_cubit.dart';
import 'features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'features/presentation/cubit/user/user_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits Auth Injection
  sl.registerFactory(
        () => AuthCubit(
      signOutUseCase: sl.call(),
      isSignInUseCase: sl.call(),
      getCurrentUidUseCase: sl.call(),
    ),
  );
// Credential Injection
  sl.registerFactory(
        () => CredentialCubit(
      signUpUseCase: sl.call(),
      signInUserUseCase: sl.call(),
    ),
  );
  // Get Single User Cubit Injection
  sl.registerFactory(
        () => GetSingleUserCubit(
        getSingleUserUseCase: sl.call()
    ),
  );
// User Cubit Injection
  sl.registerFactory(
        () => UserCubit(
        updateUserUseCase: sl.call(),
        getUsersUseCase: sl.call(),
    ),
  );
  // Post Cubit Injection
  sl.registerFactory(
        () => PostCubit(
        createPostUseCase: sl.call(),
        deletePostUseCase: sl.call(),
        likePostUseCase: sl.call(),
        readPostUseCase: sl.call(),
        updatePostUseCase: sl.call()
    ),
  );

  // Use Cases
  // User
  sl.registerLazySingleton(() => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignInUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => CreateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(repository: sl.call()));

  //storage
  sl.registerLazySingleton(() => UploadImageToStorageUseCase(repository: sl.call()));

  // Repository

  sl.registerLazySingleton<FirebaseRepository>(() => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  // Remote Data Source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() => FirebaseRemoteDataSourceImpl(firebaseFirestore: sl.call(), firebaseAuth: sl.call(), firebaseStorage: sl.call(),));
  // Post Use cases
  sl.registerLazySingleton(() => CreatePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadPostsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LikePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DeletePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadSinglePostUseCase(repository: sl.call()));
  // Externals

  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;


  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseStorage);



}