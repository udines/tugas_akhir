import 'package:flutter/material.dart';
import 'package:tugas_akhir/data/agent_data.dart';

class AgentDetail extends StatelessWidget {
  final Agent agent;

  AgentDetail({Key key, @required this.agent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(agent.name),
      )
    );
  }
}