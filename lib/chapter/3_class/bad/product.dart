class Product {
  Product(this.name, this.price);

  String name;
  int price;

  int addPrice(int value) {
    value = 100;
    return price + 100;
  }
}

// 不正値を渡せてしまう (=ガード節がない)
Product p = Product('Apple', -100);

var p2 = Product('Banana', 200);
