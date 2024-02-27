import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:number_provider/logic.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  TextEditingController t = TextEditingController();
  int n = 3;

  @override
  Widget build(BuildContext context) {
   var height=MediaQuery.of(context).size.height-130;
   var width= MediaQuery.of(context).size.width;

    logic l = Provider.of(context);
  print(l.isStart);
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                l.isStart = false;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: SizedBox(height: height,width: width,
                      child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,crossAxisSpacing: 5,mainAxisSpacing: 5),itemCount: 32, itemBuilder: (context, index) {
                        return InkWell(onTap: () async {
                          n=index+2;
                          l.spread(n);
                          Navigator.pop(context);
                        },child: Container(alignment: Alignment.center,child: Text('${index+2}'),color: Colors.pink,));
                      },),
                    )
                  ),
                );
              },
              icon: Icon(Icons.add_box))
        ]),
        body: Center(
          child: Column(
            children: [
              Spacer(),
              // IconButton(onPressed: l.spread(), icon: Icon(Icons.ac_unit_outlined)),
              l.iswin
                  ? Text(
                      'You win',
                      style: TextStyle(fontSize: 24),
                    )
                  : Text('', style: TextStyle(fontSize: 24)),
              Spacer(),
              Container(
                height: height,
                width: width,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: n,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1),
                  itemCount: n * n,
                  itemBuilder: (context, index) {
                    return Visibility(
                      visible: ((l.iswin) ? true : n * n - 1 != l.s[index]),
                      child: InkWell(
                        onTap: () {
                          if(!l.isStart) l.spread(n);
                          l.iswin ? null : l.swap(index);
                        },
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: con(l, index,width),
                        ),
                      ),
                      replacement: Container(),
                    );
                  },
                ),
              ),
              Spacer(),
              ElevatedButton(
                  onPressed: () {
                    l.isStart = false;
                    l.iswin = false;
                    l.color = 0;
                    l.spread(n);
                  },
                  child: Text('Reset')),
              Spacer()
            ],
          ),
        ));
  }

  Widget con(final l, int index, double w) {
    return Container(
      color: l.color > index ? Colors.purple : Colors.blue,
      alignment: Alignment.center,
      child: Text('${l.s[index] + 1}', style: TextStyle(fontSize: w/(n*2))),
    );
  }

  Widget play(int a) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        '$a',
        style: TextStyle(
            fontSize: 72, fontWeight: FontWeight.w900, color: Colors.white),
      ),
      height: 200,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.deepOrange, borderRadius: BorderRadius.circular(50)),
    );
  }
}
