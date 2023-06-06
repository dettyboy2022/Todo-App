import 'package:flutter/material.dart';
import 'package:todo_app/local%20storage/localstorage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> tasks = [];
  save() {
    LocalStorageMethods.saveTask([]);
  }

  // String? myString;

  // save() async {
  //   await LocalStorageMethods.saveTask('Daily Task');
  // }

  // get() async {
  //   myString = await LocalStorageMethods.getTask();
  //   setState(() {});
  // }

  bool isClicked = false;

  TextEditingController controller = TextEditingController();
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      drawer: const Drawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                'T O D O  A P P',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
              ),
              background: Image.network(
                  'https://www.computerhope.com/jargon/t/task.jpg'),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBar(
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    hintText: 'Search....',
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    elevation: const MaterialStatePropertyAll(0),
                    side: const MaterialStatePropertyAll(
                        BorderSide(style: BorderStyle.none)),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Today"s Task :',
                    style: TextStyle(fontSize: 18),
                  ),
                  // Text(myString ?? 'show this'),
                  // ElevatedButton(onPressed: get, child: const Text('GET')),
                  // ElevatedButton(onPressed: save, child: const Text('SAVE')),
                  ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      primary: false,
                      shrinkWrap: true,
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        var editTasks = tasks[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              tileColor: Colors.blue[200],
                              leading: Text('${index + 1}'),
                              title: Text(tasks[index]),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      tasks.removeAt(index);
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.delete_forever),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        showEditDialog(index);
                                        setState(() {
                                          editingController.text = editTasks;
                                        });
                                      },
                                      icon: const Icon(Icons.edit))
                                ],
                              )),
                        );
                      }),
                ],
              ),
            ),
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
                      const Text(
                        'Add New Task',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
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
                                save();
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

  showEditDialog(int id) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextField(
                  controller: editingController,
                ),
                const SizedBox(
                  height: 25,
                ),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        tasks[id] = editingController.text;
                      });
                    },
                    child: const Text('Save Edit'))
              ],
            ),
          );
        });
  }
}
