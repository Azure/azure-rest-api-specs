import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.NetworkFunction;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The current provisioning state.
 */
enum CollectorProvisioningState {
  Succeeded,
  Updating,
  Deleting,
  Failed,
}

/**
 * The ingestion type.
 */
enum IngestionType {
  IPFIX,
}

/**
 * Ingestion source type.
 */
enum IngestionSourceType {
  Resource,
}

/**
 * Emission format type.
 */
enum EmissionType {
  IPFIX,
}

/**
 * Emission destination type.
 */
enum EmissionDestinationType {
  AzureMonitor,
}

enum ApiVersionParameter {
  `2022-05-01`,
  `2022-08-01`,
  `2022-11-01`,
}

/**
 * Azure Traffic Collector resource properties.
 */
model AzureTrafficCollectorPropertiesFormat {
  /**
   * Collector Policies for Azure Traffic Collector.
   */
  @visibility("read")
  collectorPolicies?: ResourceReference[];

  /**
   * The virtualHub to which the Azure Traffic Collector belongs.
   */
  virtualHub?: ResourceReference;

  /**
   * The provisioning state of the application rule collection resource.
   */
  @visibility("read")
  provisioningState?: CollectorProvisioningState;
}

/**
 * Resource reference properties.
 */
model ResourceReference {
  /**
   * Resource ID.
   */
  @visibility("read")
  id?: string;
}

/**
 * Common resource representation.
 */
model TrackedResource {
  /**
   * Resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * Resource location.
   */
  location: string;

  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  systemData?: TrackedResourceSystemData;
}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
model TrackedResourceSystemData extends SystemData {}

/**
 * An error response from the service.
 */
@error
model CloudError {
  /**
   * An error response from the service.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the service.
 */
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
  details?: CloudErrorBody[];
}

/**
 * Tags object for patch operations.
 */
model TagsObject {
  /**
   * Resource tags.
   */
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
  emissionPolicies?: EmissionPoliciesPropertiesFormat[];

  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: CollectorProvisioningState;
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
  ingestionSources?: IngestionSourcesPropertiesFormat[];
}

/**
 * Ingestion policy properties.
 */
model IngestionSourcesPropertiesFormat {
  /**
   * Ingestion source type.
   */
  sourceType?: IngestionSourceType;

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
  emissionDestinations?: EmissionPolicyDestination[];
}

/**
 * Emission policy destination properties.
 */
model EmissionPolicyDestination {
  /**
   * Emission destination type.
   */
  destinationType?: EmissionDestinationType;
}

/**
 * An azure resource object
 */
model ProxyResource {
  /**
   * Azure resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Azure resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Azure resource name
   */
  @visibility("read")
  name?: string;
}
