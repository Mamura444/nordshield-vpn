import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const NordShieldApp());
}

class NordShieldApp extends StatelessWidget {
  const NordShieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NordShield VPN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00E5FF),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0D14),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String,dynamic>> servers = [
    {'country':'Япония','flag':'🇯🇵','ip':'219.100.37.190','ping':24,'speed':'68 Мбит'},
    {'country':'Южная Корея','flag':'🇰🇷','ip':'203.249.7.215','ping':31,'speed':'91 Мбит'},
    {'country':'Сингапур','flag':'🇸🇬','ip':'165.22.231.18','ping':44,'speed':'55 Мбит'},
    {'country':'Германия','flag':'🇩🇪','ip':'185.220.101.47','ping':52,'speed':'35 Мбит'},
    {'country':'Нидерланды','flag':'🇳🇱','ip':'45.138.16.80','ping':58,'speed':'28 Мбит'},
    {'country':'США','flag':'🇺🇸','ip':'173.244.209.202','ping':88,'speed':'42 Мбит'},
    {'country':'Франция','flag':'🇫🇷','ip':'51.158.63.21','ping':61,'speed':'22 Мбит'},
    {'country':'Швеция','flag':'🇸🇪','ip':'194.165.16.93','ping':65,'speed':'30 Мбит'},
    {'country':'Великобритания','flag':'🇬🇧','ip':'51.195.7.19','ping':72,'speed':'26 Мбит'},
    {'country':'Канада','flag':'🇨🇦','ip':'64.44.141.238','ping':95,'speed':'18 Мбит'},
  ];

  Map<String,dynamic>? selected;
  bool connected = false;
  bool connecting = false;

  Color get pingColor {
    if (selected == null) return Colors.white;
    final p = selected!['ping'] as int;
    if (p < 60) return const Color(0xFF00FF88);
    if (p < 120) return const Color(0xFFFFCC00);
    return const Color(0xFFFF4444);
  }

  Future<void> toggleConnect() async {
    if (connecting) return;
    if (connected) {
      setState(() { connected = false; selected = null; });
      return;
    }
    if (selected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Выберите сервер!'))
      );
      return;
    }
    setState(() => connecting = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() { connecting = false; connected = true; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0,
