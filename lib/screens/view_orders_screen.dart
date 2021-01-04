import 'package:air_2011/screens/add_order_screen.dart';
import 'package:air_2011/screens/login_screen.dart';
import 'package:air_2011/widgets/custom_appbar.dart';
import 'package:air_2011/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../widgets/drawer.dart';
import '../providers/users.dart';

enum FilterState { NoState, NoFilter, Completed, NotCompleted, Buyer, Date }

class ViewOrdersScreen extends StatefulWidget {
  static const routeName = 'orders-screen';

  @override
  _ViewOrdersScreenState createState() => _ViewOrdersScreenState();
}

class _ViewOrdersScreenState extends State<ViewOrdersScreen> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _fetch(BuildContext context, FilterState filterState) async {
    switch (filterState) {
      case FilterState.NoFilter:
        await Provider.of<Orders>(context, listen: false).fetchOrders();
        break;
      case FilterState.NotCompleted:
        await Provider.of<Orders>(context, listen: false)
            .filterByNotCompleted();
        break;
      case FilterState.Completed:
        await Provider.of<Orders>(context, listen: false).filterByCompleted();
        break;
      case FilterState.Date:
        await Provider.of<Orders>(context, listen: false)
            .filterByDate(_selectedDate);
        break;
      default:
        await Provider.of<Orders>(context, listen: false).fetchOrders();
        break;
    }
  }

  void _selectDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((pickedDate) {
      if (pickedDate == null && pickedDate != _selectedDate) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  String _dropDownVal = 'No filter';
  bool dateSelected = false;
  bool built = false;
  //Used to access scaffold to open a drawer from custom appbar
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var usersData = Provider.of<Users>(context);
    var _filterState = FilterState.NoFilter;
    //Provider.of<Users>(context).fetchClients();
    //Temporary user instance, later will use logged user data
    if (!built) {
      Provider.of<Users>(context, listen: false).fetchClients();
      Provider.of<Orders>(context, listen: false).fetchOrders();
      built = true;
    } else {
      switch (_dropDownVal) {
        case "Not Completed":
          _filterState = FilterState.NotCompleted;
          break;
        case "Completed":
          _filterState = FilterState.Completed;
          break;
        case "Date":
          //Waits for screen rebuilt and then opens Date picker
          if (!dateSelected) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _selectDate(context);
              dateSelected = true;
            });
          }
          _filterState = FilterState.Date;
          break;
        case "Buyer":
          break;
        case "No filter":
          _filterState = FilterState.NoFilter;
          break;
        default:
          _filterState = FilterState.NoFilter;
          break;
      }
    }
    //final _loggedUser = usersData.getUserById("6yefDcBz9GbXfGGMeXgh8rwB6CJ2");
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            CustomAppbar(_scaffoldKey),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          side: BorderSide(
                              width: 3, color: Theme.of(context).accentColor)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: DropdownButton(
                          value: _dropDownVal,
                          underline: Container(
                            height: 0,
                          ),
                          icon: Icon(
                            Icons.filter_alt_sharp,
                            color: Theme.of(context).accentColor,
                            size: 30,
                          ),
                          elevation: 24,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          items: <String>[
                            'No filter',
                            'Date',
                            'Buyer',
                            'Not Completed',
                            'Completed'
                          ].map<DropdownMenuItem<String>>((String e) {
                            return DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                          onChanged: (String newVal) {
                            setState(() {
                              _dropDownVal = newVal;
                              dateSelected = false;
                            });
                          }),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: deviceSize.height - 250,
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                /*child:  Container(
                    child: ListView.builder(
                      itemBuilder: (_, i) => Column(
                        children: [
                          //Dodaj filter
                          OrderItem(orderData[i]),
                          Divider()
                        ],
                      ),
                      itemCount: orderData.length,
                    ),
                  )*/
                child: FutureBuilder(
                  future: _fetch(context, _filterState),
                  builder: (ctx, snapshot) => snapshot.connectionState ==
                          ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          child: Consumer<Orders>(
                            builder: (ctx, orderData, _) => ListView.builder(
                              itemBuilder: (_, i) => Column(
                                children: [
                                  //Dodaj filter
                                  OrderItem(_filterState == FilterState.NoFilter
                                      ? orderData.allOrders[i]
                                      : orderData.filteredOrders[i]),
                                  Divider()
                                ],
                              ),
                              itemCount: _filterState == FilterState.NoFilter
                                  ? orderData.allOrders.length
                                  : orderData.filteredOrders.length,
                            ),
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(AddOrderScreen.routeName);
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
