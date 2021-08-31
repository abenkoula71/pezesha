class DataList {
  late int id;
  late String name;
  late String email;
  late int sales;
  DataList(this.id, this.email, this.name, this.sales);

  DataList.fromList(List<String> items)
      : this(int.parse(items[0]), items[1], items[2], int.parse(items[2]));
  @override
  String toString() {
    return 'DataList{id: $id, name: $name, email: $email, sales: $sales}';
  }
}
