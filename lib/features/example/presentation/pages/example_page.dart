import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_ml_kit_test_app/features/example/bloc/example_bloc.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example')),
      body: BlocBuilder<ExampleBloc, ExampleState>(
        builder: (BuildContext context, ExampleState state) {
          return switch (state) {
            ExampleInitial() || ExampleLoadInProgress() => const Center(
                child: CircularProgressIndicator(),
              ),
            ExampleLoadSuccess(:final post) => Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    Text(
                      post.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(post.body),
                  ],
                ),
              ),
            ExampleLoadFailure(:final message) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          };
        },
      ),
    );
  }
}
