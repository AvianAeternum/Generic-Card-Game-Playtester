import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

BuildContext? tempContext;

BuildContext ctx() => (Get.context ?? tempContext)!;

void blocEvent<T extends Bloc>(dynamic event) => ctx().read<T>().add(event);
