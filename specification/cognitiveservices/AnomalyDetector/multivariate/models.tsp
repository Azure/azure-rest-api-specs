import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace AnomalyDetector.Multivariate;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("Field that indicates how missing values will be filled.")
enum FillNAMethod {
  Previous,
  Subsequent,
  Linear,
  Zero,
  Fixed,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
enum MultivariateBatchDetectionStatus {
  Created: "CREATED",
  Running: "RUNNING",
  Ready: "READY",
  Failed: "FAILED",
}

@doc("Data schema of the input data source. The default is OneTable.")
enum DataSchema {
  @doc("OneTable means that your input data is in one CSV file, which contains one time stamp column and several variable columns. The default DataSchema value is OneTable.")
  OneTable,

  @doc("MultiTable means that your input data is separated in multiple CSV files. Each file contains one time stamp column and one variable column, and the CSV file name should indicate the name of the variable. The default DataSchema value is OneTable.")
  MultiTable,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
enum AlignMode {
  Inner,
  Outer,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
enum ModelStatus {
  @doc("The model has been created. Training has been scheduled but not yet started.")
  Created: "CREATED",

  @doc("The model is being trained.")
  Running: "RUNNING",

  @doc("The model has been trained and is ready to be used for anomaly detection.")
  Ready: "READY",

