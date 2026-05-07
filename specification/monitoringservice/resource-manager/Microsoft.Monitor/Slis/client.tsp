import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API was moved to its own service."
namespace Microsoft.Monitor;

// Hide SloView (sliSignalPreview) operations from public SDK generation.
// The SloView interface and its exclusively-used models (SignalPreviewSliProperties,
// PreviewType, KqlmQueryResult, etc.) will be marked as internal.
// Shared models (EvaluationType, BaselineProperties, Signal, etc.) remain public
// because they are also used by the public Slis interface.
@@access(SloView.sliSignalPreview, Access.internal);

// Rename ambiguous/generic types to be SLI-prefixed in the C# SDK so that they
// are unambiguous within the broader Azure.ResourceManager.Monitor.* namespace
// family and don't collide with similarly named types in other Azure SDKs.
@@clientName(AmwAccount, "SliAmwAccount", "csharp");
@@clientName(Baseline, "SliBaseline", "csharp");
@@clientName(BaselineProperties, "SliBaselineProperties", "csharp");
@@clientName(Category, "SliCategory", "csharp");
@@clientName(Condition, "SliCondition", "csharp");
@@clientName(ConditionOperator, "SliConditionOperator", "csharp");
@@clientName(EvaluationCalculationType, "SliEvaluationCalculationType", "csharp");
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

// Per Azure SDK naming guidelines, DateTimeOffset properties must end in `On` or `At`.
@@clientName(SliResource.streamingRuleLastUpdatedTimestamp,
  "StreamingRuleLastUpdatedOn",
  "csharp"
);
