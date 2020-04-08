import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() {
    runApp(MaterialApp(
        darkTheme: ThemeData.dark(),
        title: 'Flutter Tutorial',
        home: HomePage(),
    ));
}

class HomePage extends StatefulWidget {
    @override
    _HomePage createState() => new _HomePage();
}
class _HomePage extends State<HomePage> {
    List<Map> listElements;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("DOCS TEMPLATE"),
            ),
            drawer: AuxiliarWidget(context).getDrawer(),
            body: ListView(
                children: <Widget>[
                    getStructureItem("FORMS", getElementsLists()),
                    getStructureItem("TABLES", getElementsLists()),
                ],
            ),
            floatingActionButton: FloatingActionButton(
                tooltip: 'Add',
                child: Icon(Icons.add),
                onPressed: null,
            ),
        );
    }

    List<Map> getForms() {
        listElements = new List<Map>();
        listElements.add({'id': '1', 'name': 'form1'});
        listElements.add({'id': '2', 'name': 'form2'});
        listElements.add({'id': '3', 'name': 'form3'});
        return listElements;
    }

    Widget getStructureItem(String title, List<Widget> list) {
        return Container(
            height: 225,
            margin: const EdgeInsets.only(top: 10),
            child: Column(children: <Widget>[
                Text(
                    title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                ),
                Row(children: list),
                IconButton(
                    icon: Icon(
                        Icons.list,
                        size: 30,
                        color: Colors.deepPurpleAccent,
                    ),
                    tooltip: 'More',
                    onPressed: () {},
                ),
            ]),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 2.0, color: Colors.grey),
                ),
            ),
        );
    }

    List<Widget> getElementsLists() {
        listElements = getForms();
        List<Widget> rowItems = List();

        for (Map listItem in listElements) {
            rowItems.add(Container(
                height: 150,
                width: 125,
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: Column(
                    children: <Widget>[
                        GestureDetector(
                            onTap: () {
                                Navigator.push(
                                    this.context,
                                    MaterialPageRoute(
                                        builder: (context) => DocumentsSection(listItem)),
                                );
                            },
                            child: Image.asset(
                                'images/image.jpeg',
                                height: 125,
                                width: 100,
                            ),
                        ),
                        Text(
                            listItem['name'],
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        )
                    ],
                ),
            ));
        }
        return rowItems;
    }
}

class DocumentsSection extends StatefulWidget {
    final Map idDoc;
    DocumentsSection(this.idDoc);
    @override
    _DocumentsSection createState() => new _DocumentsSection(this.idDoc);
}
class _DocumentsSection extends State<DocumentsSection> {
    Map idDoc;
    Map result;

    @override
      void initState() {
        this.result = Map();
        super.initState();
      }

    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    _DocumentsSection(Map idDoc) {
        this.idDoc = idDoc;
    }
    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                    title: Text("DOCS TEMPLATE"),
                ),
                drawer: AuxiliarWidget(context).getDrawer(),
                body: createFieldsForm(),
                floatingActionButton: FloatingActionButton(
                    tooltip: 'Save',
                    child: Icon(Icons.save),
                    onPressed: () {
                        if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            _scaffoldKey.currentState
                                .showSnackBar(SnackBar(duration: const Duration(seconds: 3),
                                content: Text(this.result.toString())
                            ));
                            print(this.result.toString());
                            Navigator.push(
                                this.context,
                                MaterialPageRoute(builder: (context) => HomePage()),
                            );
                        }
                    },
                ),
            ));
    }

    Map getDataForm() {
        return {
            'id': '1',
            'nameDoc': 'FORM OF SCHOOL',
            'fields': [
                {'name': 'AGE', 'type': 'number'},
                {'name': 'NAME', 'type': 'string'},
                {'name': "LIST'S OBJECTS", 'type': 'options'},
                {'name': 'STATE', 'type': 'option'},
                {'name': 'CATEGORY', 'type': 'radio'}
            ]
        };
    }

    List<Widget> getFieldByString(List<Map> names) {
        List<Widget> columns = List();
        for (Map item in names) {
            if (item['type'] == 'string') {
                columns.add(
                    Container(
                        child: TextFieldElement(item['name'], 100, this.result).getField(),
                        width: AuxiliarWidget(context).getWidthScreen(20)
                    ));
            } else if (item['type'] == 'number') {
                columns.add(
                    Container(
                        child: NumberFieldElement(item['name'], 20, this.result).getField(),
                        width: AuxiliarWidget(context).getWidthScreen(20)
                    ));
            }
        }
        return columns;
    }

    Widget createFieldsForm() {
        List<Widget> columns = List();

        columns.add(Container(
            padding: EdgeInsets.only(top: 20),
            child: Text(getDataForm()["nameDoc"])));

        columns.addAll(getFieldByString(getDataForm()['fields']));

        return Container(
            child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Form(
                    key: _formKey,
                    child: Column(children: columns)
                )));
    }
}

