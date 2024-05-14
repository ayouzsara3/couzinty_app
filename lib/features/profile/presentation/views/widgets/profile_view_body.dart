import 'dart:io';

import 'package:couzinty/core/utils/app_router.dart';
import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/core/utils/functions/setup_service_locator.dart';
import 'package:couzinty/features/auth/data/models/user_model.dart';
import 'package:couzinty/features/auth/presentation/viewmodel/signin_cubit/signin_cubit.dart';
import 'package:couzinty/features/profile/data/repos/profile_repo_impl.dart';
import 'package:couzinty/features/profile/presentation/views/viewmodel/user_cubit/user_cubit.dart';
import 'package:couzinty/features/profile/presentation/views/widgets/user_image_picker.dart';
import 'package:couzinty/features/upload/presentation/views/functions/show_pop_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/size_config.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  final _formKey = GlobalKey<FormState>();
  var _entredUserName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserModel>(
        builder: (context, user) {
          return Form(
            child: Column(
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.4,
                        alignment: Alignment.topCenter,
                        image: AssetImage('assets/images/home_background.png'),
                        fit: BoxFit.fitWidth),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UserImagePicker(
                        onPickImage: (File pickedImage) async {
                          EasyLoading.show(
                              status: 'chargement..', dismissOnTap: true);
                          final image = await getIt<ProfileRepoImpl>()
                              .updatePhoto(pickedImage);

                          context.read<UserCubit>().updateUser(image: image);
                          EasyLoading.showSuccess('La photo a été modifiée');
                          EasyLoading.dismiss();
                        },
                        image: user.image,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.userName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.styleBold22(context)
                                .copyWith(color: Colors.black87),
                          ),
                          Text(
                            user.email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.styleMedium15(context)
                                .copyWith(color: Colors.black54),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.defaultSize! * 3),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(141, 158, 158, 158),
                          width: 1.0), // Add underline border
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    leading: const Icon(
                      CupertinoIcons.person,
                      color: kLightBlue,
                    ),
                    title: Form(
                      key: _formKey,
                      child: TextFormField(
                          // controller: _userNameController,
                          style: AppStyles.styleBold15(context),
                          onSaved: (value) {
                            _entredUserName = value!;
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value.trim().length > 10) {
                              return 'Username is too long';
                            }
                            if (value.trim().length < 4) {
                              return 'Username must be at least 4 characters long';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Nom d\'utilisateur',
                            contentPadding: EdgeInsets.zero,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          )),
                    ),
                    trailing: InkWell(
                      onTap: () async {
                        final isValid = _formKey.currentState!.validate();

                        if (!isValid) {
                          return;
                        }

                        _formKey.currentState!.save();
                        EasyLoading.show(
                            status: 'chargement..', dismissOnTap: true);
                        final userName = await getIt<ProfileRepoImpl>()
                            .updateUserName(_entredUserName);

                        context
                            .read<UserCubit>()
                            .updateUser(userName: userName);

                        EasyLoading.showSuccess(
                            'Le nom d\'utilisateur a été modifié');
                        EasyLoading.dismiss();
                      },
                      child: const Icon(
                        Icons.keyboard_arrow_right,
                        color: kLightBlue,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.defaultSize! * 1.5),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(141, 158, 158, 158),
                          width: 1.0), // Add underline border
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    leading: const Icon(
                      CupertinoIcons.lock,
                      color: kLightBlue,
                    ),
                    title: const Text(
                      'Changer le mot de passe',
                    ),
                    trailing: InkWell(
                      onTap: () async {
                        EasyLoading.show(
                            status: 'chargement..', dismissOnTap: true);
                        await getIt<ProfileRepoImpl>()
                            .forgetPassword(user.email);
                        EasyLoading.showSuccess('L\'e-mail a été envoyé');
                        EasyLoading.dismiss();
                      },
                      child: const Icon(
                        Icons.keyboard_arrow_right,
                        color: kLightBlue,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.defaultSize! * 1.5),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(141, 158, 158, 158),
                          width: 1.0), // Add underline border
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.logout_outlined,
                      color: kLightBlue,
                    ),
                    title: const Text('Se déconnecter'),
                    trailing: InkWell(
                      onTap: () async {
                        await context.read<SigninCubit>().logout();
                        GoRouter.of(context)
                            .pushReplacement(AppRouter.kSignInView);
                      },
                      child: const Icon(
                        Icons.keyboard_arrow_right,
                        color: kLightBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
