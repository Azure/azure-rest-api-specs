import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Monitor;

// Hide SloView (sliSignalPreview) operations from public SDK generation.
// The SloView interface and its exclusively-used models (SignalPreviewSliProperties,
// PreviewType, KqlmQueryResult, etc.) will be marked as internal.
// Shared models (EvaluationType, BaselineProperties, Signal, etc.) remain public
// because they are also used by the public Slis interface.
@@access(SloView.sliSignalPreview, Access.internal);

@@clientName(Microsoft.Monitor, "MonitorSlisMgmtClient", "python");

@@clientName(AmwAccount, "SliAmwAccount", "csharp");
@@clientName(Baseline, "SliBaseline", "csharp");
@@clientName(BaselineProperties, "SliBaselineProperties", "csharp");
@@clientName(Category, "SliCategory", "csharp");
@@clientName(Condition, "SliCondition", "csharp");
@@clientName(ConditionOperator, "SliConditionOperator", "csharp");
@@clientName(
  EvaluationCalculationType,
  "SliEvaluationCalculationType",
  "csharp"
);
@@clientName(EvaluationType, "SliEvaluationType", "csharp");
@@clientName(ExecutionState, "SliExecutionState", "csharp");
@@clientName(Metric, "SliMetric", "csharp");
@@clientName(ProvisioningState, "SliProvisioningState", "csharp");
@@clientName(SamplingType, "SliSamplingType", "csharp");
@@clientName(ScalarFunction, "SliScalarFunction", "csharp");
@@clientName(Signal, "SliSignal", "csharp");
@@clientName(SignalSource, "SliSignalSource", "csharp");
@@clientName(SpatialAggregation, "SliSpatialAggregation", "csharp");
@@clientName(SpatialAggregationType, "SliSpatialAggregationType", "csharp");
@@clientName(TemporalAggregation, "SliTemporalAggregation", "csharp");
@@clientName(TemporalAggregationType, "SliTemporalAggregationType", "csharp");
@@clientName(Sli, "MonitorSli", "csharp");
@@clientName(SliResource, "MonitorSliProperties", "csharp");
@@clientName(
  SliResource.streamingRuleLastUpdatedTimestamp,
  "StreamingRuleLastUpdatedOn",
  "csharp"
);
@@clientName(SliResource.enableAlert, "IsAlertEnabled", "csharp");
@@clientName(Slis, "SliOperations", "csharp");
