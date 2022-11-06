import 'package:flutter/material.dart';
import 'package:calculator_final/models/soap_provider.dart';
import 'package:provider/provider.dart';

class SoapTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider  = Provider.of<Soap_Provider>(context);
    return FutureBuilder(
      future: provider.loadData(),
      builder: (context, data) {
        if(provider.data.isNotEmpty) {
          return const Center(child: CircularProgressIndicator(),);
        } else {
          return GridView.builder(
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.5,
              ),
              itemCount: provider.data.length,
              itemBuilder: (context, index) {
                return GridTile(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/index',
                          arguments: provider.data[index]);
                      },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(provider.data[index]),
                    ),
                  ),
                );
              });
        }
      },
    );
  }
}