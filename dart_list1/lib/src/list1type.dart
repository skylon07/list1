import 'dart:math';

// https://github.com/skylon07

class List1<ElemType> implements Iterable<ElemType> {
    /// see List.filled() documentation
    factory List1.filled(int length, ElemType fill, {bool growable = false}) =>
        List1(List.filled(length, fill, growable: growable));
        
    /// see List.empty() documentation    
    factory List1.empty({bool growable = false}) =>
        List1(List.empty(growable: growable));
        
    /// see List.from() documentation    
    factory List1.from(Iterable<ElemType> elements, {bool growable = true}) =>
        List1(List.from(elements, growable: growable));
        
    /// see List.of() documentation    
    factory List1.of(Iterable<ElemType> elements, {bool growable = true}) =>
        List1(List.of(elements, growable: growable));
        
    /// see List.generate() documentation    
    factory List1.generate(int length, ElemType generator(int index), {bool growable = true}) =>
        List1(List.generate(length, generator, growable: growable));
        
    /// see List.unmodifiable() documentation    
    factory List1.unmodifiable(Iterable<ElemType> elements) => 
        List1(List.unmodifiable(elements));


    static List1<NewType> castFrom<ElemType, NewType>(List1<ElemType> source) =>
        List1<NewType>(List.castFrom<ElemType, NewType>(source._internalList));
    
    static void copyRange<ElemType>(List1<ElemType> target, int at, List1<ElemType> source, [int? start, int? end]) =>
        List.copyRange(
            target._internalList,
            at - 1,
            source._internalList,
            start != null ?
                start - 1 : null,
            end != null ?
                end - 1 : null,
        );

    static void writeIterable<ElemType>(List1<ElemType> target, int at, Iterable<ElemType> source) =>
        List.writeIterable(target._internalList, at - 1, source);

    final List<ElemType> _internalList;

    const List1(List<ElemType> this._internalList);

    String toString() => "List1${_internalList}";

    List<ElemType> asList() => _internalList;
    
    ElemType get first => _internalList.first;

    set first(ElemType newFirst) => _internalList.first = newFirst;
    
    ElemType get last => _internalList.last;

    set last(ElemType newLast) => _internalList.last = newLast;

    int get length => _internalList.length;

    set length(int newLength) => _internalList.length = newLength;

    List1<ElemType> operator +(List<ElemType> other) {
        return List1(_internalList + other);
    }

    ElemType operator [](int index) {
        _checkRange(index);
        return _internalList[index - 1];
    }

    void _checkRange(int indexOrStart, [int? end]) {
        var useStartAndEnd = end != null;
        if (useStartAndEnd) {
            var start = indexOrStart;
            if (start <= 0 || start > _internalList.length) {
                throw RangeError.range(
                    start,
                    1,
                    _internalList.length,
                    "start",
                    "Invalid value"
                );
            } else if (end < start || end > _internalList.length) {
                throw RangeError.range(
                    end,
                    start,
                    _internalList.length,
                    "end",
                    "Invalid value"
                );
            }

        } else {
            var index = indexOrStart;
            if (index <= 0) {
                throw RangeError.value(
                    index,
                    "index",
                    "Index out of range: index must be greater than 0"
                );
            } else if (index > _internalList.length) {
                throw RangeError.value(
                    index,
                    "index",
                    "Index out of range: index should not be greater than ${_internalList.length}"
                );
            }
        }
    }

    void operator []=(int index, ElemType value) {
        _checkRange(index);
        _internalList[index - 1] = value;
    }

    void add(ElemType value) {
        _internalList.add(value);
    }

    void addAll(Iterable<ElemType> iterable) {
        _internalList.addAll(iterable);
    }

    bool any(bool testFn(ElemType element)) {
        return _internalList.any(testFn);
    }

    Map<int, ElemType> asMap() {
        return _internalList.asMap();
    }

    List1<CastType> cast<CastType>() {
        return List1(_internalList.cast<CastType>());
    }

    void clear() {
        _internalList.clear();
    }

    bool contains(Object? element) {
        return _internalList.contains(element);
    }

    ElemType elementAt(int index) {
        _checkRange(index);
        return _internalList.elementAt(index - 1);
    }

    bool every(bool test(ElemType element)) {
        return _internalList.every(test);
    }

    Iterable<SomeType> expand<SomeType>(Iterable<SomeType> toElements(ElemType element)) {
        return _internalList.expand<SomeType>(toElements);
    }

    void fillRange(int start, int end, [ElemType? fillValue]) {
        _checkRange(start, end);
        _internalList.fillRange(start - 1, end - 1, fillValue);
    }

    ElemType firstWhere(bool test(ElemType element), {ElemType orElse()?}) {
        return _internalList.firstWhere(test, orElse: orElse);
    }

