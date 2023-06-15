import 'package:flutter/material.dart';
import 'dart:math' as math;

class Pay extends StatefulWidget {
  final String title,releaseDate,hall;
  const Pay({Key? key,required this.title,required this.releaseDate,required this.hall}) : super(key: key);

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {

  int selectedDate=0;

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          children: [
            Text(widget.title,style: const TextStyle(fontFamily: 'PopR',color: Colors.black,fontSize: 22),),
            Text('In Theatres ${widget.releaseDate} | ${widget.hall}',style: const TextStyle(fontFamily: 'PopR',color: Colors.blue,fontSize: 12),),
          ],
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          children: [
            SizedBox(height: 0.05*h,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:  Row(
                children: [
                  cards('12:30  ','Cinetech + hall 1','50\$'),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex:4,
                    child: Container(
                      alignment: Alignment.center,
                      height: 0.07*h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black26,
                      ),
                      child:  const Column(
                        children: [
                          Text("Total Price", style: TextStyle(fontFamily: 'PopR',fontSize:15,color: Colors.black26)),
                          Text("50\$", style: TextStyle(fontFamily: 'PopR',fontSize:20,fontWeight: FontWeight.bold,color: Colors.black26)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    flex: 8,
                    child: InkWell(
                      onTap: ()
                      {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) {
                        //       return Detail(movieData:movieData[index]);
                        //     },
                        //   ),
                        // );
                      },
                      child: Container(
                        height: 0.07*h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                            gradient: const LinearGradient(
                              colors: [Colors.lightBlueAccent,Colors.lightBlue],

                            )
                        ),
                        child:  const Text("Proceed to pay", style: TextStyle(fontFamily: 'PopR',fontSize:18,fontWeight: FontWeight.bold,color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
  Widget cards(String time,String hall,String price)
  {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return  Column(
      children: [
        const SizedBox(height: 5,),
        const Text("Screen",style: TextStyle(fontSize: 16,color: Colors.grey,fontFamily: 'PopR'),),
        Container(
            height: 0.3*h,
            width: w*0.82,
            padding:const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                for (int i=0;i<100;i++)
                  Container(
                    width: 25,
                    // height: 30,
                    padding:const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/seat.png",scale: 0.9,color:(i%5==0)?Colors.grey:(i%3==0)?Colors.blue:Colors.indigo,),
                  ),
              ],
            )
        ),
        const SizedBox(height: 10,),
        RichText(
          text: TextSpan(
            text: "From ",
            style:const TextStyle(fontFamily: 'PopR',color: Colors.black38,fontSize: 15,fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(text: price, style: const TextStyle(fontFamily: 'PopR',fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)),
              const TextSpan(text: ' or ', style: TextStyle(fontFamily: 'PopR',color: Colors.black38,fontSize: 15,fontWeight: FontWeight.bold)),
              const TextSpan(text: "2500 bonus", style: TextStyle(fontFamily: 'PopR',fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)),

            ],
          ),
        ),
      ],
    );
  }
}

