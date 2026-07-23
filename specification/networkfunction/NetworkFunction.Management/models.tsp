import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.NetworkFunction;

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * The ingestion type.
 */
union IngestionType {
  string,

  /**
   * IPFIX
   */
  IPFIX: "IPFIX",
}

/**
 * Ingestion source type.
 */
union SourceType {
  string,

  /**
   * Resource
   */
  Resource: "Resource",
}

/**
 * Emission format type.
 */
union EmissionType {
  string,

  /**
   * IPFIX
   */
  IPFIX: "IPFIX",
}

/**
 * Emission destination type.
 */
union DestinationType {
  string,

  /**
   * AzureMonitor
   */
  AzureMonitor: "AzureMonitor",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ApiVersionParameter {
  string,

  /**
   * 2022-05-01
   */
  `2022-05-01`: "2022-05-01",

  /**
   * 2022-08-01
   */
  `2022-08-01`: "2022-08-01",

  /**
   * 2022-11-01
   */
  `2022-11-01`: "2022-11-01",
}

/**
 * Azure Traffic Collector REST API operation definition.
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean = false;

  /**
   * Display metadata associated with the operation.
   */
  display?: OperationDisplay;

  /**
   * Origin of the operation
   */
  origin?: string;
}

model OperationListResult is Azure.Core.Page<Operation>;
/**
 * Display metadata associated with the operation.
 */
model OperationDisplay {
  /**
   * Service provider: Microsoft NetworkFunction.
   */
  provider?: string;

  /**
   * Resource on which the operation is performed etc.
   */
  resource?: string;

  /**
   * Type of operation: get, read, delete, etc.
   */
  operation?: string;

  /**
   * Description of the operation.
   */
  description?: string;
}

/**
 * An error response from the service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * An error response from the service.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message?: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  @identifiers(#[])
  details?: CloudErrorBody[];
}

/**
 * Azure Traffic Collector resource properties.
 */
model AzureTrafficCollectorPropertiesFormat {
  /**
   * Collector Policies for Azure Traffic Collector.
   */
  @visibility(Lifecycle.Read)
  collectorPolicies?: ResourceReference[];

  /**
   * The virtualHub to which the Azure Traffic Collector belongs.
   */
  virtualHub?: ResourceReference;

  /**
   * The provisioning state of the application rule collection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Resource reference properties.
 */
model ResourceReference {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * Common resource representation.
 */
model TrackedResource {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource location.
   */
  location: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: TrackedResourceSystemData;
}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TrackedResourceSystemData extends SystemData {}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SystemData {
  /**
   * The identity that created the resource.
   */
  createdBy?: string;

  /**
   * The type of identity that created the resource.
   */
  createdByType?: CreatedByType;

  /**
   * The timestamp of resource creation (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The identity that last modified the resource.
   */
  lastModifiedBy?: string;

  /**
   * The type of identity that last modified the resource.
   */
  lastModifiedByType?: CreatedByType;
}

/**
 * Tags object for patch operations.
 */
model TagsObject {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Collection policy properties.
 */
model CollectorPolicyPropertiesFormat {
  /**
   * Ingestion policies.
   */
  ingestionPolicy?: IngestionPolicyPropertiesFormat;

  /**
   * Emission policies.
   */
  @identifiers(#[])
  emissionPolicies?: EmissionPoliciesPropertiesFormat[];

  /**
   * The provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Ingestion Policy properties.
 */
model IngestionPolicyPropertiesFormat {
  /**
   * The ingestion type.
   */
  ingestionType?: IngestionType;

  /**
   * Ingestion Sources.
   */
  @identifiers(#[])
  ingestionSources?: IngestionSourcesPropertiesFormat[];
}

/**
 * Ingestion policy properties.
 */
model IngestionSourcesPropertiesFormat {
  /**
   * Ingestion source type.
   */
  sourceType?: SourceType;

  /**
   * Resource ID.
   */
  resourceId?: string;
}

/**
 * Emission policy properties.
 */
model EmissionPoliciesPropertiesFormat {
  /**
   * Emission format type.
   */
  emissionType?: EmissionType;

  /**
   * Emission policy destinations.
   */
  @identifiers(#[])
  emissionDestinations?: EmissionPolicyDestination[];
}

/**
 * Emission policy destination properties.
 */
model EmissionPolicyDestination {
  /**
   * Emission destination type.
   */
  destinationType?: DestinationType;
}

/**
 * An azure resource object
 */
model ProxyResource {
  /**
   * Azure resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Azure resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;
}
