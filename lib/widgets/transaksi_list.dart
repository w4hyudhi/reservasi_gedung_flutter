import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:diet_penyakit/blocs/transaksi_bloc.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaksi_model.dart';
import '../pages/bisnis_detail.dart';
import '../pages/transaksi_detail.dart';
import '../utils/loading_cards.dart';
import '../utils/next_screen.dart';

class TransaksiList extends StatelessWidget {
  const TransaksiList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TransaksiBloc tb = Provider.of<TransaksiBloc>(context);
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: tb.order?.dataTransaksi.isNullOrEmpty() ?? true
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: EmptyWidget(
                      image: null,
                      packageImage: PackageImage.Image_3,
                      title: 'kosong',
                      subTitle: 'anda tidak memiliki riwayat booking',
                      titleTextStyle: const TextStyle(
                        fontSize: 22,
                        color: Color(0xff9da9c7),
                        fontWeight: FontWeight.w500,
                      ),
                      subtitleTextStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xffabb8d6),
                      ),
                      // Uncomment below statement to hide background animation
                      // hideBackgroundAnimation: true,
                    ),
                  ),
                )
              : ListView.separated(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 30, left: 15, right: 15),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: tb.isLoading != true
                      ? tb.order!.dataTransaksi!.length
                      : 5,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (tb.isLoading == true) return LoadingCard(height: 200);
                    return _ListItem(order: tb.order!.dataTransaksi![index]);
                  },
                ),
        )
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  final DataTransaksi order;
  const _ListItem({Key? key, required this.order}) : super(key: key);

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.yellow;
      case 'success':
        return Colors.green;
      case 'accept':
        return Colors.blue;
      case 'reject':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.all(10),
        child: ListTile(
          title: Text(order.gedung?.nama ?? ''),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('No Ref: ${order.noRef}'),
              Text('Acara: ${order.paket!.nama!}'),
              Text('Tanggal: ${order.dateIn}'),
            ],
          ),
          trailing: Container(
            decoration: BoxDecoration(
              color: _getStatusColor(order.status!),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              order.status.toString().toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      onTap: () => nextScreen(context, DetailTransaksi(data: order)),
    );
  }
}
