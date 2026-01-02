import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/para_details_screen/bloc/para_details_screen_bloc.dart';
import 'package:deen/features/para_details_screen/bloc/para_details_screen_event.dart';
import 'package:deen/features/para_details_screen/presentation/widgets/para_details_screen_body.dart';

class ParaDetailsScreenScreen extends StatelessWidget {
  const ParaDetailsScreenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paraNumber = ModalRoute.of(context)!.settings.arguments as int;

    return BlocProvider(
      create: (context) =>
          ParaDetailsScreenBloc()..add(LoadParaDetailsScreenData(paraNumber)),
      child: const Scaffold(body: SafeArea(child: ParaDetailsScreenBody())),
    );
  }
}
