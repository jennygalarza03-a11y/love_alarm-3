import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const FirebaseOptions firebaseOptions = FirebaseOptions(
  apiKey: "AIzaSyBVUPrwKHX0r0bdKCHgNqwXXLV5cGFKRuU",
  authDomain: "love-alarm-54655.firebaseapp.com",
  projectId: "love-alarm-54655",
  storageBucket: "love-alarm-54655.appspot.com",
  messagingSenderId: "478742713297",
  appId: "1:478742713297:web:23bf13b8b9b5447cc6f0e",
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // ✅ Solo inicializar si NO existe ya
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
  
  runApp(const LoveAlarmApp());
}

class AppColors {
  static const pink = Color(0xFFFF8FAB);
  static const pinkLight = Color(0xFFFFB6C1);
  static const lavender = Color(0xFFC8A2C8);
  static const cream = Color(0xFFFFF5FA);
  static const peach = Color(0xFFFFD1DC);
  static const purple = Color(0xFF9B7EBD);
  static const textDark = Color(0xFF6B4E71);
  static const textSoft = Color(0xFF8B6B8B);
  static const darkBg = Color(0xFF1A1A2E);
  static const darkCard = Color(0xFF2D2D44);
  static const darkPink = Color(0xFFFF6B8B);
  static const darkText = Color(0xFFFFE4EC);
}

class LoveAlarmApp extends StatefulWidget {
  const LoveAlarmApp({super.key});

  @override
  State<LoveAlarmApp> createState() => _LoveAlarmAppState();
}

class _LoveAlarmAppState extends State<LoveAlarmApp> {
  ThemeMode _themeMode = ThemeMode.light;
  String? _userName;
  String? _myCode;
  String? _partnerCode;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _setUserData(String name, String code) {
    setState(() {
      _userName = name;
      _myCode = code;
    });
  }

  void _setPartner(String partnerCode) {
    setState(() {
      _partnerCode = partnerCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Love Alarm',
      debugShowCheckedModeBanner: false,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: _themeMode,
      home: const SplashScreen(),
      routes: {
        '/welcome': (context) => WelcomeScreen(onToggleTheme: _toggleTheme),
        '/create_account': (context) => CreateAccountScreen(onComplete: _setUserData),
        '/link_partner': (context) => LinkPartnerScreen(myCode: _myCode ?? '', onLinked: _setPartner),
        '/home': (context) => HomeScreen(
          userName: _userName ?? '',
          myCode: _myCode ?? '',
          partnerCode: _partnerCode,
        ),
      },
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.pink,
      colorScheme: ColorScheme.light(
        primary: AppColors.pink,
        secondary: AppColors.lavender,
        surface: AppColors.cream,
      ),
      scaffoldBackgroundColor: AppColors.cream,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textDark),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.textDark),
        titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.textDark),
        bodyLarge: TextStyle(fontSize: 18, color: AppColors.textSoft),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.pink,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.pinkLight, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.pink, width: 2),
        ),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.darkPink,
      colorScheme: ColorScheme.dark(
        primary: AppColors.darkPink,
        secondary: AppColors.lavender,
        surface: AppColors.darkCard,
      ),
      scaffoldBackgroundColor: AppColors.darkBg,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.darkText),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.darkText),
        titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.darkText),
        bodyLarge: TextStyle(fontSize: 18, color: Color(0xFFB8A0B8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkPink,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkCard,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.darkPink.withOpacity(0.3), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.darkPink, width: 2),
        ),
      ),
    );
  }
}

class RomanticBackground extends StatefulWidget {
  final Widget child;
  final bool isDark;
  final String imageLight;
  final String imageDark;

  const RomanticBackground({
    super.key,
    required this.child,
    this.isDark = false,
    required this.imageLight,
    required this.imageDark,
  });

  @override
  State<RomanticBackground> createState() => _RomanticBackgroundState();
}

