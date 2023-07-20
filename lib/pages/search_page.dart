import 'package:diet_penyakit/blocs/search_block.dart';
import 'package:diet_penyakit/pages/snacbar.dart';
import 'package:diet_penyakit/utils/empty.dart';
import 'package:diet_penyakit/utils/list_card.dart';
import 'package:diet_penyakit/utils/loading_cards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    Future.delayed(Duration())
        .then((value) => context.read<SearchBloc>().saerchInitialize());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: 56,
            width: w,
            decoration: BoxDecoration(color: Colors.white),
            child: TextFormField(
              autofocus: true,
              controller: context.watch<SearchBloc>().textfieldCtrl,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Cari Menu Resep",
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800]),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 15),
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_backspace,
                      color: Colors.grey[800],
                    ),
                    color: Colors.grey[800],
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey[800],
                    size: 25,
                  ),
                  onPressed: () {
                    context.read<SearchBloc>().saerchInitialize();
                  },
                ),
              ),
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (value) {
                if (value == '') {
                  openSnacbar(context, 'masukan nama resep yang dicari!');
                } else {
                  context.read<SearchBloc>().setSearchText(value);
                  context.read<SearchBloc>().addToSearchList(value);
                }
              },
            ),
          ),
          Container(
            height: 1,
            child: Divider(
              color: Colors.grey[300],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, bottom: 5),
            child: Text(
              context.watch<SearchBloc>().searchStarted == false
                  ? 'Riwayat Pencarian'
                  : 'Hasil Pencarian yang cocok',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
          context.watch<SearchBloc>().searchStarted == false
              ? SuggestionsUI()
              : AfterSearchUI()
        ],
      )),
    );
  }
}

class SuggestionsUI extends StatelessWidget {
  const SuggestionsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sb = context.watch<SearchBloc>();
    return Expanded(
      child: sb.recentSearchData.isEmpty
          ? EmptyPage(
              icon: Icons.search,
              message: 'Riwayat Pencarian',
              message1: "Tidak Ditemukan Riwayat Pencarian",
            )
          : ListView.builder(
              itemCount: sb.recentSearchData.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    sb.recentSearchData[index],
                    style: TextStyle(fontSize: 17),
                  ),
                  leading: Icon(CupertinoIcons.time_solid),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      context
                          .read<SearchBloc>()
                          .removeFromSearchList(sb.recentSearchData[index]);
                    },
                  ),
                  onTap: () {
                    context
                        .read<SearchBloc>()
                        .setSearchText(sb.recentSearchData[index]);
                  },
                );
              },
            ),
    );
  }
}

class AfterSearchUI extends StatelessWidget {
  const AfterSearchUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: context.watch<SearchBloc>().getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0)
              return EmptyPage(
                icon: Icons.search,
                message: 'Menu Tidak Ditemukan',
                message1: "coba cari menu yang lain",
              );
            else
              return ListView.separated(
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: 5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ListCard(
                    d: snapshot.data[index],
                    tag: "search$index",
                    color: Colors.white,
                  );
                },
              );
          }
          return ListView.separated(
            padding: EdgeInsets.all(15),
            itemCount: 5,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 10,
            ),
            itemBuilder: (BuildContext context, int index) {
              return LoadingCard(height: 200);
            },
          );
        },
      ),
    );
  }
}