class SettingsPage extends StatefulWidget {
    @override
    _SettingsPage createState() => new _SettingsPage();
}
class _SettingsPage extends State<SettingsPage> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("DOCS TEMPLATE"),
            ),
            drawer: AuxiliarWidget(context).getDrawer(),
            body: Center(child: Text("SP")),
            floatingActionButton: FloatingActionButton(
                tooltip: 'Save',
                child: Icon(Icons.save),
                onPressed: null,
            ),
        );
    }
}

class AuxiliarWidget {
    BuildContext context;
    AuxiliarWidget(this.context);
    Widget getDrawer() {
        return Drawer(
            child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                    DrawerHeader(
                        child: Text('DOCS TEMPLATE'),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                        ),
                    ),
                    ListTile(
                        title: Text('HOME'),
                        onTap: () {
                            Navigator.push(
                                this.context,
                                MaterialPageRoute(builder: (context) => HomePage()),
                            );
                        },
                    ),
                    ListTile(
                        title: Text('SETTINGS'),
                        onTap: () {
                            Navigator.push(
                                this.context,
                                MaterialPageRoute(builder: (context) => SettingsPage()),
                            );
                        },
                    ),
                ],
            ),
        );
    }
    double getWidthScreen(double quantity) {
        return MediaQuery.of(this.context).size.width - quantity;
    }
}

abstract class FormElement{
    Map mapResult;
    void setMapResult(Map mapResult){
        this.mapResult = mapResult;
    }
    void setMapValue(String name, String value){
        this.mapResult[name] = value;
    }
    TextFormField getField();
}
class NumberFieldElement extends FormElement{
    final String name;
    final int lengthField;

    NumberFieldElement(this.name, this.lengthField, Map mapResult){
        super.setMapResult(mapResult);
    }

    @override
    TextFormField getField() {
        return TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
            ], validator: (value) {
                if (value.isEmpty) {
                    return 'Please enter some number';
                }
                return null;
            }, onSaved: (String value) {
                super.setMapValue(this.name, value);
            },
            decoration: InputDecoration(
                labelText: this.name,
                hintText: "Ex: 1,2,3...9",
                icon: Icon(Icons.filter_9),
            ));
    }
}
class TextFieldElement extends FormElement{
    final String name;
    final int lengthField;

    TextFieldElement(this.name, this.lengthField, Map mapResult){
        super.setMapResult(mapResult);
    }
    @override
    TextFormField getField() {
        return
            TextFormField(
            keyboardType: TextInputType.url,
            inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(this.lengthField),
            ], validator: (value) {
                if (value.isEmpty) {
                    return 'Please enter some text';
                }
                return null;
            }, onSaved: (String value) {
                super.setMapValue(this.name, value);
            },
            decoration: InputDecoration(
                labelText: this.name,
                hintText: "Ex: Text...",
                icon: Icon(Icons.text_fields),
            )
        );
    }
}