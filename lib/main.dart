import 'package:flutter/material.dart';
import 'package:goldiss_chat/Core/app_theme.dart';
import 'package:goldiss_chat/features/auth/presentation/screens/login_screen.dart';
import 'package:goldiss_chat/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:goldiss_chat/features/auth/presentation/screens/register_screen.dart';
import 'package:goldiss_chat/features/auth/presentation/screens/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.get('API_URL'),
    anonKey: dotenv.get('ANON_KEY'),
  );

  try {
    final data = await Supabase.instance.client
        .from('_test_connection_')
        .select()
        .limit(1);
    print('Connecté : $data');
  } catch (e) {
    print(
      'Erreur attendue : $e',
    ); // Devrait indiquer "relation _test_connection_ does not exist"
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goldiss Chat',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/onboarding': (_) => const OnboardingScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
      },
    );
  }
}
