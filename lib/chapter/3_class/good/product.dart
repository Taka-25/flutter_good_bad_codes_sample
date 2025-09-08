class Product {
  Product(this.name, this.price) {
    // Good: 不正値を防ぐためのガード節が実装されている
    if (price < 0) {
      throw RangeError('Price cannot be negative');
    }
  }

  final String name;
  final int price;

  // Good: 引数をfinalにして、変更できないようにしている
  int addPrice(final int value) {
    // value = 100;
    return price + value;
  }
}
