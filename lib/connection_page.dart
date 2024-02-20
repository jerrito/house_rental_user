import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final authBloc = locator<AuthenticationBloc>();
  @override
  Widget build(BuildContext context) {
    authBloc.add(const GetCacheDataEvent());
    return Scaffold(
        body: BlocConsumer(
      bloc: authBloc,
      listener: (context, state) {
        if (state is GetCacheDataLoaded) {
           if (state.user.uid == null) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) {
            //     return SigninPage(
            //       // isLogin: true,
            //     );
            //   }),
            // );
            context.goNamed("signin");
          } else {
            Map<String, dynamic> params = {
              "phone_number": state.user.phoneNumber,
              "uid": state.user.uid,
            };
            authBloc.add(
              AddIdEvent(
                params: params,
              ),
            );
          }
        }

        if (state is AddIdError) {
          if (state.errorMessage == "No internet connection") {
            context.goNamed("noInternet");
          } else {
            context.goNamed("signin");
          }
        }

        if (state is AddIdLoaded) {
          context.goNamed("homePage");
        }
        if (state is GetCacheDataError) {
          debugPrint(state.errorMessage);

          context.goNamed("landing");

          // context.goNamed("phoneNumber", );
        }
      },
      builder: (context, state) {
        return const SizedBox();
      },
    ));
  }
}
