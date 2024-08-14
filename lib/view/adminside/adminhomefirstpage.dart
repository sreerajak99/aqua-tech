import 'package:aquatech/view/adminside/adminhomescreen.dart';
import 'package:aquatech/view/meterreader/component/home.dart';
import 'package:flutter/material.dart';

class AdminhomeFirstPage extends StatelessWidget {
  const AdminhomeFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(leading: Text(''),
            backgroundColor: Colors.white,
            title: Text(
              '     Aqua Tech',
              style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.lightBlueAccent,
                child: Center(
                    child: Text(
                  'Aqua Tech',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10),
              ImageSwitcher(),
              ImageSwitcher(),
              // Add more widgets here as needed
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AdminHome(),
          ));
        },
        child: Icon(Icons.arrow_forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
