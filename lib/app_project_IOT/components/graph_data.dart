import 'package:flutter/material.dart';
import 'package:project_01/app_project_IOT/model/pet_feeder_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphData extends StatelessWidget {
  const GraphData({super.key, required this.data});
  final List<PetFeederModel> data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <LineSeries<PetFeederModel, String>>[
          LineSeries<PetFeederModel, String>(
              // Bind data source
              dataSource: <PetFeederModel>[...data],
              xValueMapper: (PetFeederModel dummy, _) => dummy.timeFeed.name,
              yValueMapper: (PetFeederModel dummy, _) => dummy.amount),
        ],
      ),
    );
  }
}
