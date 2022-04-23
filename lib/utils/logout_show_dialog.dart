import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/blocs.dart';
import 'package:news_app_with_firebase/constants/constants.dart';

Future logoutShowDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Are you sure?',
          style: Theme.of(context).textTheme.headline5,
        ),
        content: Text(
          'Do you really want to logout?',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'NO',
              style: Theme.of(context).textTheme.bodyText2!.merge(
                    TextStyle(
                      color: themeLightColor2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(SignoutRequestedEvent());
            },
            child: Text(
              'YES',
              style: Theme.of(context).textTheme.bodyText2!.merge(
                    TextStyle(
                      color: themeLightColor2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            ),
          ),
        ],
      );
    },
  );
}
