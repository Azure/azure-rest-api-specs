import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Monitor;
/**
 * Investigation resource, including result.
 */
@doc("An investigation definition.")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
@removed(Microsoft.Monitor.Versions.v2024_10_01)
model InvestigationResource is ExtensionResource<InvestigationProperties> {
  /**
   * The name of the investigation.
   */
  @doc("The name of the investigation.")
  @path
  @key("investigationId")
  @segment("investigations")
  @visibility("read")
  // Should be 255-2 charachters long, without any of these invalid chars- :@/#%&+*<>?\\
  @pattern("^[^:@/#&+*<>\\?]{2,253}$")
  name: string;
}

/**
 * Filter operator for dimensions or tags.
 */
@doc("Filter operator for dimensions or tags")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
@removed(Microsoft.Monitor.Versions.v2024_10_01)
union FilterOperator {
  @doc("Value is included in the values specified")
  include: "include",

  @doc("Exclude the values specified")
  exclude: "exclude",

  @doc("Checks values that starts with the values specified")
  startsWith: "startsWith",

  string,
}

/**
 * The sensitivity which controls the investigation operation.
 */
@doc("The sensitivity which controls the investigation operation.")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
@removed(Microsoft.Monitor.Versions.v2024_10_01)
union Sensitivity {
  @doc("Low sensitivity for the investigation")
  low: "low",

  @doc("Medium sensitivity for the investigation")
  medium: "medium",

  @doc("High sensitivity for the investigation")
  high: "high",

  string,
}

/**
 * Denotes the state of the investigation operation.
 */
@doc("Denotes the state of the investigation operation.")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
@removed(Microsoft.Monitor.Versions.v2024_10_01)
union InvestigationProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("No investigation operation state")
  None: "None",

  @doc("Running investigation operation state")
  Running: "Running",
}

/**
 * The health state of the investigation's scope.
 */
@doc("The health state of the investigation's scope")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
@removed(Microsoft.Monitor.Versions.v2024_10_01)
union HealthState {
  @doc("Investigation health state is unknown")
  `unknown`: "unknown",

  @doc("Investigation health state is healthy")
  healthy: "healthy",

  @doc("Investigation health state is degraded")
  degraded: "degraded",

  @doc("Investigation health state is unhealthy")
  unhealthy: "unhealthy",

  string,
}

/**
 * The confidence level of the investigation result.
 */
@doc("The confidence level of the investigation result")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
@removed(Microsoft.Monitor.Versions.v2024_10_01)
union ConfidenceLevel {
  @doc("Investigation result confidence level is unknown")
  `unknown`: "unknown",

  @doc("Investigation result confidence level is low")
  low: "low",

  @doc("Investigation result confidence level is medium")
  medium: "medium",

  @doc("Investigation result confidence level is high")
  high: "high",

  string,
}

/**
 * The type of the result returned by the investigation.
 */
@doc("The type of the result returned by the investigation")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
@removed(Microsoft.Monitor.Versions.v2024_10_01)
union ResultType {
  @doc("Resource health result")
  resourceHealth: "resourceHealth",

  @doc("Correlated metric anomalies of the scope resource")
  correlatedMetricAnomalies: "correlatedMetricAnomalies",

  @doc("Anomaly result based on Azure metric provided by Microsoft.Insights/metrics")
  azureMetricAnomaly: "azureMetricAnomaly",

  @doc("Anomaly result based on metric provided by Prometheus query")
  prometheusMetricAnomaly: "prometheusMetricAnomaly",

  @doc("Anomaly result based on anomalies in the application telemetry")
  correlatedApplicationAnomalies: "correlatedApplicationAnomalies",

  @doc("Anomaly result based on unusual or unexpected event identified in logs")
  abnormalEvent: "abnormalEvent",

  @doc("Anomaly result identified through patterns in tracing data")
  tracePatternAnomalies: "tracePatternAnomalies",

  @doc("Anomaly result identified through patterns in transaction data")
  transactionPatternAnomalies: "transactionPatternAnomalies",

  string,
}

/**
 * The type of the scope of the investigation.
 */
