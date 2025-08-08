using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Workloads;

@parentResource(InstanceHealthDefinition)
model SignalDefinition is ProxyResource<SignalDefinitionProperties> {
  ...ResourceNameParameter<
    Resource = SignalDefinition,
    NamePattern = ResourceNamePattern
  >;
}

/** Signal definition properties */
@discriminator("signalKind")
model SignalDefinitionProperties is ResourceCommonProperties {
  /** The signal kind */
  signalKind: SignalKind;

  /** The signal evaluation interval. Allowed values:  PT1M, PT5M, PT10M, PT30M, PT1H, PT2H */
  refreshInterval: string;

  /** The signal data unit. Ex: Bytes, MilliSeconds, Percent, Count */
  @minLength(1)
  @maxLength(100)
  dataUnit?: string;

  /** The evaluation rule */
  evaluationRule: EvaluationRule;
}

/** Azure resource metric signal definition properties */
model ResourceMetricSignalDefinitionProperties
  extends SignalDefinitionProperties {
  /** The signal kind */
  signalKind: SignalKind.AzureResourceMetric;

  /** The metric namespace */
  @minLength(1)
  @maxLength(256)
  metricNamespace: string;

  /** The metric name */
  @minLength(1)
  @maxLength(256)
  metricName: string;

  /** Time range of signal. ISO duration format like PT10M */
  @minLength(1)
  @maxLength(100)
  timeGrain: string;

  /** Type of aggregation to apply to the metric */
  aggregationType: MetricsAggregationType;
}

@armResourceOperations
interface SignalDefinitions {
  /** Get the signal definition */
  get is ArmResourceRead<SignalDefinition>;

  /** Create or replace the signal definition */
  create is ArmResourceCreateOrReplaceAsync<SignalDefinition>;

  /** Delete the signal definition */
  delete is ArmResourceDeleteWithoutOkAsync<SignalDefinition>;

  /** List signal definitions by parent resource */
  @list
  listByHealthDefinition is ArmResourceListByParent<SignalDefinition>;
}
