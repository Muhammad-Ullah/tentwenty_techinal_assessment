import 'package:flutter/material.dart';
import 'package:tentwenty_techinical_assessment/screens/pay.dart';

class Tickets extends StatefulWidget {
  final String title,releaseDate;
  const Tickets({Key? key,required this.title,required this.releaseDate}) : super(key: key);

  @override
  State<Tickets> createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {

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
            Text('In Theatres ${widget.releaseDate}',style: const TextStyle(fontFamily: 'PopR',color: Colors.blue,fontSize: 12),),
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 0.15*h,),
            const Text("Date",style: TextStyle(fontFamily: 'PopR',color: Colors.black,fontSize: 22),),
            SizedBox(
              height: 0.08*h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      setState(() {
                        selectedDate=index;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: (index==selectedDate)?Colors.transparent:Color.fromRGBO(166,166,166,0.2)),
                        color: (index==selectedDate)?Colors.blue:Color.fromRGBO(166,166,166,0.2)
                      ),
                      child:(index==selectedDate)?Text('    ${index+1} Mar    ',style: const TextStyle(fontFamily: 'PopR',color: Colors.white,fontSize: 15),):
                      Text('    ${index+1} Mar    ',style: const TextStyle(fontFamily: 'PopR',color: Colors.black,fontSize: 15),),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 0.05*h,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:  Row(
                children: [
                  cards('12:30  ','Cinetech + hall 1','50\$'),
                  const SizedBox(width: 20,),
                  cards('13:30  ','Cinetech + hall 2','70\$'),
                  const SizedBox(width: 20,),
                  cards('14:30  ','Cinetech + hall 3','100\$'),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: ()
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return Pay(title: widget.title,releaseDate: widget.releaseDate,hall: 'hall ${selectedDate+1}',);
                      },
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                    gradient: const LinearGradient(
                      colors: [Colors.lightBlueAccent,Colors.lightBlue],

                    )
                  ),
                  child:  const Text("Select Seat", style: TextStyle(fontFamily: 'PopR',fontSize:18,fontWeight: FontWeight.bold,color: Colors.white)),
                ),
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: time,
            style:const TextStyle(fontFamily: 'PopR',color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(text: hall, style: const TextStyle(fontFamily: 'PopR',color: Colors.black26,fontSize: 15)),
            ],
          ),
        ),
        const SizedBox(height: 5,),
        Container(
            height: 0.3*h,
            width: w*0.82,
            padding:const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(12),
            ),
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
        )
      ],
    );
  }
}
