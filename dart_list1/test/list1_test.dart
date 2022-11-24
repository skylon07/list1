import 'package:list1/types.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:dart_eval/dart_eval.dart';

Matcher errorMessageContains(String regexStr) {
    var regex = RegExp(regexStr);
    return predicate((dynamic error) =>
        regex.firstMatch(error.message) != null
    );
}

void main() {
    group("The List1() constructor", () {
        test("can construct from an empty list", () {
            List1 list1 = List1([]);
            expect(list1, isA<List1>());
        });
        test("can construct from a list with elements", () {
            List1 list1 = List1(["a", "b", "c"]);
            expect(list1, isA<List1>());
        });
        test("is a const constructor", () {
            List1 list1 = const List1(["a", "b", "c"]);
            List1 list2 = const List1(["a", "b", "c"]);
            expect(() {
                list1.add("d");
            }, throwsUnsupportedError);
            expect(identical(list1, list2), isTrue);
        });
        test("throws when a list is not given", () async {
            expect(() {
                // heh... it's not *actually* erroring because of the constructur...
                // whatever, I can't seem to figure this out
                eval(
                    "void main(listarg) { return List1(); }",
                    function: "main",
                    args: [],
                );
            }, throwsException);
            expect(() {
                eval(
                    "void main(listarg) { return List1(null); }",
                    function: "main",
                    args: [],
                );
            }, throwsException);
        });
    });
    group("List1() as an object", () {
        test("returns the list at construction with asList()", () {
            var list = ["a", "b", "c"];
            var list1 = List1(list);
            expect(identical(list1.asList(), list), isTrue);
            list.add("d");
            expect(list1, equals(["a", "b", "c", "d"]));
        });
        test("can detect inequality with other List1() instances", () {
            var list1 = List1(["a", "b", "c"]);
            var otherList1 = List1(["a", "b", "c"]);
            // expect(list1, equals(otherList1)); // does not call operator ==()
            expect(list1 == otherList1, isFalse);
            expect(otherList1 == list1, isFalse);
            expect(list1 == list1, isTrue);
            expect(otherList1 == otherList1, isTrue);
        });
        test("can detect inequality with its internal List() instance", () {
            var list = ["a", "b", "c"];
            var list1 = List1(list);
            // expect(list1, equals(list)); // does not call operator ==()
            expect(list1 == list, isFalse);
            expect(list == list1, isFalse);
        });
        test("returns the same hashCode across calls", () {
            var list1 = List1(["a", "b", "c"]);
            int initHashCode = list1.hashCode;
            expect(list1.hashCode, equals(initHashCode));
            expect(list1.hashCode, equals(initHashCode));
            expect(list1.hashCode, equals(initHashCode));
        });
        test("returns a different hashCode than its internal List() instance", () {
            var list = ["a", "b", "c"];
            var list1 = List1(list);
            expect(list1.hashCode, isNot(equals(list.hashCode)));
        });
    });
    group("The iterable from List1()", () {
        test("exists", () {
            var list1 = List1(["a", "b", "c"]);
            for (var elem in list1) {
                expect(elem, isIn(["a", "b", "c"]));
            }
        });
    });
    group("Indexing with List1()", () {
        test("returns the first value at index [1]", () {
            var list1 = List1(["first", "second", "third"]);
            expect(list1[1], equals("first"));
        });
        test("alternatively returns the first value with `first`", () {
            var list1 = List1(["first", "second", "third"]);
            expect(list1.first, equals("first"));
        });
        test("returns the last value at index [length]", () {
            var list1 = List1(["first", "second", "third"]);
            expect(list1[3], equals("third"));
        });
        test("alternatively returns the last value with `last`", () {
            var list1 = List1(["first", "second", "third"]);
            expect(list1.last, equals("third"));
        });
        test("returns the correct length of the list", () {
            var list1 = List1(["first", "second", "third"]);
            expect(list1.length, equals(3));
        });
        test("correctly sets the first value at index [1]", () {
            var list1 = List1(["first", "second", "third"]);
            list1[1] = "changed!";
            expect(list1[1], equals("changed!"));
        });
        test("correctly sets the first value with `first`", () {
            var list1 = List1(["first", "second", "third"]);
            list1.first = "changed!";
            expect(list1.first, equals("changed!"));
        });
        test("correctly sets the last value at index [length]", () {
            var list1 = List1(["first", "second", "third"]);
            list1[3] = "changed!";
            expect(list1[3], equals("changed!"));
        });
        test("correctly sets the last value with `last`", () {
            var list1 = List1(["first", "second", "third"]);
            list1.last = "changed!";
            expect(list1.last, equals("changed!"));
        });
        test("correctly sets the length of the list", () {
            var list1 = List1<String?>(["first", "second", "third"]);
            list1.length = 4;
            expect(list1.length, equals(4));
            expect(list1, equals(["first", "second", "third", null]));
            list1.length = 2;
            expect(list1.length, equals(2));
            expect(list1, equals(["first", "second"]));
            list1.length = 3;
            expect(list1.length, equals(3));
            expect(list1, equals(["first", "second", null]));
        });
        test("provides the right indexes in an indexing error message", () {
            var list1 = List1(["first", "second", "third"]);
            expect(
                () {
                    list1[0];
                },
                throwsA(errorMessageContains("index must be greater than 0"))
            );
            expect(
                () {
                    list1[4];
                },
                throwsA(errorMessageContains("index should not be greater than 3"))
            );
        });
    });
    group("Elements with List1()", () {
        test("can be retrieved with elementAt()", () {
            var list1 = List1(["first", "second", "third"]);
            expect(list1.elementAt(1), equals("first"));
            expect(list1.elementAt(2), equals("second"));
            expect(list1.elementAt(3), equals("third"));
        });
        test("can be inserted at an index", () {
            var list1 = List1(["first", "second", "third"]);
            list1.insert(2, "actually second");
            expect(list1, equals(["first", "actually second", "second", "third"]));
            list1.insert(1, "actually first");
            expect(list1, equals(["actually first", "first", "actually second", "second", "third"]));
            list1.insert(list1.length + 1, "last");
            expect(list1, equals(["actually first", "first", "actually second", "second", "third", "last"]));
        });
        test("can be bulk inserted at an index", () {
            var list1 = List1(["first", "second", "third"]);
            list1.insertAll(3, ["something1", "something2"]);
            expect(list1, equals(["first", "second", "something1", "something2", "third"]));
            list1.insertAll(1, ["before1", "before2"]);
            expect(list1, equals(["before1", "before2", "first", "second", "something1", "something2", "third"]));
            list1.insertAll(list1.length + 1, ["after1", "after2"]);
            expect(list1, equals(["before1", "before2", "first", "second", "something1", "something2", "third", "after1", "after2"]));
        });
        test("can be removed at an index", () {
            var list1 = List1(["first", "second", "third"]);
            list1.removeAt(3);
            expect(list1, equals(["first", "second"]));
        });
    });
    // TODO: indexOf indexWhere lastIndexOf lastIndexWhere
    // TODO: getRange fillRange removeRange replaceRange setAll setRange sublist

    // TODO: static tests (copyRange() and writeIterable() specifically)
}
