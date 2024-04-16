import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Monitor;
/**
 * Investigation resource, including result.
 */
@doc("An investigation definition.")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
model InvestigationResource is ExtensionResource<InvestigationProperties> {
  /**
   * The name of the investigation.
   */
  @doc("The name of the investigation.")
  @path
  @key("investigationId")
  @segment("investigations")
  @visibility("read")
  name: string;
}

/**
 * Filter operator for dimensions or tags.
 */
@doc("Filter operator for dimensions or tags")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
enum FilterOperator {
  @doc("Value is included in the values specified")
  include,

  @doc("Exclude the values specified")
  exclude,

  @doc("Checks values that starts with the values specified")
  startsWith,
}

/**
 * The sensitivity which controls the investigation operation.
 */
@doc("The sensitivity which controls the investigation operation.")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
enum Sensitivity {
  @doc("Low sensitivity for the investigation")
  low,

  @doc("Medium sensitivity for the investigation")
  medium,

  @doc("High sensitivity for the investigation")
  high,
}

/**
 * Denotes the state of the investigation operation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Denotes the state of the investigation operation.")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
enum InvestigationProvisioningState {
  @doc("No investigation operation state")
  none,

  @doc("Running investigation operation state")
  running,

  @doc("Investigation operation succeeded")
  succeeded,

  @doc("Investigation operation failed")
  failed,
}

/**
 * The health state of the investigation's scope.
 */
@doc("The health state of the investigation's scope")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
enum HealthState {
  @doc("Investigation health state is unknown")
  `unknown`,

  @doc("Investigation health state is healthy")
  healthy,

  @doc("Investigation health state is degraded")
  degraded,

  @doc("Investigation health state is unhealthy")
  unhealthy,
}

/**
 * The confidence level of the investigation result.
 */
@doc("The confidence level of the investigation result")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
enum ConfidenceLevel {
  @doc("Investigation result confidence level is unknown")
  `unknown`,

  @doc("Investigation result confidence level is low")
  low,

  @doc("Investigation result confidence level is medium")
  medium,

  @doc("Investigation result confidence level is high")
  high,
}

/**
 * The type of the result returned by the investigation.
 */
@doc("The type of the result returned by the investigation")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
enum ResultType {
  @doc("Resource health result")
  resourceHealth,

  @doc("Correlated metric anomalies of the scope resource")
  correlatedMetricAnomalies,

  @doc("Anomaly result based on Azure metric provided by Microsoft.Insights/metrics")
  azureMetricAnomaly,

  @doc("Anomaly result based on metric provided by Prometheus query")
  prometheusMetricAnomaly,

  @doc("Anomaly result based on anomalies in the application telemetry")
  correlatedApplicationAnomalies,

  @doc("Anomaly result based on unusual or unexpected event identified in logs")
  abnormalEvent,

  @doc("Anomaly result identified through patterns in tracing data")
  tracePatternAnomalies,

  @doc("Anomaly result identified through patterns in transaction data")
  transactionPatternAnomalies,
}

/**
 * The type of the scope of the investigation.
 */
@doc("The type of the scope of the investigation")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
enum InvestigationScopeType {
  @doc("The investigation ran on a subscription level")
  subscription,

  @doc("The investigation ran on a resource level")
  resource,

  @doc("The investigation ran on resource correlated metrics")
  correlatedMetricAnomalies,

  @doc("The investigation ran on an metric anomaly")
  correlatedMetricAnomaly,

  @doc("The investigation ran on resource application anomalies")
  correlatedApplicationAnomalies,

  @doc("The investigation identified unusual or unexpected events through logs analysis.")
  abnormalEvent,

  @doc("The investigation analyzed trace data for patterns that deviate from expected behavior.")
  tracePatternAnomalies,

  @doc("The investigation analyzed transaction data for patterns that deviate from expected behavior.")
  transactionPatternAnomalies,
}

/**
 * The investigation scope source type.
 */
@doc("The investigation scope source type.")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
enum ScopeSourceType {
  @doc("Automatic scope")
  automatic,

  @doc("User defined scope")
  userDefined,
}

/**
 * Investigation properties with the investigation result.
 */
@doc("Investigation properties with the investigation result")
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
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
model InvestigationRunConfiguration {
  @doc("Hints used for the investigation run")
  @extension("x-ms-identifiers", [])
  hints?: Filter[];

  @doc("A list of filters to decide on the scope")
  @extension("x-ms-identifiers", [])
  tagScopeFilters?: Filter[];

  @doc("The time window to look back from impactTime.")
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
model Investigation {
  @doc("The scope of which this investigation ran on.")
  scope?: string;

  @doc(" The unique Id for this investigation.")
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
@extension("x-ms-azure-resource", true)
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: ResourceIdentifier;

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
  systemData?: SystemData;
}

#suppress "@azure-tools/typespec-azure-resource-manager/improper-subscription-list-operation" "For backward compatibility"
@armResourceOperations(InvestigationResource)
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
interface Investigations {
  /**
   * Gets an investigation.
   */
  @doc("Returns the specific Investigation data.")
  @added(Microsoft.Monitor.Versions.v2024_01_01_preview)
  getAtResource is ArmResourceRead<InvestigationResource>;

  /**
   * You can provide the template and parameters directly in the request or link to JSON files.
   */
  @doc("Create or Update an Investigation")
  @added(Microsoft.Monitor.Versions.v2024_01_01_preview)
  createOrUpdateAtResource is ArmResourceCreateOrUpdateAsync<InvestigationResource>;

  /**
   * A template investigation that is currently running cannot be deleted.
   */
  @doc("Delete this Investigation.")
  @added(Microsoft.Monitor.Versions.v2024_01_01_preview)
  deleteAtResource is ArmResourceDeleteSync<InvestigationResource>;

  /**
   * Get all the Investigations at the given resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Investigations_ListAtResource")
  @doc("Returns all the investigations of a specific resource.")
  @added(Microsoft.Monitor.Versions.v2024_01_01_preview)
  listAtResource is ArmResourceListByParent<
    InvestigationResource,
    {
      ...BaseParameters<InvestigationResource>;

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

@@projectedName(Investigations.createOrUpdateAtResource::parameters.resource,
  "json",
  "investigation"
);
// @@extension(Investigations.createOrUpdateAtResource::parameters.resource,
//   "x-ms-client-name",
//   "investigation"
// );
@@doc(Investigations.createOrUpdateAtResource::parameters.resource,
  "Investigation body to create/update"
);
