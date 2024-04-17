import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:uni_link/features/anouncements/domain/repositories/announcement_repository.dart';
import 'package:uni_link/features/nework/data/data_sources/connection_data_source.dart';
import 'package:uni_link/features/news/domain/use_cases/upload_image_to_storage_usecase.dart';
import 'package:uni_link/features/post/domain/repositories/post_repository.dart';
import 'package:uni_link/features/user/data/data_sources/user_remote_data_src.dart';
import 'package:uni_link/features/user/data/data_sources/user_remote_data_src_impl.dart';
import 'package:uni_link/features/user/data/repositories/user_repository_impl.dart';
import 'package:uni_link/features/user/domain/repositories/user_repository.dart';
import 'features/anouncements/data/data_sources/announcement_remote_data_src.dart';
import 'features/anouncements/data/data_sources/announcement_remote_data_src_impl.dart';
import 'features/anouncements/data/repositories/announcements_repository_impl.dart';
import 'features/anouncements/domain/use_cases/create_announcements_usecase.dart';
import 'features/anouncements/domain/use_cases/delete_announcements_usecase.dart';
import 'features/anouncements/domain/use_cases/like_announcement_usecase.dart';
import 'features/anouncements/domain/use_cases/read_announcement_usecase.dart';
import 'features/anouncements/domain/use_cases/read_single_annoncements_usecase.dart';
import 'features/anouncements/domain/use_cases/update_announcements_usecase.dart';
import 'features/anouncements/presentaion/managers/news/announcements_cubit.dart';
import 'features/anouncements/presentaion/managers/news/get_single_announcement/get_single_announcement_cubit.dart';
import 'features/chat/data/data_sources/chat_remote_data_resource.dart';
import 'features/chat/data/data_sources/chat_remote_data_resource_implmentation.dart';
import 'features/chat/data/repositories/chat_repository_impl.dart';
import 'features/chat/domain/repositories/chat_repository.dart';
import 'features/chat/domain/use_cases/delete_message_usecase.dart';
import 'features/chat/domain/use_cases/delete_my_chat_usecase.dart';
import 'features/chat/domain/use_cases/get_message_usecase.dart';
import 'features/chat/domain/use_cases/get_my_chat_usecase.dart';
import 'features/chat/domain/use_cases/seen_message_update_usecase.dart';
import 'features/chat/domain/use_cases/send_message_usecase.dart';
import 'features/chat/presentation/manager/cubit/chat/chat_cubit.dart';
import 'features/chat/presentation/manager/cubit/message/message_cubit.dart';
import 'features/nework/data/data_sources/connection_data_src_impl.dart';
import 'features/nework/data/repositories/connection_repository_impl.dart';
import 'features/nework/domain/repositories/connection_repository.dart';
import 'features/nework/domain/use_cases/connection_usecase.dart';
import 'features/news/comment/data/data_sources/comment_remote_data_src.dart';
import 'features/news/comment/data/data_sources/comment_remote_data_src_impl.dart';
import 'features/news/comment/data/repositories/comment_repository_impl.dart';
import 'features/news/comment/domain/repositories/comment_repository.dart';
import 'features/news/comment/domain/use_cases/create_comment_usecase.dart';
import 'features/news/comment/domain/use_cases/delete_comment_usecase.dart';
import 'features/news/comment/domain/use_cases/like_comment_use_case.dart';
import 'features/news/comment/domain/use_cases/read_comment_usecase.dart';
import 'features/news/comment/domain/use_cases/update_comment_usecase.dart';
import 'features/news/comment/presentation/managers/comment_cubit.dart';
import 'features/news/comment/replay/data/data_sources/replay_remote_data_scr_impl.dart';
import 'features/news/comment/replay/data/data_sources/replay_remote_data_src.dart';
import 'features/news/comment/replay/data/repositories/replay_repository_impl.dart';
import 'features/news/comment/replay/domain/repositories/replay_repository.dart';
import 'features/news/comment/replay/domain/use_cases/create_reply_usecase.dart';
import 'features/news/comment/replay/domain/use_cases/delete_reply_usecase.dart';
import 'features/news/comment/replay/domain/use_cases/like_replay_usecase.dart';
import 'features/news/comment/replay/domain/use_cases/read_replays.dart';
import 'features/news/comment/replay/domain/use_cases/update_replay_usecase.dart';
import 'features/news/comment/replay/presentation/manager/replay/replay_cubit.dart';
import 'features/news/data/data_sources/post_remote_data_src.dart';
import 'features/news/data/data_sources/post_remote_data_src_impl.dart';
import 'features/news/data/repositories/news_repository_impl.dart';
import 'features/news/domain/repositories/news_repository.dart';
import 'features/news/domain/use_cases/create_news_usecase.dart';
import 'features/news/domain/use_cases/delete_news_usecase.dart';
import 'features/news/domain/use_cases/like_news_usecase.dart';
import 'features/news/domain/use_cases/read_news_usecase.dart';
import 'features/news/domain/use_cases/read_single_news_usecase.dart';
import 'features/news/domain/use_cases/update_news_usecase.dart';
import 'features/news/presentaion/managers/news/get_single_new/get_single_news_cubit.dart';
import 'features/news/presentaion/managers/news/news_cubit.dart';
import 'features/post/domain/use_cases/upload_image_to_storage_usecase.dart';
import 'features/post/comment/data/data_sources/comment_remote_data_src.dart';
import 'features/post/comment/data/data_sources/comment_remote_data_src_impl.dart';
import 'features/post/comment/domain/use_cases/create_comment_usecase.dart';
import 'features/post/comment/domain/use_cases/delete_comment_usecase.dart';
import 'features/post/comment/domain/use_cases/like_comment_use_case.dart';
import 'features/post/comment/domain/use_cases/read_comment_usecase.dart';
import 'features/post/comment/domain/use_cases/update_comment_usecase.dart';
import 'features/post/comment/presentation/manager/comment/comment_cubit.dart';
import 'features/post/comment/replay/data/data_sources/replay_remote_data_scr_impl.dart';
import 'features/post/comment/replay/data/data_sources/replay_remote_data_src.dart';
import 'features/post/comment/replay/data/repositories/replay_repository_impl.dart';
import 'features/post/comment/replay/domain/repositories/replay_repository.dart';
import 'features/post/comment/replay/domain/use_cases/create_reply_usecase.dart';
import 'features/post/comment/replay/domain/use_cases/delete_reply_usecase.dart';
import 'features/post/comment/replay/domain/use_cases/like_replay_usecase.dart';
import 'features/post/comment/replay/domain/use_cases/read_replays.dart';
import 'features/post/comment/replay/domain/use_cases/update_replay_usecase.dart';
import 'features/post/comment/replay/presentation/manager/replay/replay_cubit.dart';
import 'features/post/data/data_sources/post_remote_data_src.dart';
import 'features/post/data/data_sources/post_remote_data_src_impl.dart';
import 'features/post/data/repositories/post_repository_impl.dart';
import 'features/post/domain/use_cases/create_post_usecase.dart';
import 'features/post/domain/use_cases/delete_post_usecase.dart';
import 'features/post/domain/use_cases/like_post_usecase.dart';
import 'features/post/domain/use_cases/read_posts_usecase.dart';
import 'features/post/domain/use_cases/read_single_post_usecase.dart';
import 'features/post/domain/use_cases/update_post_usecase.dart';
import 'features/post/presentation/manager/post/get_single_post/get_single_post_cubit.dart';
import 'features/post/presentation/manager/post/post_cubit.dart';
import 'features/user/domain/use_cases/get_other_single_user.dart';
import 'features/profile/presentation/manager/get_single_other_user_cubit.dart';
import 'features/user/auth/presentation/manager/auth/auth_cubit.dart';
import 'features/user/credential/presentation/manager/credential/credential_cubit.dart';
import 'features/user/domain/use_cases/create_user_usecase.dart';
import 'features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'features/user/domain/use_cases/get_single_user_usecase.dart';
import 'features/user/domain/use_cases/get_users_usecase.dart';
import 'features/user/domain/use_cases/is_sign_in_usecase.dart';
import 'features/user/domain/use_cases/sign_in_user_usecase.dart';
import 'features/user/domain/use_cases/sign_out_usecase.dart';
import 'features/user/domain/use_cases/sign_up_user_usecase.dart';
import 'features/user/domain/use_cases/update_user_usecase.dart';
import 'features/user/user_cubit/user/get_single_user/get_single_user_cubit.dart';
import 'features/user/user_cubit/user/user_cubit.dart';

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
    () => GetSingleUserCubit(getSingleUserUseCase: sl.call()),
  );
  sl.registerFactory(
    () => GetSingleOtherUserCubit(getSingleOtherUserUseCase: sl.call()),
  );
