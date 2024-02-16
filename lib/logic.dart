import 'package:flutter/material.dart';

class logic extends ChangeNotifier {
  bool isStart = false;
  bool iswin = false;
  int k=8;
  int n=0;
  List <int>s = [0,1,2,3,4,5,6,7,8];


  swap(int a) {
    isStart=true;
    //k=a-1
    List<bool> a_1=[];
    List at1=[];
    for(int i=1;i<n;i++) {
      a_1.add(k != n * i - 1);
      at1.add(k!=n*i);
    }

    bool _1=false;
    bool t1=false;
    if(!a_1.contains(false)) _1=true;
    if(!at1.contains(false))t1=true;

    if (//swap logic
    ( _1 && (k == a - n || k == a + n || k == a - 1))
        || ( t1 && (k == a - n || k == a + n || k == a + 1))
    ) {
      // label changing
      int temp = s[a];
      s[a] = s[k];
      s[k] = temp;

      //value swaping
      k = a;
      win();
    }
    notifyListeners();
  }

  int color = 0;

  win() {
    color = 0;
    for (int i = 0; i < n*n; i++) {
      if (s[i] == i) color = i + 1;
      else break;
    }
    if (color==n*n) iswin = true;
  }

  spread(int qub) async {
    n=qub;
    k=n*n-1;
    // Make the the List
    isStart = true;
    s=[];
    for(int i=0;i<n*n;i++) s.add(i);
    for (int i = 0; i <150*n; i++)
    {
    isStart = false;
      iswin=false;
      List temp=[k-n,k+n,k+1,k-1];
      temp.shuffle();
      int a=temp[0];
      if(a>=0 && a<=n*n-1)
      {
        await Future.delayed(Duration(milliseconds: (300/n).round()));
        swap(a);
      }
    }
    notifyListeners();
  }

}