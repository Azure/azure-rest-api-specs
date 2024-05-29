import "../HealthInsights.Common/model.common.fhir.elements.tsp";

namespace AzureHealthInsights;

using TypeSpec.Versioning;

@doc("A Radiology Insights inference types.")
union RadiologyInsightsInferenceType {
  string,

  @doc("Age mismatch inference type")
  AgeMismatch: "ageMismatch",

  @doc("Laterality discrepancy inference type")
  LateralityDiscrepancy: "lateralityDiscrepancy",

  @doc("Sex mismatch inference type")
  SexMismatch: "sexMismatch",

  @doc("Complete order discrepancy inference type")
  CompleteOrderDiscrepancy: "completeOrderDiscrepancy",

  @doc("Limited order discrepancy inference type")
  LimitedOrderDiscrepancy: "limitedOrderDiscrepancy",

  @doc("Finding inference type")
  Finding: "finding",

  @doc("Critical finding inference type")
  CriticalResult: "criticalResult",

  @doc("Recommendation inference type")
  FollowupRecommendation: "followupRecommendation",

  @doc("Followup Communication inference type")
  FollowupCommunication: "followupCommunication",

  @doc("Radiology Procedure inference type")
  RadiologyProcedure: "radiologyProcedure",

  @added(ApiVersion.v2024_10_01)
  @doc("Scoring and assessment inference type")
  ScoringAndAssessment: "scoringAndAssessment",

  @added(ApiVersion.v2024_10_01)
  @doc("Guidance inference type")
  Guidance: "guidance",

  @added(ApiVersion.v2024_10_01)
  @doc("Guidance measure inference type")
  QualityMeasure: "qualityMeasure",
}

@doc("Laterality discrepancy type")
union LateralityDiscrepancyType {
  string,

  @doc("Mismatch between order and text")
  OrderLateralityMismatch: "orderLateralityMismatch",

  @doc("Contradiction in text")
  TextLateralityContradiction: "textLateralityContradiction",

  @doc("Missing laterality in text")
  TextLateralityMissing: "textLateralityMissing",
}

@doc("consider using ClinicalCodeableConcept system: http://unitsofmeasure.org")
union MeasureUnitType {
  string,

  @doc("Undefined measure unit type")
  Undefined: "undefined",

  @doc("Rate measure unit type")
  Rate: "rate",

  @doc("Concentration measure unit type")
  Concentration: "concentration",

  @doc("Mass measure unit type")
  Mass: "mass",

  @doc("Time measure unit type")
  Time: "time",

  @doc("Length measure unit type")
  Length: "length",

  @doc("Area measure unit type")
  Area: "area",

  @doc("Volume measure unit type")
  Volume: "volume",

  @doc("Amount measure unit type")
  Amount: "amount",

  @doc("Percentage measure unit type")
  Percentage: "percentage",

  @doc("Pressure measure unit type")
  Pressure: "pressure",

  @doc("Temperature measure unit type")
  Temperature: "temperature",

  @doc("Velocity measure unit type")
  Velocity: "velocity",

  @doc("Angle measure unit type")
  Angle: "angle",

  @doc("Energy measure unit type")
  Energy: "energy",

  @doc("Radioactivity measure unit type")
  Radioactivity: "radioactivity",
}

@doc("Medical Professional Type")
union MedicalProfessionalType {
  string,

  @doc("Unknown medical professional type")
  Unknown: "unknown",

  @doc("Doctor medical professional type")
  Doctor: "doctor",

  @doc("Nurse medical professional type")
  Nurse: "nurse",

  @doc("Technician medical professional type")
  Midwife: "midwife",

  @doc("Technician medical professional type")
  PhysicianAssistant: "physicianAssistant",
}

@doc("Laterality type")
union LateralityType {
  string,

  @doc("Left laterality type")
  Left: "left",

  @doc("Right laterality type")
  Right: "right",

  @doc("Right and left laterality type")
  Bilateral: "bilateral",

  @doc("Unilateral laterality type")
  Unilateral: "unilateral",
}

@doc("Recommendation finding status")
union RecommendationFindingStatusType {
  string,

  @doc("Present finding status")
  Present: "present",

  @doc("Differential finding status")
  Differential: "differential",

  @doc("Rule out finding status")
  RuleOut: "ruleOut",

  @doc("Conditional finding status")
  Conditional: "conditional",
}

@doc("""
DiseaseCourseType value set system url = http://github.com/Azure/HealthInsights/RadiologyInsights/ValueSet/condition-course
The below values can be used for binding in DiseaseCourseExtension.valueCodeableConcept
""")
union DiseaseCourseType {
  string,

  @doc("Acute")
  Acute: "acute",

  @doc("Chronic")
  Chronic: "chronic",

  @doc("Acute on chronic")
  AcuteOnChronic: "acuteOnChronic",

  @doc("Intermittent")
  Intermittent: "intermittent",

  @doc("Relapsing")
  Relapsing: "relapsing",

  @doc("Prolonged")
  Prolonged: "prolonged",

  @doc("Paroxysmal")
  Paroxysmal: "paroxysmal",

  @doc("Seasonal course")
  SeasonalCourse: "seasonalCourse",
}

@added(ApiVersion.v2024_10_01)
@doc("Guidance recommendations found types, indicating whether one or more recommendations have been found, and if not, if more information is needed for finding them.")
union GuidanceRecommendationsFoundType {
  string,

  @doc("recommendation_needed means that at least one recommendation is in array 'recommendations'.")
  RecommendationNeeded: "recommendationNeeded",

  @doc("noRecommendationNeeded means that array 'recommendations' is null, and the code found that there are no recommendations.")
  NoRecommendationNeeded: "noRecommendationNeeded",

  @doc("more_info_needed_to_determine_recommendations means that array 'recommendations' is null, but there might be recommendations that the code was not able to find.")
  MoreInfoNeededToDetermineRecommendations: "moreInfoNeededToDetermineRecommendations",
}

@added(ApiVersion.v2024_10_01)
@doc("Whether the document is compliant.")
union QualityMeasureComplianceType {
  string,

  @doc("not eligible")
  NotEligible: "notEligible",

  @doc("performance not met")
  PerformanceNotMet: "performanceNotMet",

  @doc("performance met")
  PerformanceMet: "performanceMet",

  @doc("denominator exception")
  DenominatorException: "denominatorException",
}

@added(ApiVersion.v2024_10_01)
@doc("Mips types that can be checked by the engine.")
union QualityMeasureType {
  string,

  @doc("Mips 76")
  Mips76: "mips76",

  @doc("Mips 147")
  Mips147: "mips147",

  @doc("Mips 195")
  Mips195: "mips195",

  @doc("Mips 360")
  Mips360: "mips360",

  @doc("Mips 364")
  Mips364: "mips364",

  @doc("Mips 405")
  Mips405: "mips405",

  @doc("Mips 406")
  Mips406: "mips406",

  @doc("Mips 436")
  Mips436: "mips436",

  @doc("Mips 145")
  Mips145: "mips145",

  @doc("Acrad 36")
  Acrad36: "acrad36",

  @doc("Acrad 37")
  Acrad37: "acrad37",

  @doc("Acrad 38")
  Acrad38: "acrad38",

  @doc("Acrad 39")
  Acrad39: "acrad39",

  @doc("Acrad 40")
  Acrad40: "acrad40",

  @doc("Acrad 41")
  Acrad41: "acrad41",

  @doc("Acrad 42")
  Acrad42: "acrad42",
}
