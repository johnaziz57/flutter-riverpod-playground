import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData.dark(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}

const names = [
  'Alice',
  'Bob',
  'Charlie',
  'Davod',
  'Eve',
  'Fred',
  "Ginny",
  'Harriet',
  'Ileana',
  'Joseph',
  'Kincaid',
  'Larry',
];

final ticketProvider = StreamProvider(
  (_) => Stream.periodic(
    const Duration(seconds: 1),
    (i) => i + 1,
  ),
);

final namesProvider = StreamProvider((ref) {
  return ref.watch(ticketProvider.future).asStream().map(
        (count) => names.getRange(0, count),
      );
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Weather")),
      body: names.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) =>  ListTile(
            title: Text(data.elementAt(index) ?? ""),
          ),
        ),
        error: (_, __) => const Text("Reached end of the list"),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