// User Cubit Injection
  sl.registerFactory(
    () => UserCubit(
      updateUserUseCase: sl.call(),
      getUsersUseCase: sl.call(),
      followUnFollowUseCase: sl.call(),
    ),
  );
  // single post
  sl.registerFactory(
    () => GetSinglePostCubit(readSinglePostUseCase: sl.call()),
  );
  // Post Cubit Injection
  sl.registerFactory(
    () => PostCubit(
        createPostUseCase: sl.call(),
        deletePostUseCase: sl.call(),
        likePostUseCase: sl.call(),
        readPostUseCase: sl.call(),
        updatePostUseCase: sl.call()),
  );
  sl.registerFactory(
    () => GetSingleNewsCubit(readSingleNewsUseCase: sl.call()),
  );
  sl.registerFactory(
    () => NewsCubit(
        createNewsUseCase: sl.call(),
        deleteNewsUseCase: sl.call(),
        likeNewsUseCase: sl.call(),
        readNewsUseCase: sl.call(),
        updateNewsUseCase: sl.call()),
  );

  /// Comment Cubit
  sl.registerFactory(
    () => NewsCommentCubit(
      createCommentUseCase: sl.call(),
      deleteCommentUseCase: sl.call(),
      likeCommentUseCase: sl.call(),
      readCommentsUseCase: sl.call(),
      updateCommentUseCase: sl.call(),
    ),
  );