@doc("The type of the scope of the investigation")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
@removed(Microsoft.Monitor.Versions.v2024_10_01)
union InvestigationScopeType {
  @doc("The investigation ran on a subscription level")
  subscription: "subscription",

  @doc("The investigation ran on a resource level")
  resource: "resource",

  @doc("The investigation ran on resource correlated metrics")
  correlatedMetricAnomalies: "correlatedMetricAnomalies",

  @doc("The investigation ran on a metric anomaly")
  correlatedMetricAnomaly: "correlatedMetricAnomaly",

  @doc("The investigation ran on resource application anomalies")
  correlatedApplicationAnomalies: "correlatedApplicationAnomalies",

  @doc("The investigation identified unusual or unexpected events through logs analysis.")
  abnormalEvent: "abnormalEvent",

  @doc("The investigation analyzed trace data for patterns that deviate from expected behavior.")
  tracePatternAnomalies: "tracePatternAnomalies",

  @doc("The investigation analyzed transaction data for patterns that deviate from expected behavior.")
  transactionPatternAnomalies: "transactionPatternAnomalies",

  string,
}

/**
 * The investigation scope source type.
 */
@doc("The investigation scope source type.")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
@removed(Microsoft.Monitor.Versions.v2024_10_01)
union ScopeSourceType {
  @doc("Automatic scope")
  automatic: "automatic",

  @doc("User defined scope")
  userDefined: "userDefined",

  string,
}

/**
 * Investigation properties with the investigation result.
 */
@doc("Investigation properties with the investigation result")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
@removed(Microsoft.Monitor.Versions.v2024_10_01)
model InvestigationProperties {
  @doc("The target ARM resources which the investigation will use.")
  @extension("x-ms-identifiers", [])
  targets: string[];

  @doc("The display name of this investigation.")
  displayName: string;

  @doc("The ARM Id of a Microsoft.AlertsManagement/alerts resource related to this investigation.")
  alertId?: string;

  @doc("The impact time which the investigation ran on.")
  impactTime: utcDateTime;

  @doc("The run configuration for the investigation.")
  runConfiguration?: InvestigationRunConfiguration;

  @doc("Denotes the state of the investigation operation.")
  @visibility("read")
  provisioningState?: InvestigationProvisioningState;

  @doc("The investigation that ran on the given scope.")
  @visibility("read")
  investigation?: Investigation;
}

/**
 * The run configuration for the investigation.
 */
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
@removed(Microsoft.Monitor.Versions.v2024_10_01)
model InvestigationRunConfiguration {
  @doc("Hints used for the investigation run")
  @extension("x-ms-identifiers", [])
  hints?: Filter[];

  @doc("A list of filters to decide on the scope")
  @extension("x-ms-identifiers", [])
  tagScopeFilters?: Filter[];

  @doc("The time window to look back from impactTime. The format should be of a TimeSpan.")
  lookBackWindow?: string;

  @doc("Configure the investigation to run only on Target resource.")
  onlyInvestigateTargetResource?: boolean;

  @doc("The sensitivity which controls the investigation operation.")
  sensitivity?: Sensitivity;

  @doc("List of ARM resources to investigate.")
  @extension("x-ms-identifiers", [])
  investigationScope?: string[];
}

/**
 * Filter for dimensions or tags.
 */
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
@removed(Microsoft.Monitor.Versions.v2024_10_01)
model Filter {
  @doc("The name of the dimension or tag to filter on.")
  name?: string;

  @doc("Filter operator for dimensions or tags.")
  operator?: FilterOperator;

  @doc("The values to filter based on.")
  @extension("x-ms-identifiers", [])
  values?: string[];
}

/**
 * The investigation that ran on the given scope.
 */
@doc("The investigation that ran on the given scope.")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
@removed(Microsoft.Monitor.Versions.v2024_10_01)
model Investigation {
  @doc("The scope of which this investigation ran on.")
  scope?: string;

  @doc("The unique Id for this investigation (GUID format).")
  id?: string;

  @doc("The type of this investigation.")
  type?: InvestigationScopeType;

  @doc("The execution details of the investigation.")
  execution?: Execution;

  @doc("The investigation result.")
  @visibility("read")
  result?: InvestigationResult;

  @doc("Child investigations.")
  @extension("x-ms-identifiers", [])
  healthChecks?: Investigation[];
}

