import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../admin/main.dart';
import 'addlist.dart';

class SellectedItemsPage extends StatefulWidget {
  List<String> selectedItems;
  List<String> editedItems = []; // Initialize with an empty list
  String title = '';

  SellectedItemsPage(
      {Key? key, required this.selectedItems, required this.title})
      : super(key: key);

  @override
  _SelectedItemsPageState createState() => _SelectedItemsPageState();
}

class _SelectedItemsPageState extends State<SellectedItemsPage> {
  late TextEditingController titleController;
  late List<String> editedItems;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    editedItems = List.from(widget.selectedItems);
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  int _currentIndex = 0;

  void showAddUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddUserDialog(
          addItemList: (List<String> itemList) {
            // Handle the updated item list here
            // print(itemList);
          },
          setTitle: (String title) {
            // Handle the updated title here
            setState(() {
              widget.title = title;
            });
            // print('Title: ${widget.title}');
          },
          itemList: [], // Initial item list
          title: widget.title, // Initial title
        );
      },
    );
  }

  void _openEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final newItemController = TextEditingController();
        final isEditMode = editedItems.isNotEmpty;

        void addItem() {
          setState(() {
            final newItem = newItemController.text;
            editedItems.add(newItem);
            newItemController.clear();
          });
        }

        void editItem(int index) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              final editItemController =
                  TextEditingController(text: editedItems[index]);

              return AlertDialog(
                title: Text('Edit Item'),
                content: TextField(
                  controller: editItemController,
                  decoration: InputDecoration(
                    labelText: 'Item',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        editedItems[index] = editItemController.text;
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Save'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              );
            },
          );
        }

        void _openAddListDialog() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              final titleController = TextEditingController();
              final List<String> items = [];

              void addItem(String newItem) {
                setState(() {
                  items.add(newItem);
                });
              }

              return AlertDialog(
                title: Text('Add List'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('Items:'),
                    Column(
                      children: [
                        ...items.map((item) {
                          return ListTile(
                            title: Text(item),
                          );
                        }),
                        Builder(
                          builder: (BuildContext context) {
                            return Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: (value) {
                                      // You can add validation or perform other actions here.
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'New Item',
                                    ),
                                    onSubmitted: (value) {
                                      addItem(value);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Item added: $value'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    final newItem = titleController.text.trim();
                                    if (newItem.isNotEmpty) {
                                      addItem(newItem);
                                      titleController.clear();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Item added: $newItem'),
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(Icons.add),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      final newTitle = titleController.text.trim();
                      if (newTitle.isNotEmpty) {
                        final newList = [
                          ...widget.selectedItems,
                          newTitle,
                          ...items
                        ];

                        setState(() {
                          widget.selectedItems = newList;
                        });

                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please enter a title.'),
                          ),
                        );
                      }
                    },
                    child: Text('Save'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              );
            },
          );
        }

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Container(
                  color: Colors.purple[200],
                  child: Center(
                    child: Text('Edit Item',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Items:'),
                  Column(
                    children: [
                      if (isEditMode)
                        ...editedItems.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;

                          return ListTile(
                            title: Text(item),
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => editItem(index),
                            ),
                          );
                        }),
                      TextField(
                        controller: newItemController,
                        decoration: InputDecoration(
                          labelText: 'New Item',
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: addItem,
                        child: Text('Add Item'),
                      ),
                      if (!isEditMode && newItemController.text.isNotEmpty)
                        ListTile(
                          title: Text(newItemController.text),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => editItem(editedItems.length - 1),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      widget.title = titleController.text;
                      widget.selectedItems = List.from(editedItems);
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      setState(() {}); // Update the UI after the dialog is closed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'data:image/jpeg;base64,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'),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Shemeta',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 18, 34, 96),
        ),
        body: Container(
          padding: EdgeInsets.only(
            top: 30.0,
            left: 30.0,
            right: 30.0,
          ),
          margin: EdgeInsets.only(
            left: 30.0,
            right: 30.0,
          ),
          color: Colors.purple[50],
          child: ListView(
            children: [
              Container(
                height: 300.0,
                width: 300.0,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(height: 12.0),
                    Card(
                      color: Colors.grey[100],
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                left: 20.0,
                              )),
                              Center(
                                child: Text(
                                  "Monday",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                style: IconButton.styleFrom(
                                    foregroundColor:
                                        Color.fromARGB(255, 110, 9, 121),
                                    hoverColor:
                                        Color.fromARGB(223, 201, 176, 204)),
                                onPressed: _openEditDialog,
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.purple[600],
                            thickness: 5.0,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.circle,
                              size: 15.0,
                              color: Colors.purple[600],
                            ),
                            // Bullet icon
                            title: Text("Onions"),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.circle,
                              size: 15.0,
                              color: Colors.purple[600],
                            ),
                            // Bullet icon
                            title: Text("Banana"),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.circle,
                              size: 15.0,
                              color: Colors.purple[600],
                            ),
                            // Bullet icon
                            title: Text("Carrots"),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.circle,
                              size: 15.0,
                              color: Colors.purple[600],
                            ),
                            // Bullet icon
                            title: Text("Napkins"),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // ElevatedButton(
                                //   onPressed:
                                //     _openEditDialog,

                                //   child: Text("Edit",
                                //   style:TextStyle(fontSize: 15.0,
                                //   fontWeight: FontWeight.bold),),
                                //   style: ElevatedButton.styleFrom(
                                //     backgroundColor:   Color.fromARGB(255, 236, 224, 255),
                                //     foregroundColor: Color.fromARGB(255, 0, 0, 0)
                                //   ),

                                // ),
                                Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(
                                                255, 236, 224, 255),
                                            foregroundColor:
                                                Color.fromARGB(255, 0, 0, 0)))),
                              ])
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Container(
                height: 300.0,
                width: 300.0,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Card(
                      color: Colors.grey[100],
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                left: 20.0,
                              )),
                              Center(
                                child: Text(
                                  "Tuesday",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                style: IconButton.styleFrom(
                                    foregroundColor:
                                        Color.fromARGB(255, 110, 9, 121),
                                    hoverColor:
                                        Color.fromARGB(223, 201, 176, 204)),
                                onPressed: _openEditDialog,
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.purple[600],
                            thickness: 5.0,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.circle,
                              size: 15.0,
                              color: Colors.purple[600],
                            ),
                            // Bullet icon
                            title: Text("Onions"),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.circle,
                              size: 15.0,
                              color: Colors.purple[600],
                            ),
                            // Bullet icon
                            title: Text("Banana"),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.circle,
                              size: 15.0,
                              color: Colors.purple[600],
                            ),
                            // Bullet icon
                            title: Text("Carrots"),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.circle,
                              size: 15.0,
                              color: Colors.purple[600],
                            ),

                            // Bullet icon
                            title: Text("Napkins"),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // ElevatedButton(
                                //   onPressed: () {},
                                //   child: Text("Edit",
                                //   style:TextStyle(fontSize: 15.0,
                                //   fontWeight: FontWeight.bold),),
                                //   style: ElevatedButton.styleFrom(
                                //     backgroundColor:   Color.fromARGB(255, 236, 224, 255),
                                //     foregroundColor: Color.fromARGB(255, 0, 0, 0)
                                //   ),

                                // ),
                                Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(
                                                255, 236, 224, 255),
                                            foregroundColor:
                                                Color.fromARGB(255, 0, 0, 0)))),
                              ])
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 32.0)),
              Center(
                  child: Container(
                      width: 200.0,
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      child: ElevatedButton(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 24.0,
                              ),
                              Text(
                                "Add List",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 236, 224, 255),
                            foregroundColor: Color.fromARGB(255, 0, 0, 0)),
                        onPressed: () {
                          showAddUserDialog(context);
                        },
                      )))
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: IconButton(
                      icon: Icon(Icons.home),
                      onPressed: () {
                        Navigator.pushNamed(context, '/shop');
                      },
                      style: IconButton.styleFrom(
                        foregroundColor:
                            _currentIndex == 0 ? Colors.grey : Colors.purple,
                      )),
                  label: 'Shops',
                  backgroundColor: Colors.grey),
              BottomNavigationBarItem(
                icon: IconButton(
                    icon: Icon(Icons.list),
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      foregroundColor:
                          _currentIndex == 0 ? Colors.purple : Colors.grey,
                    )),
                label: 'List Page',
                backgroundColor: Colors.purple,
              ),
            ]));
  }
}