class _RomanticBackgroundState extends State<RomanticBackground> with TickerProviderStateMixin {
  late final AnimationController _controller;
  final List<FloatingHeart> _hearts = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat();
    for (int i = 0; i < 10; i++) {
      _hearts.add(FloatingHeart(
        left: _random.nextDouble(),
        size: 10 + _random.nextDouble() * 22,
        opacity: 0.15 + _random.nextDouble() * 0.25,
        delay: _random.nextDouble(),
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            isDark ? widget.imageDark : widget.imageLight,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [const Color(0xFF1A1A2E), const Color(0xFF2D1B3D), const Color(0xFF1A1A2E)]
                        : [const Color(0xFFFFE4EC), const Color(0xFFF3E5F5), const Color(0xFFFFF0F5)],
                  ),
                ),
              );
            },
          ),
        ),
        Positioned.fill(
          child: Container(
            color: isDark ? Colors.black.withOpacity(0.45) : Colors.white.withOpacity(0.35),
          ),
        ),
        ..._hearts.map((heart) => AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final progress = (_controller.value + heart.delay) % 1.0;
            final top = 1.0 - progress;
            return Positioned(
              left: heart.left * MediaQuery.of(context).size.width,
              top: top * MediaQuery.of(context).size.height,
              child: Opacity(
                opacity: heart.opacity * (1 - progress * 0.5),
                child: Icon(
                  Icons.favorite,
                  size: heart.size,
                  color: isDark ? AppColors.darkPink : AppColors.pink,
                ),
              ),
            );
          },
        )),
        widget.child,
      ],
    );
  }
}

