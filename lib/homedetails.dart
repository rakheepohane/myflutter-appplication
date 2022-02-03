import 'package:buyme/productmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeDetailsPage extends StatefulWidget {
 // const HomeDetailsPage({Key? key}) : super(key: key);
  final Item productItem;

   HomeDetailsPage({Key? key, required this.productItem}) : super(key: key);

  @override
  State<HomeDetailsPage> createState() => _HomeDetailsPageState();
}

class _HomeDetailsPageState extends State<HomeDetailsPage> {
  String MyAddress="";
  TextEditingController my_Address= new TextEditingController();
  final _FormKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    final Color _mycolor = Color(0xfff5f5f5);
    final Color _blackcolor = Color(0xff403058);
      return Scaffold(
        backgroundColor: _mycolor,
        appBar: AppBar(),
        body:SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Image.network(widget.productItem.image),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        color: Colors.white,
                        height: 450,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(widget.productItem.name,style: TextStyle(fontWeight: FontWeight.bold,color:_blackcolor,fontSize: 25 ),),
                              Text(widget.productItem.desc,style: TextStyle(color: Colors.black45),),


                              const SizedBox(height:30 ,),

                              ButtonBar(
                                alignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("\$${widget.productItem.price}",style: TextStyle(fontWeight: FontWeight.bold, fontSize:25,color: Colors.red),),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   children: [
                                     FloatingActionButton.small(heroTag: "decreaseBtn", onPressed: (){
                                       decrementCounter();
                                     },
                                       child: Icon(Icons.remove),backgroundColor: _blackcolor,),

                                     Text('$_quantity',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: _blackcolor),),

                                     FloatingActionButton.small( heroTag:"increaseBtn", onPressed: (){
                                       incrementCounter();
                                     },child: Icon(Icons.add),backgroundColor: _blackcolor,),
                                   ],
                                 )

                                ],
                              ),

                             const SizedBox(
                               height: 25,
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text("Total Amount:",style: TextStyle(fontSize: 16,),),
                                 Text("\$${totalBill()}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color:Colors.redAccent ),),
                               ],
                             ),
                            SizedBox(height: 10,),
                              Form(
                                key: _FormKey,
                                child: TextFormField( controller: my_Address,decoration: InputDecoration(hintText: "Enter Your Address "),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Address cannot be Empty';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                            SizedBox(height: 20,),
                           ElevatedButton(onPressed: (){
                             if(_FormKey.currentState!.validate()){
                               setState(() {
                                 MyAddress=my_Address.text;
                               });
                             placeOrder();};},
                           child: Text("Place Order",style: const TextStyle(fontSize: 20),),
                            style:ElevatedButton.styleFrom(minimumSize: Size(300,40),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              primary: _blackcolor,
                           )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],

              ),
            ),
          ),
        ),
      );
    }

int _quantity=1;

  void incrementCounter() {
    _quantity++;
    setState(() {

    });
  }

  void decrementCounter() {
    _quantity--;
    setState(() {

    });

  }

  num totalBill(){
    num totalPrice=widget.productItem.price;
    totalPrice=_quantity * totalPrice;
    return totalPrice;
  }

  void placeOrder() async {
    const toEmail = 'rakheepohane@gmail.com';
    const subject = 'order details';
    final message = 'Product Name: ${widget.productItem.name}\nQuantity:$_quantity\nTotal Amount:\$${totalBill()}\nAddress: $MyAddress\nThank You!!';
    final url = 'mailto:$toEmail?subject=${subject}&body=${message}';
    if (await canLaunch(url)) {
      await launch(url);
    }
  //  print("${message}");
  }
}