    SomeType fold<SomeType>(SomeType initialValue, SomeType combine(SomeType previousValue, ElemType element)) {
        return _internalList.fold<SomeType>(initialValue, combine);
    }

    Iterable<ElemType> followedBy(Iterable<ElemType> other) {
        return _internalList.followedBy(other);
    }

    void forEach(void action(ElemType element)) {
        _internalList.forEach(action);
    }

    Iterable<ElemType> getRange(int start, int end) {
        _checkRange(start, end);
        return _internalList.getRange(start - 1, end);
    }

    int indexOf(element, [int start = 1]) {
        _checkRange(start);
        return _internalList.indexOf(element, start - 1);
    }

    int indexWhere(bool test(ElemType element), [int start = 1]) {
        _checkRange(start);
        return _internalList.indexWhere(test, start - 1);
    }

    void insert(int index, element) {
        _checkRange(index);
        _internalList.insert(index - 1, element);
    }

    void insertAll(int index, Iterable<ElemType> iterable) {
        _checkRange(index);
        _internalList.insertAll(index - 1, iterable);
    }

    bool get isEmpty => _internalList.isEmpty;

    bool get isNotEmpty => _internalList.isNotEmpty;

    Iterator<ElemType> get iterator => _internalList.iterator;

    String join([String separator = ""]) {
        return _internalList.join(separator);
    }

    int lastIndexOf(element, [int? start]) {
        if (start != null) {
            _checkRange(start);
            return _internalList.lastIndexOf(element, start - 1);
        } else {
            return _internalList.lastIndexOf(element);
        }
    }

    int lastIndexWhere(bool test(ElemType element), [int? start]) {
        if (start != null) {
            _checkRange(start);
            return _internalList.lastIndexWhere(test, start - 1);
        } else {
            return _internalList.lastIndexWhere(test);
        }
    }

    ElemType lastWhere(bool test(ElemType element), {ElemType orElse()?}) {
        return _internalList.lastWhere(test, orElse: orElse);
    }

    Iterable<SomeType> map<SomeType>(SomeType toElement(ElemType e)) {
        return _internalList.map<SomeType>(toElement);
    }

    ElemType reduce(ElemType combine(ElemType value, ElemType element)) {
        return _internalList.reduce(combine);
    }

    bool remove(Object? value) {
        return _internalList.remove(value);
    }

    ElemType removeAt(int index) {
        _checkRange(index);
        return _internalList.removeAt(index - 1);
    }

    ElemType removeLast() {
        return _internalList.removeLast();
    }

    void removeRange(int start, int end) {
        _checkRange(start, end);
        _internalList.removeRange(start - 1, end);
    }

    void removeWhere(bool test(ElemType element)) {
        _internalList.removeWhere(test);
    }

    void replaceRange(int start, int end, Iterable<ElemType> replacements) {
        _checkRange(start, end);
        _internalList.replaceRange(start - 1, end, replacements);
    }

    void retainWhere(bool test(ElemType element)) {
        _internalList.retainWhere(test);
    }

    Iterable<ElemType> get reversed => _internalList.reversed;

    void setAll(int index, Iterable<ElemType> iterable) {
        _checkRange(index);
        _internalList.setAll(index, iterable);
    }

    void setRange(int start, int end, Iterable<ElemType> iterable, [int skipCount = 0]) {
        _checkRange(start, end);
        _internalList.setRange(start - 1, end, iterable);
    }

    void shuffle([Random? random]) {
        _internalList.shuffle(random);
    }

    get single => _internalList.single;

    ElemType singleWhere(bool test(ElemType element), {ElemType orElse()?}) {
        return _internalList.singleWhere(test, orElse: orElse);
    }

    Iterable<ElemType> skip(int count) {
        return _internalList.skip(count);
    }

    Iterable<ElemType> skipWhile(bool test(ElemType value)) {
        return _internalList.skipWhile(test);
    }

    void sort([int compare(ElemType a, ElemType b)?]) {
        _internalList.sort(compare);
    }

    List1<ElemType> sublist(int start, [int? end]) {
        _checkRange(start, end);
        return List1(_internalList.sublist(start - 1, end));
    }

    Iterable<ElemType> take(int count) {
        return _internalList.take(count);
    }

    Iterable<ElemType> takeWhile(bool test(ElemType value)) {
        return _internalList.takeWhile(test);
    }

    List<ElemType> toList({bool growable = true}) {
        return _internalList.toList(growable: growable);
    }

    Set<ElemType> toSet() {
        return _internalList.toSet();
    }

    Iterable<ElemType> where(bool test(ElemType element)) {
        return _internalList.where(test);
    }

    Iterable<SomeType> whereType<SomeType>() {
        return _internalList.whereType<SomeType>();
    }
}
