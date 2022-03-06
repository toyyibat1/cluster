import 'package:cluster/src/core/utilities/base_change_notfier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgentController extends BaseChangeNotifier {
  AgentController(this._read);

  final Reader _read;

  bool _showoverdueLoanVisible = false;

  bool get showoverdueLoanVisible => _showoverdueLoanVisible;

  void toggleOverdueLoanVisibilty() {
    _showoverdueLoanVisible = !_showoverdueLoanVisible;
    setState();
  }

  bool _showdueLoanVisible = false;

  bool get showdueLoanVisible => _showdueLoanVisible;

  void toggledueLoanVisibilty() {
    _showdueLoanVisible = !_showdueLoanVisible;
    setState();
  }

  bool _showactiveLoanVisible = false;

  bool get showactiveLoanVisible => _showactiveLoanVisible;

  void toggleactiveLoanVisibilty() {
    _showactiveLoanVisible = !_showactiveLoanVisible;
    setState();
  }

  bool _showinactiveLoanVisible = false;

  bool get showinactiveLoanVisible => _showinactiveLoanVisible;

  void toggleinactiveLoanVisibilty() {
    _showinactiveLoanVisible = !_showinactiveLoanVisible;
    setState();
  }
}

final agentControllerProvider = ChangeNotifierProvider(
  (ref) => AgentController(ref.read),
);
