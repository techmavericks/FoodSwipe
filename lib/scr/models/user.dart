import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodswipe/scr/models/cart_item.dart';

class UserModel{
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";
  static const  FOOD="likedFood";
  static const  RES="likedRestaurants";

  String _name;
  String _email;
  String _id;
  String _stripeId;
  List<CartItemModel> _cart;

  int _priceSum = 0;
  int _quantitySum = 0;
  int totalCartPrice;


//  getters
  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get stripeId => _stripeId;
  List<CartItemModel> get cart => _cart;






  UserModel.fromSnapshot(DocumentSnapshot snapshot){
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _id = snapshot.data[ID];
    _stripeId = snapshot.data[STRIPE_ID];
    _cart = _convertCartItems(snapshot.data[CART]) ?? [];
    totalCartPrice = snapshot.data[CART] == null ? 0 :getTotalPrice(cart: snapshot.data[CART]);
  }

  int getTotalPrice({List cart}){
    if(cart == null){
      return 0;
    }
    for(Map cartItem in cart){
      _priceSum += cartItem["price"] * cartItem["quantity"];
    }

    int total = _priceSum;

    print("THE TOTAL IS $total");

    return total;
  }

 List<CartItemModel> _convertCartItems(List cart){
    List<CartItemModel> convertedCart = [];
    for(Map cartItem in cart){
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
}