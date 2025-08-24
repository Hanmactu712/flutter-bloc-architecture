import 'package:app_auth/app_auth.dart';
import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture_template/src/common/common.dart';
import 'package:flutter_bloc_architecture_template/src/pages/login/login_page.dart';

class UserInfo extends StatelessWidget {
  final double avatarSize;

  const UserInfo({super.key, this.avatarSize = 64});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.routeToPage(LoginPage.routeItem, clearHistory: true);
        }
      },
      builder: (context, state) {
        if (state is Authenticated) {
          return ResponsiveWidget(
            compactScreen: Row(
              spacing: 8,
              children: [
                state.user.avatarUrl != null
                    ? CircleAvatar(
                      radius: avatarSize,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(64),
                        child: NetworkImageOrDefault.build(
                          context,
                          state.user.avatarUrl != null && state.user.avatarUrl!.isNotEmpty ? state.user.avatarUrl : Resources.defaultImage,
                          fit: BoxFit.cover,
                          errorWidget: Icon(AppIcons.close),
                        ),
                      ),
                    )
                    : const Icon(Icons.person),
                //logout icon
                IconButton(
                  icon: const Icon(Icons.logout),
                  iconSize: 22,
                  onPressed: () {
                    context.read<AuthCubit>().logout();
                  },
                ),
              ],
            ),
            mediumScreen: Row(
              spacing: 8.0,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(text: state.user.userName, style: context.labelMedium!.copyWith(fontWeight: FontWeight.bold)),
                    AppText(text: state.user.email, style: context.labelSmall!.copyWith(color: Theme.of(context).colorScheme.onSurface)),
                  ],
                ),
                state.user.avatarUrl != null
                    ? CircleAvatar(
                      radius: avatarSize,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(64),
                        child: NetworkImageOrDefault.build(
                          context,
                          state.user.avatarUrl != null && state.user.avatarUrl!.isNotEmpty ? state.user.avatarUrl : Resources.defaultImage,
                          fit: BoxFit.cover,
                          errorWidget: Icon(AppIcons.close),
                        ),
                      ),
                    )
                    : const Icon(Icons.person),
                //logout icon
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    context.read<AuthCubit>().logout();
                  },
                ),
              ],
            ),
          );
        }
        if (state is AuthInitial) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return Container();
      },
    );
  }
}
