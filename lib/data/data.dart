import 'package:flutter/material.dart';

class ProjectModel {
  final String? number;
  final String? job;
  final String? name;
  final String? title;
  final String? date;
  final String? client;
  final double? progress;
  final Color color;

  const ProjectModel({
    this.number,
    this.job,
    this.name,
    this.title,
    this.date,
    this.client,
    this.progress,
    this.color = const Color(0xFF37B34A),
  });

  @override
  String toString() {
    return 'ProjectModel{number: $number, job: $job, name: $name, title: $title, date: $date, client: $client, progress: $progress, color: $color}';
  }
}

const List<Color> listColor = <Color>[
  Color(0xFFF56287),
  Color(0xFF37B34A),
  Color(0xFF1488CC),
  Color(0xFFE0B719),
  Color(0xffB455FF),
  Color(0xff07BBC7),
  Color(0xffFF5A5A),
];

ProjectModel projectModel0 = ProjectModel(
  job: "UI / UX Design",
  name: "Mohammed Benmchich",
  title: "20% completed 19988 budget left",
  progress: 0.2,
  color: listColor[0],
);

ProjectModel projectModel1 = ProjectModel(
  job: "Product Design",
  name: "Mohammed Benmchich",
  title: "10% completed 19988 budget left",
  progress: 0.1,
  color: listColor[1],
);

ProjectModel projectModel2 = ProjectModel(
  job: "BackEnd Development",
  name: "Bilal Aboubi",
  title: "5% completed 19988 budget left",
  progress: 0.05,
  color: listColor[2],
);

ProjectModel projectModel3 = ProjectModel(
  job: "UI / UX",
  name: "Mohammed Benmchich",
  title: "60% completed 19988 budget left",
  progress: 0.6,
  color: listColor[3],
);

ProjectModel projectModel4 = ProjectModel(
  job: "Flutter Development",
  name: "Hamza Chaouki",
  title: "90% completed 19988 budget left",
  progress: 0.9,
  color: listColor[4],
);

ProjectModel projectModel5 = ProjectModel(
  job: "Flutter Development",
  name: "Hamza El Hirch",
  title: "100% completed 19988 budget left",
  progress: 1,
  color: listColor[5],
);

ProjectModel projectModel6 = ProjectModel(
  job: "Web Dev",
  name: "Bilal Aboubi",
  title: "15% completed 19988 budget left",
  progress: 0.5,
  color: listColor[6],
);

ProjectModel projectModel7 = ProjectModel(
  job: "Marketing",
  name: "Mohammed Benmchich",
  title: "34% completed 19988 budget left",
  progress: 0.34,
  color: listColor[0],
);

ProjectModel projectModel8 = ProjectModel(
  job: "Illustration",
  name: "Mohammed Benmchich",
  title: "66% completed 19988 budget left",
  progress: 0.66,
  color: listColor[1],
);

ProjectModel projectModel9 = ProjectModel(
  job: "Editing",
  name: "Mohammed Benmchich",
  title: "77% completed 19988 budget left",
  progress: 0.77,
  color: listColor[2],
);

List<ProjectModel> listProjects = <ProjectModel>[
  projectModel0,
  projectModel1,
  projectModel2,
  projectModel3,
  projectModel4,
  projectModel5,
  projectModel6,
  projectModel7,
  projectModel8,
  projectModel9,
];
