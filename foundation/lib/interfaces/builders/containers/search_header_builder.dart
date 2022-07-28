import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SearchHeaderBuilder {
  @override
  Widget call() {
    return GetIt.I.get<SearchHeaderContainerInterface>();
  }
}

abstract class SearchHeaderContainerInterface extends Widget {}
