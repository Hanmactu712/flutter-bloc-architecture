import 'package:app_auth/src/biz_logic/auth/cubit/auth_cubit.dart';
import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoggedUser extends StatelessWidget {
  const LoggedUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  // backgroundColor: Theme.of(context).colorScheme.primary,
                  child: state.user.avatarUrl != null ? FittedBox(child: NetworkImageOrDefault.build(context, state.user.avatarUrl)) : const Icon(Icons.person),
                ),
                const SizedBox(width: 10),
                Text("Hello, ${state.user.userName.isNotEmpty ? state.user.userName : "User"}"),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    context.read<AuthCubit>().logout();
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
          );
        }
        if (state is AuthInitial) {
          return Container(padding: const EdgeInsets.all(10), child: const Center(child: CircularProgressIndicator.adaptive()));
        }
        return const SizedBox();
      },
    );
  }
}
