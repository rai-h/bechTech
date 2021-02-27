class Sorting {
  List sortData(documents) {
    print('object');
    print(documents);
    List<String> list = documents.keys.toList();
    List<int> datalist = list.map((data) => int.parse(data)).toList();
    List<int> sortedKeys = datalist..sort();
    List<String> newdatalist =
        (sortedKeys.reversed).map((data) => data.toString()).toList();
    List finalList = [];
    for (String i in newdatalist) {
      for (var j in documents[i]) {
        finalList.add(j);
      }
    }
    print("<<<<<<<$finalList");
    return finalList;
  }
}
