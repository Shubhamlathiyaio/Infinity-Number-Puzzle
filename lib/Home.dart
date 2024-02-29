import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:number_provider/logic.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  TextEditingController t = TextEditingController();
  int n = 3;

  @override
  Widget build(BuildContext context) {
   var height=MediaQuery.of(context).size.height-180;
   var width= MediaQuery.of(context).size.width;

    logic l = Provider.of(context);
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                l.isStart = false;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: SizedBox(height: height,width: width,
                      child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,crossAxisSpacing: 5,mainAxisSpacing: 5), itemBuilder: (context, index) {
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
              icon: Icon(Icons.calendar_view_month_sharp))
        ]),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(),
              l.isWin
                  ? Text(
                      'You win',
                      style: TextStyle(fontSize: 24),
                    )
                  : Text('', style: TextStyle(fontSize: 24)),
              Spacer(),
              Container(
                height: height>width ? width-5:height-5,
                width: height>width ? width-5:height-5,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: n,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1),
                  itemCount: n * n,
                  itemBuilder: (context, index) {
                    return Visibility(
                      visible: ( l.isWin? true : n * n - 1 != l.s[index]),
                      child: InkWell(
                        onTap: () async {
                          //For spread the boxes random when the game not start
                          if(!l.isStart && !l.canClick) l.spread(n);
                          // For Swap drag box in empty Space when game is not win
                            l.isWin ? null : l.swap(index);
                        },
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: con(l, index,height>width ? width:height),
                        ),
                      ),
                      replacement: Container(),
                    );
                  },
                ),
              ),
              Spacer(),
              Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        l.isStart = false;
                        l.isWin = false;
                        l.color = 0;
                        l.spread(n);
                      },
                      child: Text('Reset')),
              Spacer()
            ],
          ),
        ));
  }

  Widget con(final l, int index, double size) {
    return Container(
      color: l.color > index ? Colors.purple : Colors.blue,
      alignment: Alignment.center,
      child: Text('${l.s[index] + 1}', style: TextStyle(fontSize: size/(n*2))),
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
