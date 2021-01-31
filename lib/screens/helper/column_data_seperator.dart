var table={};

List<String> column(var data){
  List<String> col = [];
  for(int i=0; i<data.length; i++){
    table[data[i][0]] = i;
    col.add(data[i][0]);
  } 
  return col;
}

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  bool isFloat(String s) {
    if (s == null) {
      return false;
    }
    return RegExp(r"[+-]?([0-9]*[.])?[0-9]+").hasMatch(s);
  }

List<String> colX(List<List<String>> data, String x){
  List<String> temp = [];
  for(int i=0; i<data.length; i++){
    if(data[i][0] == x){
      for(int j=1; j<data[0].length; j++){
        temp.add(data[i][j]);
      }
    }
  } 
  return temp;
}

List<double> colY(List<List<String>> data, String x){
  List<double> temp = [];
  for(int i=0; i<data.length; i++){
    if(data[i][0] == x){
      for(int j=1; j<data[0].length; j++){
        temp.add(double.parse(data[i][j]));
      }
    }
  } 
  return temp;
}

int rowCount(List<List<String>> data){
  int x = data[0].length;
  return x;
}

int colCount(List<List<String>> data){
  int x = data.length;
  return x;
}

int lookUp(String col){
  int x = table[col];
  return x;
}

Map<String, double> counter(List<List<String>> data, String x, String y){
  List<String> k = colX(data, x);
  Set<String> kSet = k.toSet();
  List<double> v = colY(data, y);
  Map<String, double> count = {};
  for(int i=0; i<kSet.length; i++){
    count[kSet.elementAt(i)] = 0.0;
  }
  for(int i=0; i<k.length; i++){
  count[k[i]] += v[i];
}
return count;
}

Map<String, int> count(List<List<String>> data, String x){
  List<String> k = colX(data, x);
  Set<String> kSet = k.toSet();
  Map<String, int> count = {};
  for(int i=0; i<kSet.length; i++){
    count[kSet.elementAt(i)] = 0;
  }
  for(int i=0; i<k.length; i++){
  count[k[i]] += 1;
}
return count;
}