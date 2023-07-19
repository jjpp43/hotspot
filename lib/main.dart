import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotspot/root.dart';
import 'package:hotspot/src/blocs/info/info_bloc.dart';
import 'package:hotspot/src/services/app_router.dart';
import 'firebase_options.dart';
import 'src/repositories/auth_repository.dart';
import 'src/services/app_theme.dart';
import 'package:path_provider/path_provider.dart';
import 'src/blocs/bloc_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    App(appRouter: AppRouter()),
  );
}

class App extends StatelessWidget {
  const App({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context)),
          ),
          BlocProvider(
            create: (context) => SwitchBloc(),
          ),
          BlocProvider(
            create: (context) => InfoBloc(),
          ),
          // BlocProvider(
          //   create: (context) => LanguageBloc(),
          // ),
        ],
        child: BlocBuilder<SwitchBloc, SwitchState>(
          builder: (context, switchState) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Hotspot',
              theme: switchState.switchValue
                  ? AppThemes.appThemeData[AppTheme.darkTheme]
                  : AppThemes.appThemeData[AppTheme.lightTheme],
              home: const Root(),
              onGenerateRoute: appRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
