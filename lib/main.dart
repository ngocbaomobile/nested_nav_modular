import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

class AppWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/page1');

    return MaterialApp.router(
      title: 'My Smart App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      // routerConfig: Modular.routerConfig,
    );
  }
}

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [];
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: ((context, args) => HomePage()), children: [
          ChildRoute('/page1',
              child: (context, args) =>
                  InternalPage(title: 'page 1', color: Colors.red)),
          ChildRoute('/page2',
              child: (context, args) =>
                  InternalPage(title: 'page 2', color: Colors.amber)),
          ChildRoute('/page3',
              child: (context, args) =>
                  InternalPage(title: 'page 3', color: Colors.green)),
        ]),
        ChildRoute('/detail', child: (context, args) => DetailScreen()),
      ];
}

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: RouterOutlet(),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                child: Container(
                  color: Colors.red,
                  child: Text('Page 1'),
                ),
                onTap: () => Modular.to.navigate('/page1'),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                child: Text('Page 2'),
                onTap: () => Modular.to.navigate('/page2'),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                child: Text('Page 3'),
                onTap: () => Modular.to.navigate('/page3'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InternalPage extends StatelessWidget {
  final String title;
  final Color color;
  const InternalPage({Key? key, required this.title, required this.color})
      : super(key: key);

  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          TextButton(
              onPressed: () {
                Modular.to.pushNamed('/detail');
              },
              child: Text('open other page'))
        ],
      )),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Widget'),
      ),
      body: Container(
        child: Center(
          child: Text('Hello, World!'),
        ),
      ),
    );
  }
}