  @doc("The model training failed.")
  Failed: "FAILED",
}

@doc("Detection results for the resultId value.")
@resource("multivariate/detect-batch")
model MultivariateDetectionResult {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
  @doc("Result identifier that's used to fetch the results of an inference call.")
  @key
  resultId: uuid;

  @doc("Multivariate anomaly detection status.")
  summary: MultivariateBatchDetectionResultSummary;

  @doc("Detection result for each time stamp.")
  results: AnomalyState[];
}

@doc("Multivariate anomaly detection status.")
model MultivariateBatchDetectionResultSummary {
  @doc("Status of detection results.")
  status: MultivariateBatchDetectionStatus;

  @doc("Error message when detection fails.")
  errors?: ErrorResponse[];

  @doc("Variable status.")
  variableStates?: VariableState[];

  @doc("""
Detection request for batch inference. This is an asynchronous inference that
will need another API to get detection results.
""")
  setupInfo: MultivariateBatchDetectionOptions;
}

@doc("Error information that the API returned.")
@error
model ErrorResponse {
  @doc("Error code.")
  code: string;

  @doc("Message that explains the error that the service reported.")
  message: string;
}

@doc("Variable status.")
model VariableState {
  @doc("Variable name in variable states.")
  variable?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Service uppercases common acronyms like NA."
  @doc("Proportion of missing values that need to be filled by fillNAMethod.")
  @minValue(0.0)
  @maxValue(1.0)
  filledNARatio?: float32;

  @doc("Number of effective data points before fillNAMethod is applied.")
  effectiveCount?: int32;

  @doc("First valid time stamp with a value of input data.")
  firstTimestamp?: utcDateTime;

  @doc("Last valid time stamp with a value of input data.")
  lastTimestamp?: utcDateTime;
}

@doc("""
Detection request for batch inference. This is an asynchronous inference that
will need another API to get detection results.
""")
model MultivariateBatchDetectionOptions {
  @doc("""
Source link to the input data to indicate an accessible Azure Storage URI.
It either points to an Azure Blob Storage folder or points to a CSV file in
Azure Blob Storage, based on your data schema selection. The data schema should
be exactly the same as those used in the training phase. The input data must
contain at least slidingWindow entries preceding the start time of the data
to be detected.
""")
  dataSource: url;

  @doc("""
Number of top contributed variables for one anomalous time stamp in the response.
""")
  topContributorCount?: int32 = 10;

  @doc("""
Start date/time of data for detection, which should
be in ISO 8601 format.
""")
  startTime: utcDateTime;

  @doc("""
End date/time of data for detection, which should
be in ISO 8601 format.
""")
  endTime: utcDateTime;
}

@doc("Anomaly status and information.")
model AnomalyState {
  @doc("Time stamp for this anomaly.")
  timestamp: utcDateTime;

  @doc("Detailed value of this anomalous time stamp.")
  value?: AnomalyValue;

  @doc("Error message for the current time stamp.")
  errors?: ErrorResponse[];
}

@doc("Detailed information of the anomalous time stamp.")
model AnomalyValue {
  @doc("True if an anomaly is detected at the current time stamp.")
  isAnomaly: boolean;

  @doc("""
Indicates the significance of the anomaly. The higher the severity, the more
significant the anomaly is.
""")
  @minValue(0.0)
  @maxValue(1.0)
  severity: float32;

  @doc("""
Raw anomaly score of severity, to help indicate the degree of abnormality.
""")
  @minValue(0.0)
  @maxValue(2.0)
  score: float32;

  @doc("Interpretation of this anomalous time stamp.")
  interpretation?: AnomalyInterpretation[];
}

@doc("Interpretation of the anomalous time stamp.")
model AnomalyInterpretation {
  @doc("Variable.")
  variable?: string;

  @doc("""
This score shows the percentage that contributes to the anomalous time stamp. It's a
number between 0 and 1.
""")
  contributionScore?: float32;

  @doc("Correlation changes among the anomalous variables.")
  correlationChanges?: CorrelationChanges;
}

@doc("Correlation changes among the anomalous variables.")
model CorrelationChanges {
  @doc("Correlated variables that have correlation changes under an anomaly.")
  changedVariables?: string[];
}

@doc("""
Training result of a model, including its status, errors, and diagnostics
information.
""")
model ModelInfo {
  @doc("""
Source link to the input data to indicate an accessible Azure Storage URI.
It either points to an Azure Blob Storage folder or points to a CSV file in
Azure Blob Storage, based on your data schema selection.
""")
  dataSource: url;

  @doc("""
Data schema of the input data source. The default
is OneTable.
""")
  dataSchema?: DataSchema;

  @doc("""
Start date/time of training data, which should be
in ISO 8601 format.
""")
  startTime: utcDateTime;

  @doc("""
End date/time of training data, which should be
in ISO 8601 format.
""")
  endTime: utcDateTime;

  @doc("""
Display name of the model. Maximum length is 24
characters.
""")
  @maxLength(24)
  displayName?: string;

  @doc("""
Number of previous time stamps that will be used to
detect whether the time stamp is an anomaly or not.
""")
  slidingWindow?: int32;

  @doc("Manner of aligning multiple variables.")
  alignPolicy?: AlignPolicy;

  @doc("Model status.")
  @visibility("read")
  status?: ModelStatus;

  @doc("Error messages after failure to create a model.")
  @visibility("read")
  errors?: ErrorResponse[];

  @doc("Diagnostics information to help inspect the states of a model or variable.")
  @visibility("read")
  diagnosticsInfo?: DiagnosticsInfo;
}

@doc("Manner of aligning multiple variables.")
model AlignPolicy {
  @doc("""
Field that indicates how to align different variables to the same
time range.
""")
  alignMode?: AlignMode;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Service uppercases common acronyms like NA."
  @doc("""
Field that indicates how missing values will be filled.
""")
  fillNAMethod?: FillNAMethod;

  @doc("Field that's required when fillNAMethod is Fixed.")
  paddingValue?: float32;
}

@doc("Diagnostics information to help inspect the states of a model or variable.")
model DiagnosticsInfo {
  @doc("Model status.")
  modelState?: ModelState;

  @doc("Variable status.")
  variableStates?: VariableState[];
}

@doc("Model status.")
model ModelState {
  @doc("""
Number of passes of the entire training dataset that the
algorithm has completed.
""")
  epochIds?: int32[];

  @doc("""
List of metrics used to assess how the model fits the training data for each
epoch.
""")
  trainLosses?: float32[];

  @doc("""
List of metrics used to assess how the model fits the validation set for each
epoch.
""")
  validationLosses?: float32[];

  @doc("Latency for each epoch.")
  latenciesInSeconds?: float32[];
}

@doc("Response of getting a model.")
@resource("multivariate/models")
model AnomalyDetectionModel {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Properties in response-only schemas should not be marked readOnly"
  @doc("Model identifier.")
  @key
  modelId: uuid;

  @doc("Date and time (UTC) when the model was created.")
  createdTime: utcDateTime;

  @doc("Date and time (UTC) when the model was last updated.")
  lastUpdatedTime: utcDateTime;

  @doc("""
Training result of a model, including its status, errors, and diagnostics
information.
""")
  modelInfo?: ModelInfo;
}

@doc("Response of listing models.")
@pagedResult
model ModelList {
  @doc("List of models.")
  @items
  models: AnomalyDetectionModel[];

  @doc("Number of trained multivariate models.")
  currentCount: int32;

  @doc("Maximum number of models that can be trained for this Anomaly Detector resource.")
  maxCount: int32;

  @doc("Link to fetch more models.")
  @nextLink
  nextLink?: string;
}

@doc("Request of the last detection.")
model MultivariateLastDetectionOptions {
  @doc("""
Contains the inference data, including the name, time stamps (ISO 8601), and
values of variables.
""")
  variables: VariableValues[];

  @doc("""
Number of top contributed
variables for one anomalous time stamp in the response. The default is
10.
""")
  topContributorCount?: int32 = 10;
}

@doc("Variable values.")
model VariableValues {
  @doc("Variable name of the last detection request.")
  variable: string;

  @doc("Time stamps of the last detection request.")
  timestamps: string[];

  @doc("Values of variables.")
  values: float32[];
}

@doc("Results of the last detection.")
model MultivariateLastDetectionResult {
  @doc("Variable status.")
  variableStates?: VariableState[];

  @doc("Anomaly status and information.")
  results?: AnomalyState[];
}

@doc("Error response.")
@error
model ResponseError {
  @header("x-ms-error-code")
  @doc("Error code.")
  msErrorCode?: string;

  ...ErrorResponse;
}
