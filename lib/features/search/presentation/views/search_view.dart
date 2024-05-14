import 'package:couzinty/core/utils/functions/setup_service_locator.dart';
import 'package:couzinty/features/search/data/repos/search_repo_impl.dart';
import 'package:couzinty/features/search/presentation/viewmodel/cubit/search_cubit.dart';
import 'package:couzinty/features/search/presentation/views/widgets/search_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(getIt<SearchRepoImpl>()),
      child: const SafeArea(
          child: Scaffold(
        body: SearchViewBody(),
      )),
    );
  }
}
