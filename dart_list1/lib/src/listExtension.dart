import 'list1type.dart' show List1;

extension List1List on List {
    List1 asList1() {
        return List1(this);
    }
}
