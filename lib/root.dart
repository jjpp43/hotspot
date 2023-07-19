import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/blocs/auth/auth_bloc.dart';
import 'src/screens/navigation_bar.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    void _authenticateWithGoogle(context) {
      BlocProvider.of<AuthBloc>(context).add(
        GoogleSignInRequested(),
      );
    }

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigationBarScreen(),
            ),
          );
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
        if (state is UnAuthenticated) {}
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UnAuthenticated) {
            return Center(
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  ElevatedButton(
                    onPressed: () {
                      _authenticateWithGoogle(context);
                    },
                    child: const Text('Login with Google'),
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  _authenticateWithGoogle(context);
                },
                child: const Text('Login with Google'),
              ),
            ],
          );
        },
      ),
    );
  }
}