class FloatingHeart {
  final double left, size, opacity, delay;
  FloatingHeart({required this.left, required this.size, required this.opacity, required this.delay});
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isDark;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFFFF6B8B), const Color(0xFFC44569)]
              : [AppColors.pink, AppColors.lavender],
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? AppColors.darkPink : AppColors.pink).withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: 22), const SizedBox(width: 8)],
            Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class SoftCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final bool isDark;

  const SoftCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard.withOpacity(0.85) : Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : AppColors.pink).withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.1) : Colors.white,
          width: 1.5,
        ),
      ),
      child: child,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _heartAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _heartAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
    Timer(const Duration(seconds: 3), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/welcome');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: RomanticBackground(
        isDark: isDark,
        imageLight: 'assets/images/splash_light.jpg',
        imageDark: 'assets/images/splash_dark.jpg',
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _heartAnimation,
                builder: (context, child) => Transform.scale(
                  scale: _heartAnimation.value,
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: isDark
                            ? [const Color(0xFFFF6B8B), const Color(0xFFC44569)]
                            : [AppColors.pink, AppColors.lavender],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (isDark ? AppColors.darkPink : AppColors.pink).withOpacity(0.5),
                          blurRadius: 40,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.favorite, size: 60, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'LOVE ALARM',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: isDark ? AppColors.darkText : AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Solo tú y yo',
                style: TextStyle(
                  fontSize: 18,
                  color: isDark ? Colors.white70 : AppColors.textSoft,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  const WelcomeScreen({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: RomanticBackground(
        isDark: isDark,
        imageLight: 'assets/images/welcome_light.jpg',
        imageDark: 'assets/images/welcome_dark.jpg',
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      isDark ? Icons.wb_sunny : Icons.nightlight_round,
                      color: isDark ? Colors.white70 : AppColors.textDark,
                    ),
                    onPressed: onToggleTheme,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: isDark
                          ? [const Color(0xFFFF6B8B).withOpacity(0.4), const Color(0xFFC44569).withOpacity(0.4)]
                          : [AppColors.pink.withOpacity(0.4), AppColors.lavender.withOpacity(0.4)],
                    ),
                  ),
                  child: const Center(child: Icon(Icons.favorite, size: 80, color: Colors.white)),
                ),
                const SizedBox(height: 40),
                Text(
                  'LOVE ALARM',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    color: isDark ? AppColors.darkText : AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Cuando extrañes a tu persona,\ntoca el corazón y hazle saber',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: isDark ? Colors.white70 : AppColors.textSoft,
                  ),
                ),
                const SizedBox(height: 48),
                GradientButton(
                  text: 'COMENZAR',
                  icon: Icons.favorite,
                  isDark: isDark,
                  onPressed: () => Navigator.pushNamed(context, '/create_account'),
                ),
                const Spacer(),
                Text(
                  'Hecho con amor',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white54 : AppColors.textSoft.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateAccountScreen extends StatefulWidget {
  final void Function(String name, String code) onComplete;
  const CreateAccountScreen({super.key, required this.onComplete});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _nameController = TextEditingController();
  String? _myCode;
  bool _isLoading = false;

  String _generateCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final r = DateTime.now().microsecondsSinceEpoch;
    return List.generate(6, (i) => chars[(r ~/ (i + 17)) % chars.length]).join();
  }

  Future<void> _saveUser() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    setState(() => _isLoading = true);
    final code = _generateCode();
    final db = FirebaseFirestore.instance;
    await db.collection('users').doc(code).set({
      'name': name,
      'code': code,
      'partnerCode': null,
      'alarmAt': null,
      'lastMessage': null,
      'totalLoveCount': 0,
      'createdAt': FieldValue.serverTimestamp(),
    });
    setState(() {
      _myCode = code;
      _isLoading = false;
    });
    widget.onComplete(name, code);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Crear cuenta'),
      ),
      extendBodyBehindAppBar: true,
      body: RomanticBackground(
        isDark: isDark,
        imageLight: 'assets/images/welcome_light.jpg',
        imageDark: 'assets/images/welcome_dark.jpg',
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: SoftCard(
                isDark: isDark,
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: isDark
                              ? [const Color(0xFFFF6B8B), const Color(0xFFC44569)]
                              : [AppColors.pink, AppColors.lavender],
                        ),
                      ),
                      child: const Icon(Icons.favorite, size: 40, color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '¿Cómo te llamas?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.darkText : AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Este nombre lo verá tu persona especial',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white60 : AppColors.textSoft,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Tu nombre...',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 32),
                    if (_myCode == null)
                      GradientButton(
                        text: 'Continuar',
                        isDark: isDark,
                        onPressed: _isLoading ? null : _saveUser,
                      ),
                    if (_myCode != null) ...[
                      const Text('Tu código de amor es:', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDark
                                ? [const Color(0xFFFF6B8B).withOpacity(0.2), const Color(0xFFC44569).withOpacity(0.2)]
                                : [AppColors.pink.withOpacity(0.15), AppColors.lavender.withOpacity(0.15)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDark ? AppColors.darkPink : AppColors.pink,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          _myCode!,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 8,
                            color: isDark ? AppColors.darkPink : AppColors.pink,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '¡Compártelo con tu persona especial!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.white60 : AppColors.textSoft,
                        ),
                      ),
                      const SizedBox(height: 32),
                      GradientButton(
                        text: 'Siguiente',
                        icon: Icons.arrow_forward,
                        isDark: isDark,
                        onPressed: () => Navigator.pushNamed(context, '/link_partner'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LinkPartnerScreen extends StatefulWidget {
  final String myCode;
  final void Function(String partnerCode) onLinked;

  const LinkPartnerScreen({super.key, required this.myCode, required this.onLinked});

  @override
  State<LinkPartnerScreen> createState() => _LinkPartnerScreenState();
}

class _LinkPartnerScreenState extends State<LinkPartnerScreen> {
  final TextEditingController _codeController = TextEditingController();
  bool _isLinking = false;

  Future<void> _linkPartner() async {
    final code = _codeController.text.trim().toUpperCase();
    if (code.length != 6) {
      _showMsg('El código debe tener 6 caracteres');
      return;
    }
    if (code == widget.myCode) {
      _showMsg('No puedes vincularte contigo mismo');
      return;
    }
    setState(() => _isLinking = true);
    final db = FirebaseFirestore.instance;
    final partnerDoc = await db.collection('users').doc(code).get();
    if (!partnerDoc.exists) {
      _showMsg('Código no encontrado');
      setState(() => _isLinking = false);
      return;
    }
    await db.collection('users').doc(widget.myCode).update({'partnerCode': code});
    await db.collection('users').doc(code).update({'partnerCode': widget.myCode});
    _showMsg('¡Vinculados con éxito! 💞');
    setState(() => _isLinking = false);
    widget.onLinked(code);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) Navigator.pushNamed(context, '/home');
  }

  void _showMsg(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, style: const TextStyle(fontSize: 16)),
        backgroundColor: AppColors.pink,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Vincular pareja'),
      ),
      extendBodyBehindAppBar: true,
      body: RomanticBackground(
        isDark: isDark,
        imageLight: 'assets/images/welcome_light.jpg',
        imageDark: 'assets/images/welcome_dark.jpg',
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: SoftCard(
                isDark: isDark,
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite, size: 36, color: isDark ? AppColors.darkPink : AppColors.pink),
                        const SizedBox(width: 8),
                        Icon(Icons.link, size: 24, color: isDark ? Colors.white54 : AppColors.lavender),
                        const SizedBox(width: 8),
                        Icon(Icons.favorite, size: 36, color: isDark ? AppColors.darkPink : AppColors.pink),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Escribe el código de tu persona',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.darkText : AppColors.textDark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tu código: ${widget.myCode}',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white60 : AppColors.textSoft,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: _codeController,
                      decoration: const InputDecoration(
                        hintText: 'CÓDIGO',
                        prefixIcon: Icon(Icons.favorite_border),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22, letterSpacing: 4, fontWeight: FontWeight.bold),
                      textCapitalization: TextCapitalization.characters,
                    ),
                    const SizedBox(height: 32),
                    GradientButton(
                      text: 'Vincular',
                      icon: Icons.favorite,
                      isDark: isDark,
                      onPressed: _isLinking ? null : _linkPartner,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String userName;
  final String myCode;
  final String? partnerCode;

  const HomeScreen({
    super.key,
    required this.userName,
    required this.myCode,
    this.partnerCode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool _hasAlarm = false;
  String? _lastAlarmName;
  String? _lastMessage;
  int _myLoveCount = 0;
  int _partnerLoveCount = 0;
  StreamSubscription<DocumentSnapshot>? _mySubscription;
  StreamSubscription<DocumentSnapshot>? _partnerSubscription;
  late final AnimationController _heartController;

  // Mensajes predeterminados
  static const List<String> _messages = [
    'Te extraño 💗',
    'Pienso en ti ✨',
    'Te amo 💕',
    'Solo tú 🌸',
    'Eres mi persona favorita 💖',
    'Me haces feliz 🌹',
  ];

  String? _selectedMessage;
  final TextEditingController _customMessageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _escucharMisDatos();
    _escucharAlarma();
  }

  void _escucharMisDatos() {
    if (widget.partnerCode == null) return;
    final db = FirebaseFirestore.instance;
    _mySubscription = db.collection('users').doc(widget.myCode).snapshots().listen((snapshot) {
      if (!snapshot.exists) return;
      final data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        _myLoveCount = data['totalLoveCount'] ?? 0;
      });
    });
  }

  void _escucharAlarma() {
    if (widget.partnerCode == null) return;
    final db = FirebaseFirestore.instance;
    _partnerSubscription = db.collection('users').doc(widget.partnerCode).snapshots().listen((snapshot) {
      if (!snapshot.exists) return;
      final data = snapshot.data() as Map<String, dynamic>;
      final alarmTime = data['alarmAt'];
      final partnerName = data['name'] ?? 'Tu persona';
      final partnerMsg = data['lastMessage'];
      setState(() {
        _partnerLoveCount = data['totalLoveCount'] ?? 0;
      });
      if (alarmTime != null && mounted) {
        setState(() {
          _hasAlarm = true;
          _lastAlarmName = partnerName;
          _lastMessage = partnerMsg;
        });
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted) setState(() => _hasAlarm = false);
        });
      }
    });
  }

  Future<void> _enviarAmor() async {
    if (widget.partnerCode == null) return;
    final mensaje = _selectedMessage ??
        (_customMessageController.text.trim().isNotEmpty
            ? _customMessageController.text.trim()
            : 'Te pienso 💗');
    _heartController.forward(from: 0);
    final db = FirebaseFirestore.instance;
    await db.runTransaction((transaction) async {
      final myRef = db.collection('users').doc(widget.myCode);
      final partnerRef = db.collection('users').doc(widget.partnerCode);
      transaction.update(myRef, {'totalLoveCount': FieldValue.increment(1)});
      transaction.update(partnerRef, {
        'alarmAt': FieldValue.serverTimestamp(),
        'lastMessage': mensaje,
      });
    });
    setState(() {
      _selectedMessage = null;
      _customMessageController.clear();
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Enviado: "$mensaje" 💌', style: const TextStyle(fontSize: 16)),
          backgroundColor: AppColors.pink,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _mostrarMensajeSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '¿Qué quieres decir? 💌',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkText : AppColors.textDark,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _messages.map((msg) {
                  final seleccionado = _selectedMessage == msg;
                  return ChoiceChip(
                    label: Text(msg),
                    selected: seleccionado,
                    onSelected: (sel) {
                      setState(() => _selectedMessage = sel ? msg : null);
                      Navigator.pop(context);
                      Future.delayed(const Duration(milliseconds: 100), _mostrarMensajeSelector);
                    },
                    selectedColor: AppColors.pink,
                    labelStyle: TextStyle(
                      color: seleccionado ? Colors.white : (isDark ? Colors.white70 : AppColors.textSoft),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _customMessageController,
                decoration: const InputDecoration(
                  hintText: 'O escribe algo tú...',
                  prefixIcon: Icon(Icons.edit),
                ),
                maxLength: 30,
              ),
              const SizedBox(height: 20),
              GradientButton(
                text: 'Enviar amor 💓',
                icon: Icons.favorite,
                isDark: isDark,
                onPressed: () {
                  Navigator.pop(context);
                  _enviarAmor();
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _mySubscription?.cancel();
    _partnerSubscription?.cancel();
    _heartController.dispose();
    _customMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final totalAmor = _myLoveCount + _partnerLoveCount;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Love Alarm'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Icon(Icons.favorite, color: AppColors.pink, size: 18),
                const SizedBox(width: 6),
                Text(
                  '$totalAmor',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.darkText : AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: RomanticBackground(
        isDark: isDark,
        imageLight: 'assets/images/home_light.jpg',
        imageDark: 'assets/images/home_dark.jpg',
        child: Stack(
          children: [
            SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hola, ${widget.userName}',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.darkText : AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.partnerCode != null
                            ? 'Tu persona está conectada 💞'
                            : 'Aún no tienes a nadie conectado',
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? Colors.white70 : AppColors.textSoft,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Contador de amor
                      SoftCard(
                        isDark: isDark,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        child: Column(
                          children: [
                            const Text('💞 Amor enviado', style: TextStyle(fontSize: 14)),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    const Text('Tú', style: TextStyle(fontSize: 12)),
                                    Text(
                                      '$_myLoveCount',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.pink,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('Total', style: TextStyle(fontSize: 12)),
                                    Text(
                                      '$totalAmor',
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: isDark ? AppColors.darkPink : AppColors.purple,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('Ella/Él', style: TextStyle(fontSize: 12)),
                                    Text(
                                      '$_partnerLoveCount',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.lavender,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: widget.partnerCode != null ? _mostrarMensajeSelector : null,
                        child: AnimatedBuilder(
                          animation: _heartController,
                          builder: (context, child) {
                            final scale = 1.0 + (_heartController.value * 0.3);
                            return Transform.scale(
                              scale: scale,
                              child: Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: isDark
                                        ? [const Color(0xFFFF6B8B), const Color(0xFFC44569)]
                                        : [AppColors.pink, AppColors.lavender],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: (isDark ? AppColors.darkPink : AppColors.pink).withOpacity(0.5),
                                      blurRadius: 40,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Icon(Icons.favorite, size: 80, color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        widget.partnerCode != null
                            ? 'Toca el corazón y dile algo 💌'
                            : 'Vincula a tu persona primero',
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? Colors.white70 : AppColors.textSoft,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_hasAlarm)
              Positioned.fill(
                child: Container(
                  color: Colors.black45,
                  child: Center(
                    child: _AlarmCard(
                      name: _lastAlarmName ?? 'Tu persona',
                      mensaje: _lastMessage,
                      isDark: isDark,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AlarmCard extends StatefulWidget {
  final String name;
  final String? mensaje;
  final bool isDark;

  const _AlarmCard({required this.name, this.mensaje, required this.isDark});

  @override
  State<_AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<_AlarmCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
      child: Container(
        padding: const EdgeInsets.all(40),
        margin: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: widget.isDark
                ? [const Color(0xFF2D2D44), const Color(0xFF1A1A2E)]
                : [Colors.white, const Color(0xFFFFF0F5)],
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: AppColors.pink.withOpacity(0.5),
              blurRadius: 40,
              spreadRadius: 5,
            ),
          ],
          border: Border.all(
            color: widget.isDark ? AppColors.darkPink : AppColors.pink,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PulsingHeart(isDark: widget.isDark),
            const SizedBox(height: 24),
            Text(
              '${widget.name} te dice:',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: widget.isDark ? AppColors.darkText : AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              widget.mensaje ?? 'Algo especial 💗',
              style: TextStyle(
                fontSize: 20,
                color: widget.isDark ? Colors.white70 : AppColors.textSoft,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _PulsingHeart extends StatefulWidget {
  final bool isDark;
  const _PulsingHeart({required this.isDark});

  @override
  State<_PulsingHeart> createState() => _PulsingHeartState();
}

class _PulsingHeartState extends State<_PulsingHeart> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = 1.0 + (_controller.value * 0.2);
        return Transform.scale(
          scale: scale,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: widget.isDark
                    ? [const Color(0xFFFF6B8B), const Color(0xFFC44569)]
                    : [AppColors.pink, AppColors.lavender],
              ),
              boxShadow: [
                BoxShadow(
                  color: (widget.isDark ? AppColors.darkPink : AppColors.pink).withOpacity(0.6),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(Icons.favorite, size: 50, color: Colors.white),
          ),
        );
      },
    );
  }
}