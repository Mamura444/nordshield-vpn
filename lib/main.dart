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
              center: Alignment(0, -0.5),
              radius: 1.2,
              colors: [Color(0xFF0D1525), Color(0xFF0A0D14)],
            ),
          ),
        ),
        SafeArea(child: Column(children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20,16,20,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(text: const TextSpan(
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  children: [
                    TextSpan(text: 'Nord', style: TextStyle(color: Colors.white)),
                    TextSpan(text: 'Shield', style: TextStyle(color: Color(0xFF00E5FF))),
                  ],
                )),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B28),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF1E2535)),
                  ),
                  child: Text(
                    connected ? selected!['ip'] : '—.—.—.—',
                    style: const TextStyle(fontSize: 11, color: Color(0xFF00E5FF), fontFamily: 'monospace'),
                  ),
                ),
              ],
            ),
          ),

          // Connect button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(children: [
              GestureDetector(
                onTap: toggleConnect,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 140, height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF161B28),
                    border: Border.all(
                      color: connected ? const Color(0xFF00FF88)
                           : connecting ? const Color(0xFF00E5FF)
                           : const Color(0xFF1E2535),
                      width: 3,
                    ),
                    boxShadow: connected ? [const BoxShadow(
                      color: Color(0x3300FF88), blurRadius: 30,
                    )] : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      connecting
                        ? const CircularProgressIndicator(
                            color: Color(0xFF00E5FF), strokeWidth: 2)
                        : Icon(
                            Icons.power_settings_new,
                            size: 40,
                            color: connected ? const Color(0xFF00FF88) : const Color(0xFF5A6070),
                          ),
                      const SizedBox(height: 6),
                      Text(
                        connected ? 'ОТКЛЮЧИТЬ'
                            : connecting ? 'ПОДКЛЮЧ...'
                            : 'НАЖМИ',
                        style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: connected ? const Color(0xFF00FF88)
                              : connecting ? const Color(0xFF00E5FF)
                              : const Color(0xFF5A6070),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                decoration: BoxDecoration(
                  color: const Color(0xFF161B28),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: connected ? const Color(0xFF00FF88).withOpacity(0.4)
                        : const Color(0xFF1E2535),
                  ),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    width: 8, height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: connected ? const Color(0xFF00FF88)
                          : connecting ? const Color(0xFF00E5FF)
                          : const Color(0xFF5A6070),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    connected ? '${selected!['flag']} ${selected!['country']}'
                        : connecting ? 'Подключение...'
                        : 'Не подключён',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ]),
              ),
            ]),
          ),

          // Stats
          Padding(
            padding: const EdgeInsets.fromLTRB(20,0,20,16),
            child: Row(children: [
              _statCard('ПИНГ', connected ? '${selected!['ping']}мс' : '—', connected ? pingColor : const Color(0xFF00E5FF)),
              const SizedBox(width: 8),
              _statCard('СКОРОСТЬ', connected ? selected!['speed'] : '—', connected ? const Color(0xFF00FF88) : const Color(0xFF00E5FF)),
              const SizedBox(width: 8),
              _statCard('СЕРВЕР', connected ? selected!['flag'] : '—', const Color(0xFF00E5FF)),
            ]),
          ),

          // Server list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('СЕРВЕРЫ', style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w700,
                  letterSpacing: 2, color: Color(0xFF5A6070),
                )),
                Text('${servers.length} доступно', style: const TextStyle(
                  fontSize: 11, color: Color(0xFF5A6070),
                )),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: servers.length,
              separatorBuilder: (_,__) => const SizedBox(height: 7),
              itemBuilder: (_,i) {
                final s = servers[i];
                final isSel = selected?['ip'] == s['ip'];
                final p = s['ping'] as int;
                final pc = p < 60 ? const Color(0xFF00FF88)
                         : p < 120 ? const Color(0xFFFFCC00)
                         : const Color(0xFFFF4444);
                return GestureDetector(
                  onTap: () {
                    if (connected) setState(() { connected = false; });
                    setState(() => selected = s);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                    decoration: BoxDecoration(
                      color: isSel ? const Color(0xFF0D1525) : const Color(0xFF161B28),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSel ? const Color(0xFF00E5FF).withOpacity(0.5)
                            : const Color(0xFF1E2535),
                      ),
                    ),
                    child: Row(children: [
                      if (isSel) Container(
                        width: 3, height: 36, margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00E5FF),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Text(s['flag'], style: const TextStyle(fontSize: 22)),
                      const SizedBox(width: 12),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s['country'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                          Text(s['ip'], style: const TextStyle(fontSize: 10, color: Color(0xFF5A6070), fontFamily: 'monospace')),
                        ],
                      )),
                      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Text('${p}мс', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: pc, fontFamily: 'monospace')),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(3, (j) => Container(
                            width: 4, margin: const EdgeInsets.only(left: 2),
                            height: [8.0,12.0,16.0][j],
                            decoration: BoxDecoration(
                              color: j < (p<60?3:p<120?2:1) ? pc : const Color(0xFF1E2535),
                              borderRadius: BorderRadius.circular(1),
                            ),
                          )),
                        ),
                      ]),
                    ]),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ])),
      ]),
    );
  }

  Widget _statCard(String label, String value, Color color) {
    return Expanded(child: Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFF161B28),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1E2535)),
      ),
      child: Column(children: [
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: color, fontFamily: 'monospace')),
        const SizedBox(height: 3),
        Text(label, style: const TextStyle(fontSize: 9, color: Color(0xFF5A6070), letterSpacing: 0.8)),
      ]),
    ));
  }
}