// Replay Cubit Injection
  sl.registerFactory(
    () => NewsReplayCubit(
        createReplayUseCase: sl.call(),
        deleteReplayUseCase: sl.call(),
        likeReplayUseCase: sl.call(),
        readReplaysUseCase: sl.call(),
        updateReplayUseCase: sl.call()),
  );
  sl.registerFactory(
    () => GetSingleAnnouncementCubit(readSingleAnnouncementUseCase: sl.call()),
  );
  sl.registerFactory(
    () => AnnouncementCubit(
        createAnnouncementsUseCase: sl.call(),
        deleteAnnouncementsUseCase: sl.call(),
        likeAnnouncementsUseCase: sl.call(),
        readAnnouncementsUseCase: sl.call(),
        updateAnnouncementsUseCase: sl.call()),
  );

  /// Comment Cubit
  sl.registerFactory(
    () => CommentCubit(
      createCommentUseCase: sl.call(),
      deleteCommentUseCase: sl.call(),
      likeCommentUseCase: sl.call(),
      readCommentsUseCase: sl.call(),
      updateCommentUseCase: sl.call(),
    ),
  );
// Replay Cubit Injection
  sl.registerFactory(
    () => ReplayCubit(
        createReplayUseCase: sl.call(),
        deleteReplayUseCase: sl.call(),
        likeReplayUseCase: sl.call(),
        readReplaysUseCase: sl.call(),
        updateReplayUseCase: sl.call()),
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
  sl.registerLazySingleton(
      () => GetSingleOtherUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => FollowUnFollowUseCase(repository: sl.call()));

  //storage
  sl.registerLazySingleton(
      () => UploadImageToStorageUseCase(repository: sl.call()));
  sl.registerLazySingleton(
      () => UploadImageToStorageUseCase1(repository: sl.call()));

  // Repository

  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl.call()));

  // Remote Data Source
  sl.registerLazySingleton<UserRemoteDataSrc>(() => UserRemoteDataSourceImpl(
        firebaseFirestore: sl.call(),
        firebaseAuth: sl.call(),
        firebaseStorage: sl.call(),
      ));
  sl.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(remoteDataSource: sl.call()));

  // Remote Data Source
  sl.registerLazySingleton<PostRemoteDataSrc>(() => PostRemoteDataSourceImpl(
        firebaseFirestore: sl.call(),
        firebaseAuth: sl.call(),
        firebaseStorage: sl.call(),
      ));
  sl.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(remoteDataSource: sl.call()));

  // Remote Data Source
  sl.registerLazySingleton<NewsRemoteDataSrc>(() => NewsRemoteDataSourceImpl(
        firebaseFirestore: sl.call(),
        firebaseAuth: sl.call(),
        firebaseStorage: sl.call(),
      ));
  sl.registerLazySingleton<AnnouncementRepository>(
      () => AnnouncementsRepositoryImpl(remoteDataSource: sl.call()));

  // Remote Data Source
  sl.registerLazySingleton<AnnouncementsRemoteDataSrc>(
      () => AnnouncementsRemoteDataSourceImpl(
            firebaseFirestore: sl.call(),
            firebaseAuth: sl.call(),
            firebaseStorage: sl.call(),
          ));

  // Remote Data Source
  sl.registerLazySingleton<CommentRemoteDataSrc>(() => CommentRemoteDataSrcImp(
        firebaseFirestore: sl.call(),
        firebaseAuth: sl.call(),
        firebaseStorage: sl.call(),
      ));
  sl.registerLazySingleton<ReplayRepository>(
      () => ReplayRepositoryImpl(remoteDataSource: sl.call()));

  // Remote Data Source
  sl.registerLazySingleton<ReplayRemoteDataSrc>(() => ReplayRemoteDataSrcImpl(
        firebaseFirestore: sl.call(),
        firebaseAuth: sl.call(),
        firebaseStorage: sl.call(),
      ));
  sl.registerLazySingleton<NewsReplayRemoteDataSrc>(
      () => NewsReplayRemoteDataSrcImpl(
            firebaseFirestore: sl.call(),
            firebaseAuth: sl.call(),
            firebaseStorage: sl.call(),
          ));
  sl.registerLazySingleton<NewsCommentRepository>(
      () => NewsCommentRepositoryImpl(remoteDataSource: sl.call()));

  // Remote Data Source
  sl.registerLazySingleton<NewsCommentRemoteDataSrc>(
      () => NewsCommentRemoteDataSrcImp(
            firebaseFirestore: sl.call(),
            firebaseAuth: sl.call(),
            firebaseStorage: sl.call(),
          ));
  sl.registerLazySingleton<NewsReplayRepository>(
      () => NewsReplayRepositoryImpl(remoteDataSource: sl.call()));
  sl.registerLazySingleton<ConnectionDataSrc>(() => ConnectionDataSrcImpl(
        firebaseFirestore: sl.call(),
        firebaseAuth: sl.call(),
        firebaseStorage: sl.call(),
      ));
  sl.registerLazySingleton<ConnectionRepository>(
      () => ConnectionRepositoryImpl(remoteDataSource: sl.call()));

  // News Use cases
  sl.registerLazySingleton(() => CreatePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadPostsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LikePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DeletePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadSinglePostUseCase(repository: sl.call()));

  sl.registerLazySingleton(() => CreateNewsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadNewsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LikeNewsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateNewsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DeleteNewsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadSingleNewsUseCase(repository: sl.call()));
  sl.registerLazySingleton(
      () => CreateAnnouncementsUseCase(repository: sl.call()));
  sl.registerLazySingleton(
      () => ReadAnnouncementsUseCase(repository: sl.call()));
  sl.registerLazySingleton(
      () => LikeAnnouncementsUseCase(repository: sl.call()));
  sl.registerLazySingleton(
      () => UpdateAnnouncementUseCase(repository: sl.call()));
  sl.registerLazySingleton(
      () => DeleteAnnouncementsUseCase(repository: sl.call()));
  sl.registerLazySingleton(
      () => ReadSingleAnnouncementsUseCase(repository: sl.call()));
  // Comment
  sl.registerLazySingleton(() => CreateCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadCommentsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LikeCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DeleteCommentUseCase(repository: sl.call()));
  // replay
  sl.registerLazySingleton(() => CreateReplayUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadReplaysUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LikeReplayUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateReplayUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DeleteReplayUseCase(repository: sl.call()));

  sl.registerLazySingleton(
      () => CreateNewsCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton(
      () => ReadNewsCommentsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LikeNewsCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton(
      () => UpdateNewsCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton(
      () => DeleteNewsCommentUseCase(repository: sl.call()));
  // replay
  sl.registerLazySingleton(
      () => CreateNewsReplayUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadNewsReplaysUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LikeNewsReplayUseCase(repository: sl.call()));
  sl.registerLazySingleton(
      () => UpdateNewsReplayUseCase(repository: sl.call()));
  sl.registerLazySingleton(
      () => DeleteNewsReplayUseCase(repository: sl.call()));
  sl.registerFactory<ChatCubit>(() =>
      ChatCubit(getMyChatUseCase: sl.call(), deleteMyChatUseCase: sl.call()));

  sl.registerFactory<MessageCubit>(() => MessageCubit(
      getMessagesUseCase: sl.call(),
      deleteMessageUseCase: sl.call(),
      sendMessageUseCase: sl.call(),
      seenMessageUpdateUseCase: sl.call()));

  // * USE CASES INJECTION

  sl.registerLazySingleton<DeleteMessageUseCase>(
      () => DeleteMessageUseCase(repository: sl.call()));

  sl.registerLazySingleton<DeleteMyChatUseCase>(
      () => DeleteMyChatUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetMessagesUseCase>(
      () => GetMessagesUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetMyChatUseCase>(
      () => GetMyChatUseCase(repository: sl.call()));

  sl.registerLazySingleton<SendMessageUseCase>(
      () => SendMessageUseCase(repository: sl.call()));

  sl.registerLazySingleton<SeenMessageUpdateUseCase>(
      () => SeenMessageUpdateUseCase(repository: sl.call()));

  // * REPOSITORY & DATA SOURCES INJECTION

  sl.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(remoteDataSource: sl.call()));

  sl.registerLazySingleton<ChatRemoteDataSource>(() => ChatRemoteDataSourceImpl(
        fireStore: sl.call(),
      ));

  // Externals

  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseStorage);
}
