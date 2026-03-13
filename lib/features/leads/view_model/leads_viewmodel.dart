import 'package:flutter/material.dart';

class LeadsViewModel extends ChangeNotifier {

  String? pipelineStage;
  String? leadSource;
  String? status;
  String? purpose;
  String? agent;
  String? socialMediaValue;

  final pipelineStages = [
    "Select",
    "New",
    "Contacted",
    "Qualified",
    "Proposal",
    "Negotiation",
    "Won",
    "Lost"
  ];

  final leadSources = [
    "Select Source",
    "Social Media",
    "Referral",
    "Campaign"
  ];

  final statuses = [
    "Select One",
    "New",
    "Hot",
    "Warm",
    "Cold"
  ];

  final purposes = [
    "Select Purpose",
    "Flutter",
    "MERN",
    "DS",
    "DA",
    "DM",
    "UI/UX"
  ];

  final agents = [
    "Select Agent",
    "Linisha",
    "Anju",
    "Basila",
    "Chinju"
  ];
 

final List<String> socialMediaItems = [
  "Instagram",
  "Facebook",
  "LinkedIn",
  "Twitter",
];
  void setPipeline(String? value) {
    pipelineStage = value;
    notifyListeners();
  }

  void setSource(String? value) {
    leadSource = value;
    notifyListeners();
  }

  void setStatus(String? value) {
    status = value;
    notifyListeners();
  }

  void setPurpose(String? value) {
    purpose = value;
    notifyListeners();
  }

  void setAgent(String? value) {
    agent = value;
    notifyListeners();
  }

}