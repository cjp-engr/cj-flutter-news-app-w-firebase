import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          _backgroundImage(context),
          _userInfoContainer(context),
          _userAvatarImage(context),
          _userInfo(context),
        ],
      ),
    );
  }

  Widget _backgroundImage(context) {
    return SizedBox(
      child: Image.network(
        'https://picsum.photos/300',
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

  Widget _userAvatarImage(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height / 1.7 - 75,
      left: 10,
      child: Align(
        child: Container(
          height: 150,
          width: 150,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage('https://picsum.photos/300'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  Widget _userInfo(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height / 1.7 - 165,
      left: MediaQuery.of(context).size.width / 2 - 50,
      child: Align(
        child: SizedBox(
          height: 150,
          width: 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Carmen Joy Palsario'),
              Text('email@gmail.com'),
            ],
          ),
        ),
      ),
    );
  }
}
