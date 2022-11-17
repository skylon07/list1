import 'list1type.dart' show List1;

extension List1Iterable on Iterable {
    List1 toList1({bool growable = true}) {
        return List1(this.toList(growable: growable));
    }
}

class TestClass {
    
}
