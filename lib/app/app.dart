import 'package:donation/controller/notification.dart';
import 'package:donation/controller/theme.dart';
import 'package:donation/presentation/layout/chats/view_model.dart';
import 'package:donation/presentation/layout/home/search/view_model.dart';
import 'package:donation/presentation/layout/home/view_model.dart';
import 'package:donation/presentation/layout/layout_view_model.dart';
import 'package:donation/presentation/layout/profile/view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../presentation/_resources/routes_manager.dart';
import '../presentation/_resources/theme_manager.dart';
import '../presentation/auth/auth_view_model.dart';
import '../presentation/layout/campaign/view_model.dart';
import '../presentation/layout/home/comments/view_model.dart';
import 'global_imports.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCtrl()),
        BlocProvider(create: (_) => NotificationCtrl()),
        BlocProvider(create: (_) => AuthCtrl()),
        BlocProvider(create: (_) => LayoutVM()),
        BlocProvider(create: (_) => SearchVM()..getRecentSearchList()),
        BlocProvider(create: (_) => SettingVM()..initPackageInfo()),
        BlocProvider(
            create: (_) => HomeCtrl()
              ..getPosts()
              ..openBox()),
        BlocProvider(create: (_) => CommentsCtrl()..getComments()),
        BlocProvider(create: (_) => ChatCtrl()),
        BlocProvider(create: (_) => CampaignsCtrl()..getCampaigns()),
      ],
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return BlocBuilder<ThemeCtrl, bool>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,

                themeMode: context.watch<ThemeCtrl>().state
                    ? ThemeMode.dark
                    : ThemeMode.light,

                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                onGenerateRoute: RouteGenerator.getRoute,
                initialRoute: Routes.splashRoute,
                // theme: getApplicationTheme(),
              );
            },
          );
        },
      ),
    );
  }
}
