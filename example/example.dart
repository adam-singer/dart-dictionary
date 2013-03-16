import 'package:dictionary/dictionary.dart';

main() {

  var dict = new Dictionary.fromMap({
    'A': 'a',
    'B': 'b',
    'C': 'c'
  });

  var other = new Dictionary.fromMap({
    'C': 'c',
    'D': 'd',
    'E': 'e'
  });

  var lowerA   = dict.getOrElse('A', 'N/A');
  var lowerB   = dict['B'].getOrElse('N/A');
  var lowerC   = dict.get('C').getOrElse('N/A');
  var findA    = dict.findKey((v, k) => k == 'B').getOrElse('N/A');
  var findB    = dict.findValue((v, k) => v == 'b').getOrElse('N/A');
  var findBs   = dict.partition((v, k) => v == 'b');
  var byValue  = dict.groupBy((v, k) => v);
  var diffKey  = dict.differenceKey(other);
  var diffVal  = dict.difference(other);
  var interKey = dict.intersectionKey(other);
  var interVal = dict.intersection(other);
  var merged   = dict.merge(other);

  print(merged);

}