Dictionary
==========
A more composable alternative to Dart's native `Map` implementation. All
operations that fetch an element form the `Dictionary` return an `Option`
type. If the fetched value existed then the `Option` typed returned will
be `Some` and will have the value wrapped inside. If the key was not found
in the `Dictionary` then the `Option` type returned will be `None`.

The impetus behind returning `Option` types instead of raw values is you
can focus more on the composition and flow of your logic instead of
worrying about defensive `Map#containsKey` safety checks.

Examples
--------
```dart
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
```

Public Interface
----------------
```dart
library dictionary;

class Dictionary<K, V> extends HashMap<K, V> {

  /**
   * Vanilla constructor
   */
  Dictionary();

  /**
   * Factory constructor for initializing Dictionaries from Maps
   */
  factory Dictionary.fromMap(Map<K, V> other);

  /**
   * Returns an optional value based on the key
   *
   * @param {Option<V>} - A `Some` if the key exists, `None` otherwise
   */
  Option<V> operator [](K key);

  /**
   * Returns an optional value based on the key
   *
   * @param {Option<V>} - A `Some` if the key exists, `None` otherwise
   */
  Option<V> get(K key);

  /**
   * Given a `key` if that key exists then it's value will be returned,
   * otherwise the `alternative` value will be returned.
   *
   * @param {K} key               - The key to lookup
   * @param {dynamic} alternative - The alternative value
   * @return {V}                  - Either the value or the alternative
   */
  V getOrElse(K key, dynamic alternative);

  /**
   * Given a predicate returns the first key that passes it as a `Some`.
   * If no key is found a `None` is returned.
   *
   * @param {bool(V, K)} predicate - The predicate to test against
   * @return {Option<K>}           - The optional key
   */
  Option<K> findKey(bool predicate(V value, K key));

  /**
   * Given a predicate returns the fist value that passes it as a `Some`.
   * If no value is found a `None` is returned.
   *
   * @param {bool(V, K)} predicate - The predicate to test against
   * @return {Option<K>}           - The optional value
   */
  Option<V> findValue(bool predicate(V value, K key));

  /**
   * Given a predicate this method partitions the dictionary by the elements
   * that pass the predicate from the ones that don't
   *
   * @param {bool(V, K)} predicate    - The predicate to test against
   * @return {List<Dictionary<K, V>>} - The tuple list of the partitioning
   */
  List<Dictionary<K, V>> partition(bool predicate(V value, K key));

  /**
   * Given an identifier function this will group all key/value pairs
   * by the identifier they generate.
   *
   * @param {dynamic(V, K)} identifier - Generates identifiers for each kv pair
   * @return {Dictionary<dynamic, Dictionary<K, V>>} - The grouping
   */
  Dictionary<dynamic, Dictionary<K, V>> groupBy(dynamic identifier(V value, K key));

  /**
   * Creates a new `Dictionary` that doesn't contain any of the keys in `other`
   *
   * @param {Dictionary<K, V>} other - The other dictionary
   * @return {Dictionary<K, V>}      - The difference by key
   */
  Dictionary<K, V> differenceKey(Dictionary<K, V> other);

  /**
   * Creates a new `Dictionary` that doesnt contain values in `other`
   *
   * @param {Dictionary<K, V>} other - The other dictionary
   * @return {Dictionary<K, V>}      - The difference by value
   */
  Dictionary<K, V> difference(Dictionary<K, V> other);

  /**
   * Creates a new `Dictionary` where keys are present in both arrays
   *
   * @param {Dictionary<K, V>} other - The other dictionary
   * @return {Dictionary<K, V>}      - The intersection by key
   */
  Dictionary<K, V> intersectionKey(Dictionary<K, V> other);

  /**
   * Creates a new `Dictionary` where values are present in both arrays
   *
   * @param {Dictionary<K, V>} other - The other dictionary
   * @return {Dictionary<K, V>}      - The intersection by value
   */
  Dictionary<K, V> intersection(Dictionary<K, V> other);

  /**
   * Creates a new `Dictionary` where the `other` array is merged into
   * this array. Overlapping keys in `other` overwrite the keys in the
   * merged result
   *
   * @param {Dictionary<K, V>} other - The other dictionary
   * @return {Dictionary<K, V>}      - The merged result
   */
  Dictionary<K, V> merge(Dictionary<K, V> other);

}
```
