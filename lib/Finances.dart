import 'package:flutter/material.dart';

class Finances extends StatefulWidget {
  const Finances({Key? key}) : super(key: key);

  @override
  State<Finances> createState() => _FinancesState();
}

class _FinancesState extends State<Finances> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFEDE5D8),
      ),
    );
  }
}
