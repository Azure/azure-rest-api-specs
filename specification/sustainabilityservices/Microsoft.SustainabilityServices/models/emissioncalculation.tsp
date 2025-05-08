import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";
import "./othermodels.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace Microsoft.SustainabilityServices;

@doc("Calculation request.")
model EmissionCalculationRequest {
  @doc("Time stamp.")
  timeStamp?: utcDateTime;

  @doc("Calculation model id to be used. Use listCalculationModels API to get the list of all calculation models and choose the appropriate model based on the usecase.")
  calculationModelId: uuid;

  @doc("Assessment report version to be used in the calculation. If no arVersion is specified in the payload, AR4 version is the default version")
  arVersion?: ArVersions = ArVersions.AR4;

  @doc("List of activities on which the calculation is to be performed.")
  activities: EmissionActivity[];
}

@doc("The output of a calculation.")
model EmissionCalculationResult {
  @doc("Calculation summary.")
  summary: CalculationSummary;

  @doc("Calculation error details.")
  errorDetails: CalculationErrorDetails[];

  @doc("Calculated emissions from the activities.")
  activityEmissionOutput: ActivityEmissionOutput[];
}

@doc("Logical representation of the emission calculation that runs the calculation methodology bringing activity data and emission factors together.")
@resource("calculation-models")
model CalculationModel {
  @doc("Entity name.")
  entityName: string;

  @doc("Calculation model ID.")
  @key("calculationModelId")
  @visibility(Lifecycle.Read)
  calculationModelId: uuid;

  @doc("Calculation flow json.")
  calculationFlowJson?: string;

  @doc("Calculation method or model used to calculate emissions, as recommended by protocol.")
  calculationMethod?: string;

  @doc("Data definition of source.")
  dataDefinitionId?: LookupField;

  @doc("Document reference.")
  documentationReference?: string;

  @doc("Emission calculation ID.")
  emissionCalculationId: uuid;

  @doc("Emission source.")
  emissionSource: LookupField;

  @doc("Model JSON version.")
  modelJsonVersion?: string;

  @doc("Calculation model name.")
  name: string;

  @doc("Sustainability module.")
  sustainabilitymodule?: LookupField;

  @doc("Model type.")
  type: string;
}

@doc("Describes the summary of the calculation.")
model CalculationSummary {
  @doc("Calculation status.")
  status: CalculationStatusEnum;

  @doc("Total number of successful activities.")
  successfulActivities: int64;

  @doc("Total number of failed activities.")
  failedActivities: int64;

  @doc("Total number of excluded activities.")
  excludedActivities: int64;

  @doc("Total number of processed activities.")
  processedActivities: int64;
}

@doc("Output emission of the activity")
model ActivityEmissionOutput {
  @doc("Activity ID.")
  id: EmissionActivity.id;

  @doc("Activity emissions for the activity.")
  emissions: GhgEmissions[];
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type"
@doc("Activity.")
@resource("activities")
model EmissionActivity {
  @minLength(1)
  @doc("Activity ID.")
  @key("id")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  id: uuid;

  @doc("Activity data.")
  activityData: Record<unknown>;
}

@doc("Emissions for the activity.")
model GhgEmissions {
  @doc("CH4 emission.")
  ch4?: float32;

  @doc("CH4 emissions unit.")
  ch4Unit?: string;

  @doc("CO2 emissions.")
  co2?: float32;

  @doc("CO2 emissions unit.")
  co2Unit?: string;

  @doc("CO2e emissions.")
  co2e?: float32;

  @doc("CO2e emissions unit.")
  co2eUnit?: string;

  @doc("CO2emt emissions.")
  co2emt?: float32;

  @doc("HFCs emissions.")
  hfcs?: float32;

  @doc("HFCs emissions unit.")
  hfcsUnit?: string;

  @doc("N2O emissions.")
  n2o?: float32;

  @doc("N2O emissions unit.")
  n2oUnit?: string;

  @doc("NF3 emissions.")
  nf3?: float32;

  @doc("NF3 emissions unit.")
  nf3Unit?: string;

  @doc("PFCs emissions.")
  pfcs?: float32;

  @doc("PFCs emissions unit.")
  pfcsUnit?: string;

  @doc("Other GHG emissions.")
  otherGhgs?: float32;

  @doc("Other GHG emissions unit.")
  otherGhgsUnit?: string;

  @doc("SF6 emissions.")
  sf6?: float32;

  @doc("SF6 emissions unit.")
  sf6Unit?: string;

  @doc("Is market based.")
  isMarketBased?: boolean;

  @doc("Is biogenic.")
  isBiogenic?: boolean;

  @doc("Emission calculation model used for the calculation.")
  emissionCalculationModel?: string;

  @doc("Factor library used for the calculation.")
  calculationLibrary?: string;

  @doc("Emission factor used for the calculation.")
  emissionFactor?: string;

  @doc("Actual quantity of the activity responsible for the emission. For example, the actual quantity for a business trip involving a hotel stay might be the number of nights stayed multiplied by the estimation factor.")
  adjustedActualQuantity?: string;

  @doc("Actual quantity unit.")
  adjustedActualQuantityUnit?: string;
}

@error
@doc("Details of the error in calculation")
model CalculationErrorDetails {
  @doc("Activity ID.")
  activityId: EmissionActivity.id;

  @doc("Activity name.")
  activityName: string;

  @doc("Error message.")
  message: string;

  @doc("Error code.")
  code: string;
}
