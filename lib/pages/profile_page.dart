import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_with_firebase/blocs/auth/auth_bloc.dart';
import 'package:news_app_with_firebase/blocs/profile/profile_bloc.dart';
import 'package:news_app_with_firebase/utils/user_error_dialog.dart';

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
            return const Text('Walang laman');
          } else if (state.profileStatus == ProfileStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
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
          return Stack(
            children: [
              _backgroundImage(state.user.profileImage),
              _userInfoContainer(context),
              _userAvatarImage(
                context,
                state.user.profileImage,
              ),
              _userInfo(
                context,
                state.user.name,
                state.user.email,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _backgroundImage(String image) {
    return SizedBox(
      child: Image.network(
        image.isNotEmpty ? image : 'https://picsum.photos/300',
        width: double.infinity,
        fit: BoxFit.fill,
        color: Colors.grey.withOpacity(0.7),
        colorBlendMode: BlendMode.modulate,
      ),
    );
  }

  Widget _userInfoContainer(BuildContext context) {
    return Positioned(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(35),
          ),
          child: Container(
            color: Colors.white,
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height / 1.7,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 100,
                left: 25,
                right: 25,
              ),
              child: Column(
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
                      const Text('Theme'),
                      Switch(
                        value: (true),
                        onChanged: (_) {},
                        activeColor: Colors.amber,
                      ),
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
                        activeColor: Colors.amber,
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Muspi Merol 2'),
                      Switch(
                        value: (true),
                        onChanged: (_) {},
                        activeColor: Colors.amber,
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
              Text(name),
              Text(email),
            ],
          ),
        ),
      ),
    );
  }
}
