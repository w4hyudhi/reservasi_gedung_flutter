import 'package:diet_penyakit/blocs/bisnis_bloc.dart';
import 'package:diet_penyakit/widgets/resep_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../configs/Colors.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 0)).then((_) {
      context.read<BisnisBloc>().setLoading(true);
      context.read<BisnisBloc>().getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Aula',
          style: TextStyle(color: textTitleColors),
        ),
      ),
      // backgroundColor: Color.fromARGB(255, 28, 22, 22),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<BisnisBloc>().setLoading(true);
            context.read<BisnisBloc>().getData();
          },
          child: SingleChildScrollView(
            child: Column(
              children: const [
                ResepList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool get wantKeepAlive => true;
}
