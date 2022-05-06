import 'package:flutter/material.dart';
import 'package:toordor/View/Widget/AppBarr.dart';
import 'package:toordor/View/Widget/TextForm.dart';

import '../../Controller/Controller.dart';

class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);
//String? token;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar:AppBar(
          backgroundColor: Colors.blue,
          leading: Container(
            child: const SizedBox(width: 300),
            height: 100,
            width: 150,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(
                    'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png'),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {},
            ),
            PopupMenuButton(
                itemBuilder: (context) => Controller.listPage
                    .map((e) => PopupMenuItem(
                  child: ListTile(trailing: Text(e.title)),
                  onTap: () {
                    int i = Controller.listPage.indexOf(e);
                    setState(() => indexPage = i);
                  },
                ))
                    .toList())
          ],
          title: TextForm(
            hint: 'البحث',
            widget: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            keyBoardType: TextInputType.text,
          )),
      body: Controller.listPage[indexPage].page,
    );
  }
}
