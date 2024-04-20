import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_link/features/binding/general_binding.dart';
import 'package:uni_link/features/user/presentation/manager/auth/auth_cubit.dart';
import 'package:uni_link/features/user/presentation/manager/credential/credential_cubit.dart';
import 'package:uni_link/repository/auth_2_repo.dart';
import 'package:uni_link/utils/theme/theme.dart';
import 'features/chat/presentation/manager/cubit/chat/chat_cubit.dart';
import 'features/chat/presentation/manager/cubit/message/message_cubit.dart';
import 'features/main/main_screen.dart';
import 'features/profile/presentation/manager/get_single_other_user_cubit.dart';
import 'features/user/presentation/manager/user/user_cubit/user/get_single_user/get_single_user_cubit.dart';
import 'features/user/presentation/manager/user/user_cubit/user/user_cubit.dart';
import 'features/user/presentation/pages/login/sign_in_page.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'on_generate_rote.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetSingleOtherUserCubit>(
          create: (context) => di.sl<GetSingleOtherUserCubit>(),
        ),
        BlocProvider<UserCubit>(create: (context) => di.sl<UserCubit>()),
        BlocProvider<GetSingleOtherUserCubit>(
            create: (context) => di.sl<GetSingleOtherUserCubit>()),
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted(context)),
        BlocProvider(create: (_) => di.sl<CredentialCubit>()),
        BlocProvider(create: (_) => di.sl<UserCubit>()),
        BlocProvider(create: (_) => di.sl<GetSingleUserCubit>()),
        BlocProvider(
          create: (context) => di.sl<ChatCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<MessageCubit>(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "UNI-NET",
        theme: OAppTheme.lightTheme,
        darkTheme: OAppTheme.darkTheme,
        themeMode: ThemeMode.system,
        onGenerateRoute: OnGenerateRoute.route,
        initialBinding: GeneralBindings(),
        initialRoute: "/",
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainScreen(
                    uid: authState.uid,
                  );
                } else {
                  return const SignInPage();
                }
              },
            );
          }
        },
      ),
    );
  }
}
