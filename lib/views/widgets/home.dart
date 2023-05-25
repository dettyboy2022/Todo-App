import 'package:flutter/material.dart';
//

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isClicked = false;
  List tasks = [];
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.purple[100],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const Icon(Icons.menu),
            title: const Text('S L I V E R A P P'),
            expandedHeight: 200,
            backgroundColor: Colors.blue[100],
          ),
          SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SearchBar(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      hintText: 'Search....',
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder()),
                      elevation: MaterialStatePropertyAll(0),
                      side: MaterialStatePropertyAll(BorderSide()),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            color: Colors.blue[200],
                            child: ListTile(
                              leading: Checkbox(
                                  value: isClicked,
                                  onChanged: (value) {
                                    setState(() {
                                      isClicked = value!;
                                    });
                                  }),
                              title: Text(tasks[index]),
                              trailing: IconButton(
                                onPressed: () {
                                  tasks.removeAt(index);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          );
                        })
                  ],
                )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
              context: context,
              builder: (context) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Add New Task'),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  minimumSize: const Size(150, 50)),
                              onPressed: () {
                                setState(() {
                                  tasks.add(controller.text);
                                  Navigator.pop(context);
                                  controller.clear();
                                });
                              },
                              child: const Text('Add')),
                        ],
                      )
                    ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
