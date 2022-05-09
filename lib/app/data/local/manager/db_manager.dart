import 'dart:io';

import 'package:logger/logger.dart';
import 'package:moor/ffi.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../table/cart_table.dart';
import '../table/user_table.dart';

part 'db_manager.g.dart';

openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Users, Carts])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  int get schemaVersion => 1;

  // Add user
  Future insertUser(User user) async {
    var checkUser = await getAllUser();
    Logger().wtf(checkUser.length);
    if (checkUser.length > 0) {
      await deleteUser();
    }
    var checkUser1 = await getAllUser();
    Logger().e(checkUser1.length);
    return await into(users).insertOnConflictUpdate(user);
  }

  // Get user
  Future getUser() async {
    var result = await select(users).getSingleOrNull();
    return result;
  }

  // Get all user
  Future getAllUser() async {
    var result = await select(users).get();
    Logger().wtf(result);
    return result;
  }

  // Delete user
  Future deleteUser() async {
    return await delete(users).go();
  }

  // Update user
  Future updateUser(User user) async {
    Logger().i(user);
    return await update(users).replace(user);
  }

  // Insert Cart
  Future insertCart(Cart cart) async {
    Logger().i(cart);
    return await into(carts).insertOnConflictUpdate(cart);
  }

  // Delete Cart
  Future deleteCart(Cart cart) async {
    Logger().i(cart);
    return await delete(carts).delete(cart);
  }

  // Clear Cart
  Future clearCart() async {
    return await delete(carts).go();
  }

  // Update cart
  Future updateCart(Cart cart) async {
    Logger().i(cart);
    return await update(carts).replace(cart);
  }

  // Get all Cart
  Future getAllCart() async {
    var result = await select(carts).get();
    Logger().wtf(result);
    return result;
  }

  // Get Where cart id is the same
  Future getWhereIdCart(String cartId) async {
    List<Cart> result = await getAllCart();
    if (result.isEmpty) {
      return null;
    }
    for (var item in result) {
      if (item.itemId == cartId) {
        Logger().i(item);
        return item;
      }
    }
    return null;
  }
}
