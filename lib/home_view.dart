import 'package:drop_app/image_tile.dart';
import 'package:flutter/material.dart';
import 'package:native_drag_n_drop/native_drag_n_drop.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<DropData> receivedData = [];
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Drag and Drop Example')),
        body: NativeDropView(
          allowedDropDataTypes: const [DropDataType.image],
          receiveNonAllowedItems: false,
          loading: (loading) {
            print('loading');
            setState(() {
              loading = loading;
            });
          },
          dataReceived: (data) {
            setState(() {
              receivedData.addAll(data);
            });
          },
          child: loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: receivedData.length,
                  itemBuilder: (context, index) {
                    var data = receivedData[index];

                    if (data.type == DropDataType.image) {
                      return ImageTile(
                        dropData: data,
                      );
                    }

                    return ListTile(
                      title: Text(data.dropFile?.path ?? 'Unknown path'),
                      subtitle: Text(data.type.toString()),
                    );
                  }),
        ));
  }
}
