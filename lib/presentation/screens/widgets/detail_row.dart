import 'package:flutter/material.dart';

// lib/presentation/widgets/shared_widgets.dart


Widget DetailRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: const TextStyle(color: Colors.grey)),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
    ],
  );
}