/**
 * The execution details of the investigation.
 */
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
@removed(Microsoft.Monitor.Versions.v2024_10_01)
model Execution {
  @doc("The time the investigation completed running")
  completedOn?: utcDateTime;

  @doc("Denotes the state of the investigation operation.")
  @visibility("read")
  status?: InvestigationProvisioningState;
}

/**
 * The investigation result.
 */
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
@removed(Microsoft.Monitor.Versions.v2024_10_01)
model InvestigationResult {
  @doc("The investigation scope source type.")
  scopeType?: ScopeSourceType;

  @doc("The investigation scope source resource id.")
  scopingSourceResourceId?: string;

  @doc("The health state of the investigation's scope.")
  healthState?: HealthState;

  @doc("The summary of the investigation resource.")
  summary?: string;

  @doc("The cause of the investigated issue.")
  cause?: string;

  @doc("The recommendation of the investigation.")
  recommendation?: string;

  @doc("The confidence level of the investigation result.")
  confidenceLevel?: ConfidenceLevel;

  @doc("The type of the result returned by the investigation.")
  resultType?: ResultType;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @doc("The details of the investigation result.")
  details?: Record<unknown>;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
@removed(Microsoft.Monitor.Versions.v2024_10_01)
@extension("x-ms-azure-resource", true)
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: Foundations.SystemData;
}

#suppress "@azure-tools/typespec-azure-resource-manager/improper-subscription-list-operation" "For backward compatibility"
@armResourceOperations(InvestigationResource)
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
@removed(Microsoft.Monitor.Versions.v2024_10_01)
interface Investigations {
  /**
   * Gets an investigation.
   */
  @doc("Returns the specific Investigation data.")
  @added(Microsoft.Monitor.Versions.v2024_01_01_preview)
  @removed(Microsoft.Monitor.Versions.v2024_10_01)
  getAtResource is ArmResourceRead<InvestigationResource>;

  /**
   * You can provide the template and parameters directly in the request or link to JSON files.
   */
  @doc("Create or Update an Investigation")
  @added(Microsoft.Monitor.Versions.v2024_01_01_preview)
  @removed(Microsoft.Monitor.Versions.v2024_10_01)
  createOrUpdateAtResource is ArmResourceCreateOrUpdateAsync<InvestigationResource>;

  /**
   * A template investigation that is currently running cannot be deleted.
   */
  @doc("Delete this Investigation.")
  @added(Microsoft.Monitor.Versions.v2024_01_01_preview)
  @removed(Microsoft.Monitor.Versions.v2024_10_01)
  deleteAtResource is ArmResourceDeleteSync<InvestigationResource>;

  /**
   * Get all the Investigations at the given resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Investigations_ListAtResource")
  @doc("Returns all the investigations of a specific resource.")
  @added(Microsoft.Monitor.Versions.v2024_01_01_preview)
  @removed(Microsoft.Monitor.Versions.v2024_10_01)
  listAtResource is ArmResourceListByParent<
    InvestigationResource,
    {
      ...Foundations.BaseParameters<InvestigationResource>;

      /**
       * The number of results to get. If null is passed, returns all Investigations.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Get all the Investigations at the given resource.
   */
  @doc("Returns all the investigations of a specific subscription.")
  @added(Microsoft.Monitor.Versions.v2024_01_01_preview)
  @removed(Microsoft.Monitor.Versions.v2024_10_01)
  listAtSubscription is ArmListBySubscription<
    InvestigationResource,
    {
      /**
       * The number of results to get. If null is passed, returns all Investigations.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

@@encodedName(Investigations.createOrUpdateAtResource::parameters.resource,
  "application/json",
  "investigation"
);
@@doc(Investigations.createOrUpdateAtResource::parameters.resource,
  "Investigation body to create/update"
);
