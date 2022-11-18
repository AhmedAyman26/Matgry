
class HomeModel
{
  late bool status;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String,dynamic> json)
  {
    status=json['status'];
    data=HomeDataModel.fromJson(json['data']);
  }
}
class HomeDataModel
{
  late List<BannerModel> banners=[];
  late List<ProductModel> products=[];
  HomeDataModel.fromJson(Map<String,dynamic> json)
  {
    json['banners'].forEach((element)
    {
      banners.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element)
    {
      products.add(ProductModel.fromJson(element));
    });
  }
}
class BannerModel
{
  int? id;
  String? image;

  BannerModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    image=json['image'];
  }
}

class ProductModel
{
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  late String image;
  late String name;
  late bool inFavourites;
  bool? inCart;

  ProductModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavourites=json['in_favorites'];
    inCart=json['in_cart'];
  }
}