import 'package:flutter/material.dart';

class logic extends ChangeNotifier {
  bool isStart = false;
  bool isWin = false;
  int k = 8;
  int n = 0;
  List<int> s = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  bool canClick=false;

  swap(int a) {
    isStart = true;
    //k=a-1
    List<bool> a_1 = [];
    List at1 = [];
    for (int i = 1; i < n; i++) {
      a_1.add(k != n * i - 1);
      at1.add(k != n * i);
    }

    bool _1 = false;
    bool t1 = false;
    if (!a_1.contains(false)) _1 = true;
    if (!at1.contains(false)) t1 = true;

    if ( //swap logic
        (_1 && (k == a - n || k == a + n || k == a - 1)) ||
            (t1 && (k == a - n || k == a + n || k == a + 1))) {
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
    for (int i = 0; i < n * n; i++) {
      if (s[i] == i)
        color = i + 1;
      else
        break;
    }
    if (color == n * n) isWin = true;
  }

  spread(int qub) async {
    n = qub;
    k = n * n - 1;
    // Make the the List
    isStart = true;
    s = [];
    for (int i = 0; i < n * n; i++)
      s.add(i);
    for (int i = 0; i < 50 * n; i++) {
      isStart = false;
      isWin = false;
      List temp = [k - n, k + n, k + 1, k - 1];
      temp.shuffle();
      int a = temp[0];
      if (a >= 0 && a <= n * n - 1) {
        await Future.delayed(Duration(milliseconds: (300 / n).round()));
        swap(a);
      }

    }
      canClick = true;
    notifyListeners();
  }
// bool doSet=false;
//   set() async {
//     while (doSet) {
//       for(int i=0;i<n;){
//         int reachingPoint = getReachingPoint(s.indexOf(i));
//         if (k < reachingPoint) {
//           List temp = [k + n, k + 1];
//           temp.shuffle();
//           int a = temp.first;
//           print('a=$a');
//           if (a >= 0 && a <= n * n - 1) {
//             await Future.delayed(Duration(milliseconds: (300 / n).round()));
//             swap(a);
//           }
//         } else if (k > reachingPoint) {
//           List temp = [k - n, k - 1];
//           temp.shuffle();
//           int a = temp.first;
//           print('a=$a');
//           if (a >= 0 && a <= n * n - 1) {
//             await Future.delayed(Duration(milliseconds: (300 / n).round()));
//             swap(a);
//           }
//         } else {
//           List <bool>temp=[for(int i=0;i<s.length;i++)s[i]==[for(int i=0;i<n*n;i++)i][i]];
//
//           int d=temp.indexOf(false);
//           if(d==-1)
//           {
//           print('done');
//             doSet=false;
//           }
//           else i=d;
//
//         }
//         notifyListeners();
//       }
//     }
//   }
//
//   getReachingPoint(int target) {
//     print('Get : $target');
//     if(target+n==k || target+n+1==k || target+n-1==k) return k; else
//     if ([
//       for (int i = 1; i <=n; i++)
//         if (target == (n * i)-1) i
//     ].contains(target))
//       return target + n + 1;
//     else
//       return target + n;
//   }
}
