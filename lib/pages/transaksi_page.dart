import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/transaksi_bloc.dart';
import '../configs/Colors.dart';
import '../widgets/transaksi_list.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({Key? key}) : super(key: key);

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 0)).then((_) {
      context.read<TransaksiBloc>().setLoading(true);
      context.read<TransaksiBloc>().getData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Order',
          style: TextStyle(color: textTitleColors),
        ),
      ),
      // backgroundColor: Color.fromARGB(255, 28, 22, 22),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<TransaksiBloc>().setLoading(true);
            context.read<TransaksiBloc>().getData();
          },
          child: SingleChildScrollView(
            child: Column(
              children: const [
                TransaksiList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool get wantKeepAlive => true;
}
