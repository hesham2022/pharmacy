import 'package:chefaa/modeules/User/Home_Screen/search_cubit/search_cubit.dart';
import 'package:chefaa/modeules/User/Messages_Screen/chat_cubit.dart';
import 'package:chefaa/modeules/User/auth/data/datasources/chat_remote.dart';
import 'package:chefaa/modeules/User/auth/data/datasources/post_remote.dart';
import 'package:chefaa/modeules/User/auth/data/repositories/post_repository.dart';
import 'package:chefaa/modeules/User/auth/domain/repositories/i_chat_repository.dart';
import 'package:chefaa/modeules/User/auth/domain/repositories/i_post_repository.dart';
import 'package:chefaa/modeules/User/auth/domain/usecases/get_posts.dart';
import 'package:chefaa/modeules/User/auth/presentation/usr_bloc/creat_post_cubit.dart';
import 'package:chefaa/modeules/User/auth/presentation/usr_bloc/create_review_cubit.dart';
import 'package:chefaa/modeules/User/auth/presentation/usr_bloc/get_post_detals_cubit.dart';
import 'package:chefaa/modeules/User/auth/presentation/usr_bloc/get_posts_cubit.dart';
import 'package:chefaa/modeules/User/auth/presentation/usr_bloc/get_reviews_cubit.dart';
import 'package:chefaa/modeules/User/auth/presentation/usr_bloc/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../core/api_config/api_client.dart';
import '../core/local_storage/token_storage.dart';
import '../modeules/User/auth/data/datasources/auth_remote.dart';
import '../modeules/User/auth/data/datasources/user_remote.dart';
import '../modeules/User/auth/data/repositories/auth_respository.dart';
import '../modeules/User/auth/data/repositories/chat_repository.dart';
import '../modeules/User/auth/data/repositories/user_repository.dart';
import '../modeules/User/auth/domain/repositories/i_repository.dart';
import '../modeules/User/auth/domain/repositories/i_user.dart';
import '../modeules/User/auth/domain/usecases/get_me.dart';
import '../modeules/User/auth/domain/usecases/get_near.dart';
import '../modeules/User/auth/domain/usecases/get_user.dart';
import '../modeules/User/auth/domain/usecases/update_provider.dart';
import '../modeules/User/auth/domain/usecases/update_user.dart';
import '../modeules/User/auth/domain/usecases/upload_provider_attachment.dart';
import '../modeules/User/auth/domain/usecases/upload_provider_photo.dart';
import '../modeules/User/auth/domain/usecases/upload_user_photo.dart';
import '../modeules/User/auth/presentation/blocs/auth_bloc/authentication_bloc.dart';
import '../modeules/User/auth/presentation/blocs/change_phone_number_cubit/change_phone_number_cubit.dart';
import '../modeules/User/auth/presentation/blocs/forget_password_bloc/forget_password_cubit.dart';
import '../modeules/User/auth/presentation/blocs/login_bloc/login_bloc.dart';
import '../modeules/User/auth/presentation/blocs/verify_otp _firebase/verify_otp_fiebase_cubit.dart';
import '../modeules/User/auth/presentation/blocs/verify_otp/verify_otp_cubit.dart';
import '../modeules/User/auth/presentation/usr_bloc/get_near_cubit.dart';
import '../modeules/User/auth/presentation/usr_bloc/get_pharmacy_byuser_cubit.dart';
import '../modeules/User/auth/presentation/usr_bloc/get_provider_cubit.dart';
import '../modeules/User/auth/presentation/usr_bloc/get_review_stats_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt
    // Utils
    ..registerLazySingleton<ApiClient>(ApiClient.new)
    ..registerLazySingleton<GlobalKey<NavigatorState>>(
        () => GlobalKey<NavigatorState>())

    // Data Sources
    ..registerLazySingleton<ITokenStorage>(TokenStorage.new)
    ..registerLazySingleton<IAuthRemotDataSource>(
      () => AuthRemotDataSource(getIt<ApiClient>()),
    )
    // ..registerLazySingleton<IJobRemoteDataSource>(
    //   () => JobRemoteDataSource(getIt<ApiClient>()),
    // )
    ..registerLazySingleton<IUserRemote>(() => UserRemote(getIt()))
    ..registerLazySingleton<IPostRemote>(() => PostRemote(getIt()))
    ..registerLazySingleton<IChatRemote>(() => ChatRemote(getIt()))

    /// Repositories
    ..registerLazySingleton<IAuthenticationRepository>(
      () => AuthenticationRepository(
        authenticationLocalDataSource: getIt<ITokenStorage>(),
        authRemotDataSource: getIt<IAuthRemotDataSource>(),
        apiConfig: getIt(),
      ),
    )
    ..registerLazySingleton<IUserRepository>(() => UserRepository(getIt()))
    ..registerLazySingleton<IPostRepository>(() => PostRepository(getIt()))
    ..registerLazySingleton<IChatRespository>(() => ChatRepository(getIt()))

    //Use Cases
    ..registerLazySingleton<SearchPharmaciesU>(() => SearchPharmaciesU(getIt()))
    ..registerLazySingleton<GetMe>(() => GetMe(getIt()))
    ..registerLazySingleton<GetUser>(() => GetUser(getIt()))
    ..registerLazySingleton<UpdateUser>(() => UpdateUser(getIt()))
    ..registerLazySingleton<GetNearU>(() => GetNearU(getIt()))
    ..registerLazySingleton<GetTopNearU>(() => GetTopNearU(getIt()))
    ..registerLazySingleton<GetNearWith24U>(() => GetNearWith24U(getIt()))
    ..registerLazySingleton<GetPharmacyByUser>(() => GetPharmacyByUser(getIt()))
    ..registerLazySingleton<FollowPharmacy>(() => FollowPharmacy(getIt()))
    ..registerLazySingleton<UnFollowPharmacy>(() => UnFollowPharmacy(getIt()))
    ..registerLazySingleton<GetRatingStatsU>(() => GetRatingStatsU(getIt()))
    ..registerLazySingleton<GetReviewsU>(() => GetReviewsU(getIt()))
    ..registerLazySingleton<GetPostsU>(() => GetPostsU(getIt()))
    ..registerLazySingleton<CreateReviewsU>(() => CreateReviewsU(getIt()))
    ..registerLazySingleton<UpdateProvider>(() => UpdateProvider(getIt()))
    ..registerLazySingleton<GetPostDetailsU>(() => GetPostDetailsU(getIt()))
    ..registerLazySingleton<LikePostU>(() => LikePostU(getIt()))
    ..registerLazySingleton<CreaetPostU>(() => CreaetPostU(getIt()))
    ..registerLazySingleton<UploadUserPhoto>(
      () => UploadUserPhoto(getIt()),
    )
    ..registerLazySingleton<UploadProviderPhoto>(
      () => UploadProviderPhoto(getIt()),
    )
    ..registerLazySingleton<UploadProviderAttachments>(
      () => UploadProviderAttachments(getIt()),
    )
    ..registerLazySingleton<GetProvider>(() => GetProvider(getIt()))
    ..registerLazySingleton<UploadMessageMedia>(
        () => UploadMessageMedia(getIt()))
    ..registerLazySingleton<DeleteProviderAttachments>(
      () => DeleteProviderAttachments(getIt()),
    )
    // Blocs
    ..registerFactory<AuthenticationBloc>(
      () => AuthenticationBloc(
        authenticationRepository: getIt(),
        getMe: getIt(),
      ),
    )
    ..registerFactory<GetProviderCubit>(
      () => GetProviderCubit(
        getProvider: getIt(),
      ),
    )
    ..registerFactory<GetNearCubit>(
      () => GetNearCubit(
        getNearU: getIt(),
      ),
    )
    ..registerFactory<GetNearWith24Cubit>(
      () => GetNearWith24Cubit(
        getNearU: getIt(),
      ),
    )
    ..registerFactory<CreatePostCubit>(
      () => CreatePostCubit(
        creaetPostU: getIt(),
      ),
    )
    ..registerFactory<GetTopNearCubit>(
      () => GetTopNearCubit(
        getNearU: getIt(),
      ),
    )
    ..registerFactory<ChatCubit>(
      () => ChatCubit(),
    )
    ..registerFactory<GetPharmacyByUserCubit>(
      () => GetPharmacyByUserCubit(
        getIt(),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactory<UserCubit>(
      () => UserCubit(
          getMe: getIt(),
          getUser: getIt(),
          updateUser: getIt(),
          updateProvider: getIt()),
    )
    ..registerFactory<ForgetPasswordCubit>(
      () => ForgetPasswordCubit(authenticationRepository: getIt()),
    )
    ..registerFactory<ChangephoneCubit>(
      () => ChangephoneCubit(authenticationRepository: getIt()),
    )
    ..registerFactory<GetRatingStatsCubit>(
      () => GetRatingStatsCubit(getRatingStatsU: getIt()),
    )
    ..registerFactory<GetReviewsCubit>(
      () => GetReviewsCubit(getReviewsU: getIt()),
    )
    ..registerFactory<GetPostsCubit>(
      () => GetPostsCubit(getPostsU: getIt()),
    )
    ..registerFactory<CreateReviewCubit>(
      () => CreateReviewCubit(CreateReviewU: getIt()),
    )
    ..registerFactory<GetPostDetailsCubit>(
      () => GetPostDetailsCubit(getIt(), getIt()),
    )
    ..registerFactory<VerifyOtpCubit>(
      () => VerifyOtpCubit(authenticationRepository: getIt()),
    )
    ..registerFactory<VerifyOtpFirebaseCubit>(
      () => VerifyOtpFirebaseCubit(authenticationRepository: getIt()),
    )
    ..registerFactory<LoginBloc>(
      () => LoginBloc(authenticationRepository: getIt()),
    )
    ..registerFactory<SingUpBloc>(
      () => SingUpBloc(authenticationRepository: getIt()),
    )
    ..registerFactory<SearchPharmaciesCubit>(
      () => SearchPharmaciesCubit(searchPharmaciesU: getIt()),
    )
    ..registerFactory<SingUpBProviderloc>(
      () => SingUpBProviderloc(authenticationRepository: getIt()),
    );
}
