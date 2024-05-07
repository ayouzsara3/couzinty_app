import 'package:couzinty/core/utils/app_styles.dart';
import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/features/profile/presentation/views/widgets/user_image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../core/utils/size_config.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
                  const UserImagePicker(),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sara Sara',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.styleBold22(context)
                            .copyWith(color: Colors.black87),
                      ),
                      Text(
                        'sara@gmail.com',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.styleMedium17(context)
                            .copyWith(fontSize: 19, color: Colors.black54),
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
                title: TextFormField(
                    // controller: _userNameController,
                    style: AppStyles.styleBold15(context),
                    onSaved: (value) {
                      // _entredUserName = value!;
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
                trailing: InkWell(
                  onTap: () {},
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
                  onTap: () {},
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
                  onTap: () {},
                  child: const Icon(
                    Icons.keyboard_arrow_right,
                    color: kLightBlue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
