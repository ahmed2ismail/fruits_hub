import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/features/auth/presentation/manager/cubits/signin_cubit/signin_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/social_login_button.dart';
import 'package:fruits_hub/generated/l10n.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialLoginButton(
          text: S.of(context).loginWithGoogleText,
          iconPath: AppAssets.imagesGoogleIcon,
          onPressed: () {
            context.read<SigninCubit>().signInWithGoogle();
          },
        ),
        const SizedBox(height: 16),
        SocialLoginButton(
          text: S.of(context).loginWithAppleText,
          iconPath: AppAssets.imagesAppleIcon,
          onPressed: () {
            context.read<SigninCubit>().signInWithApple();
          },
        ),
        const SizedBox(height: 16),
        SocialLoginButton(
          text: S.of(context).loginWithFacebookText,
          iconPath: AppAssets.imagesFacebookIcon,
          onPressed: () {
            context.read<SigninCubit>().signInWithFacebook();
          },
        ),
      ],
    );
  }
}
