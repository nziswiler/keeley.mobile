import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp.material(
      debugShowCheckedModeBanner: false,
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: const ShadZincColorScheme.light(),
      ),
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const ShadZincColorScheme.dark(),
        // Example of custom font family
        // textTheme: ShadTextTheme(family: 'UbuntuMono'),
      ),
      home: MyHomePage(),
    );
  }
}

const frameworks = {
  'next': 'Next.js',
  'react': 'React',
  'astro': 'Astro',
  'nuxt': 'Nuxt.js',
};

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShadCard(
      width: 350,
      title: Text(
        'Create project',
      ),
      description: const Text('Deploy your new project in one-click.'),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShadButton.outline(
            child: const Text('Cancel'),
            onPressed: () {},
          ),
          ShadButton(
            child: const Text('Deploy'),
            onPressed: () {},
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ShadInputFormField(
              id: 'username',
              label: const Text('Username'),
              placeholder: const Text('Enter your username'),
              description: const Text('This is your public display name.'),
              validator: (v) {
                if (v.length < 2) {
                  return 'Username must be at least 2 characters.';
                }
                return null;
              },
            ),
            const SizedBox(height: 6),
            const Text('Framework'),
            ShadSelect<String>(
              placeholder: const Text('Select'),
              options: frameworks.entries
                  .map((e) => ShadOption(value: e.key, child: Text(e.value)))
                  .toList(),
              selectedOptionBuilder: (context, value) {
                return Text(frameworks[value]!);
              },
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
