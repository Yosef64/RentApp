import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(routes: [
    GoRoute(
      name: "home",
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          name: "second",
          path: 'second',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: SecondPage(name: state.uri.queryParameters['name'] ?? 'unknown',),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // Change the opacity of the screen using a Curve based on the the animation's
                // value
                return FadeTransition(
                  opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
      ],
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      debugShowCheckedModeBanner: false,
      title: 'something',
      routerConfig: _router,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const Icon(Icons.menu, color: Colors.white),
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: "https://docs.flutter.dev/cookbook/img-files/effects/parallax/01-mount-rushmore.jpg",
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()), // Centered progress indicator
                errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)), // Centered error icon
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ElevatedButton(
                  onPressed: (){
                    String name = "Yoseph";
                    context.goNamed("second", queryParameters: {"name": name});
                  }, child: const Text("To another page")),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String name;

  const SecondPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome back $name"),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            context.goNamed("home");
          },
          child: const Text("This is second page"),
        ),
      ),
    );
  }
}
