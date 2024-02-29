import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Normal(),
    debugShowCheckedModeBanner: false,
  ));
}

class Normal extends StatefulWidget {
  const Normal({super.key});

  @override
  State<Normal> createState() => _NormalState();
}

class _NormalState extends State<Normal> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Start');
    get();
  }

  List l = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  late int k;

  get() {
    l.shuffle();
    k=l.indexOf(8);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           SizedBox(height: 50,),
            SizedBox(
              width: height>width ? width-5:height-5,
              height: 500,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 1, crossAxisSpacing: 1),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      int a=index;
                                 if(
                                 (a!=2 && a!=5) && (k==a+3 || k==a-3 || k==a+1)     ||
                                 (a!=3 && a!=6) && (k==a+3 || k==a-3 || k==a-1)
                                 ) {
                                   var temp=l[k];
                                   l[k]=l[a];
                                   l[a]=temp;
                                   k=a;
                                   setState(() {});
                                 }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: l[index] == 8 ? null : Colors.blue,
                      child:
                          Text('${l[index] + 1}', style: TextStyle(fontSize: l[index] == 8 ? 0 :72)),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 100,),
            ElevatedButton(onPressed: ()       =>
              get()
            , child: Text('Restart')),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
