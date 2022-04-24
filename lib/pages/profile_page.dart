import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import 'package:news_app_with_firebase/constants/constants.dart';
import 'package:news_app_with_firebase/utils/logout_show_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    _getProfile();
    super.initState();
  }

  void _getProfile() {
    final String uid = context.read<AuthBloc>().state.user!.uid;

    context.read<ProfileBloc>().add(FetchInitialDetailsEvent(uid: uid));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.profileStatus == ProfileStatus.initial) {
            return _profileScreen(
              '...',
              '...',
              'https://picsum.photos/300',
            );
          } else if (state.profileStatus == ProfileStatus.loading) {
            return _profileScreen(
              'Loading name...',
              'Loading email...',
              'https://picsum.photos/300',
            );
          } else if (state.profileStatus == ProfileStatus.error) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/error.png',
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 20.0),
                  const Text(
                    'Ooops!\nTry again',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          }
          return _profileScreen(
            state.user.name,
            state.user.email,
            state.user.profileImage,
          );
        },
      ),
    );
  }

  Widget _profileScreen(String name, String email, String profileImage) {
    return Stack(
      children: [
        _backgroundImage(profileImage),
        _userInfoContainer(context),
        _userAvatarImage(
          context,
          profileImage,
        ),
        _userInfo(
          context,
          name,
          email,
        ),
      ],
    );
  }

  Widget _backgroundImage(String image) {
    return SizedBox(
      child: Image.network(
        image,
        width: double.infinity,
        fit: BoxFit.fill,
        color: Colors.grey.withOpacity(0.7),
        colorBlendMode: BlendMode.modulate,
      ),
    );
  }

  Widget _userInfoContainer(BuildContext context) {
    final themeSwitch = context.watch<ThemeBloc>().state.isThemeLightSwitch;
    return Positioned(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(35),
          ),
          child: Container(
            color: themeSwitch ? themeLightColor1 : themeLightColor4,
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height / 1.7,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 100,
                left: 25,
                right: 25,
              ),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile Settings',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Dark'),
                          Switch(
                            value: (themeSwitch),
                            onChanged: (_) {
                              context.read<ThemeBloc>().add(
                                    SwitchThemeEvent(isSwitch: !themeSwitch),
                                  );
                            },
                          ),
                          const Text('Light'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Lorem Ipsum 1'),
                          Switch(
                            value: (true),
                            onChanged: (_) {},
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Muspi Merol 2'),
                          Switch(
                            value: (false),
                            onChanged: (_) {},
                          ),
                        ],
                      ),
                      const Divider(
                        height: 40,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          logoutShowDialog(context);
                        },
                        child: const Text('Log out'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _userAvatarImage(BuildContext context, String image) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height / 1.7 - 75,
      left: 10,
      child: Align(
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                image.isNotEmpty ? image : 'https://picsum.photos/300',
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  Widget _userInfo(BuildContext context, String name, String email) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height / 1.7 - 165,
      left: MediaQuery.of(context).size.width / 2 - 50,
      child: Align(
        child: SizedBox(
          height: 150,
          width: 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .merge(const TextStyle(fontWeight: FontWeight.w600)),
              ),
              Text(email),
            ],
          ),
        ),
      ),
    );
  }
}
