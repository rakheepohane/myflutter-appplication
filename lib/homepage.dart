import 'dart:convert';

import 'package:buyme/homedetails.dart';
import 'package:buyme/productmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color _mycolor = Color(0xfff5f5f5);
   final Color _blackcolor = Color(0xff403058);

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var response = await rootBundle.loadString("assets/files/products.json");
    //print(response);
    var decodedData=jsonDecode(response);
    var data=decodedData["products"];
    ItemModel.items=List.from(data).map<Item>((item) => Item.fromMap(item)).toList();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _mycolor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Shop Me", style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: _blackcolor ),),
              Text("Trending Products", style: TextStyle(fontSize: 20,color: _blackcolor ),),
             
             Padding(padding:   EdgeInsets.symmetric(vertical: 9,horizontal: 4),
              child: CupertinoSearchTextField()),



              Expanded(
                child: ListView.builder( shrinkWrap:true,
                  itemBuilder: (context,index){
                  final productItem=ItemModel.items[index];
                  return InkWell(
                    onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeDetailsPage(productItem: productItem),),),
                      child: ProductList(productItem));
                },
                  itemCount: ItemModel.items.length,),
              )
            ],
          ),
        ),
      )
    );
  }


}

class ProductList extends StatelessWidget {
  final Item productItem;
 ProductList(this.productItem);
  final Color _mycolor = const Color(0xfff5f5f5);
  final Color _blackcolor = Color(0xff403058);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 190,
        height: 110,
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width*0.30,
                color:_mycolor,
                padding: EdgeInsets.all(8),
                child: Hero(tag: Key(productItem.id.toString()),
                child: Image.network(productItem.image))),
            SizedBox(width: 5,),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2,),
                    Text(productItem.name,style: TextStyle(fontWeight: FontWeight.bold,color:_blackcolor ),),
                    Text(productItem.desc,style: TextStyle(color: Colors.black45),),

                    SizedBox(height: 5,),
                    ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    buttonPadding: EdgeInsets.only(top: 4),
                    children: [
                      Text("\$${productItem.price}",style: TextStyle(fontWeight: FontWeight.bold,color: _blackcolor),),
                      ElevatedButton.icon(onPressed: (){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Cart not supported yet...",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ));
                      },
                        icon: const Icon(CupertinoIcons.cart_badge_plus,size: 30,),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(_blackcolor),
                          shape: MaterialStateProperty.all(const StadiumBorder()),
                      ), label: const Text(""),
                      )
                   ],
                  )
                  ],
            )),
          ],
        ),
      ),
    );

  }
}


