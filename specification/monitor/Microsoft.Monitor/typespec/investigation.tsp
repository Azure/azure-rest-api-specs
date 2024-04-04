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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
//@Azure.ResourceManager.Private.armResourceInternal(InvestigationProperties)
@doc("An investigation definition.")
//@Versioning.added(Versions.v2024_01_01_preview)
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
model InvestigationResource extends ExtensionResource<InvestigationProperties> {
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
enum FilterOperator {
  @doc("Include this tag in the filter")
  include,
  @doc("Exclude this tag from the filter")
  exclude,
  @doc("Filter using this tag as the start of the scope")
  startsWith,
}

/**
 * The sensitivity which controls the investigation operation.
 */
@doc("The sensitivity which controls the investigation operation.")
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
enum ResultType {
  @doc("Resource Health Investigation result")
  resourceHealth,
  @doc("Correlated Metric Anomalies Investigation result")
  correlatedMetricAnomalies,
  @doc("Azure Metric Anomaly Investigation result")
  azureMetricAnomaly,
}

/**
 * Investigation properties with the investigation result.
 */
@doc("Investigation properties with the investigation result")
model InvestigationProperties {
  /**
   * The target ARM resources which the investigation will use.
   */
  @extension("x-ms-identifiers", [])
  targets: string[];

  /**
   * The display name of this investigation.
   */
  displayName: string;

  /**
   * The ARM Id of a Microsoft.AlertsManagement/alerts resource related to this investigation.
   */
  alertId?: string;

  /**
   * The impact time which the investigation ran on.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  impactTime: utcDateTime;

  /**
   * The run configuration for the investigation.
   */
  runConfiguration?: InvestigationRunConfiguration;

  /**
   * Denotes the state of the investigation operation.
   */
  @visibility("read")
  provisioningState?: InvestigationProvisioningState;

  /**
   * The investigation that ran on the given scope.
   */
  @visibility("read")
  investigation?: Investigation;
}

/**
 * The run configuration for the investigation.
 */
model InvestigationRunConfiguration {
  @doc("Hints used for the investigation run")
  @extension("x-ms-identifiers", [])
  hints?: Filter[];

  @doc("A list of filters to decide on the scope")
  @extension("x-ms-identifiers", [])
  tagScopeFilters?: Filter[];

  /**
   * The time window to look back from impactTime.
   */
  lookBackWindow?: string;

  /**
   * Configure the investigation to run only on Target resource
   */
  onlyInvestigateTargetResource?: boolean;

  /**
   * The sensitivity which controls the investigation operation.
   */
  sensitivity?: Sensitivity;
}

/**
 * Filter for dimensions or tags.
 */
model Filter {
  /**
   * The name of the dimension or tag to filter on.
   */
  name?: string;

  /**
   * Filter operator for dimensions or tags.
   */
  operator?: FilterOperator;

  /**
   * The values to filter based on.
   */
  @extension("x-ms-identifiers", [])
  values?: string[];
}

/**
 * The investigation that ran on the given scope.
 */
model Investigation {
  /**
   * The scope of which this investigation ran on.
   */
  scope?: string;

  /**
   * The unique Id for this investigation.
   */
  id?: string;

  /**
   * The type of this investigation.
   */
  type?: string;

  /**
   * The execution details of the investigation.
   */
  execution?: Execution;

  /**
   * The investigation result.
   */
  @visibility("read")
  result?: InvestigationResult;

  @doc("List of investigations")
  @extension("x-ms-identifiers", [])
  healthChecks?: Investigation[];
}

/**
 * The execution details of the investigation.
 */
model Execution {
  @doc("The time the investigation completed running")
  completedOn?: utcDateTime;

  /**
   * Denotes the state of the investigation operation.
   */
  @visibility("read")
  status?: InvestigationProvisioningState;
}

/**
 * The investigation result.
 */
model InvestigationResult {
  /**
   * The health state of the investigation's scope.
   */
  healthState?: HealthState;

  /**
   * The summary of the investigation resource.
   */
  summary?: string;

  /**
   * The cause of the investigated issue.
   */
  cause?: string;

  /**
   * The recommendation of the investigation.
   */
  recommendation?: string;

  /**
   * The confidence level of the investigation result.
   */
  confidenceLevel?: ConfidenceLevel;

  /**
   * The type of the result returned by the investigation.
   */
  resultType?: ResultType;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  /**
   * The details of the investigation result.
   */
  details?: Record<unknown>;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
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

@armResourceOperations
interface Investigations {
  /**
   * Gets an investigation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Investigations_GetAtResource")
  @doc("Returns the specific investigation")
  @added(Microsoft.Monitor.Versions.v2024_01_01_preview)
  getAtResource is ArmResourceRead<InvestigationResource>;

  /**
   * You can provide the template and parameters directly in the request or link to JSON files.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Investigations_CreateOrUpdateAtResource")
  @added(Microsoft.Monitor.Versions.v2024_01_01_preview)
  createOrUpdateAtResource is ArmResourceCreateOrReplaceAsync<
    InvestigationResource,
    BaseParameters<InvestigationResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * A template investigation that is currently running cannot be deleted.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Investigations_DeleteAtResource")
  @added(Microsoft.Monitor.Versions.v2024_01_01_preview)
  deleteAtResource is ArmResourceDeleteSync<InvestigationResource>;

  /**
   * Get all the Investigations at the given resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Investigations_ListAtResource")
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Investigations_ListAtSubscription")
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
@@extension(Investigations.createOrUpdateAtResource::parameters.resource,
  "x-ms-client-name",
  "investigation"
);
@@doc(Investigations.createOrUpdateAtResource::parameters.resource,
  "Additional parameters supplied to the operation."
);
