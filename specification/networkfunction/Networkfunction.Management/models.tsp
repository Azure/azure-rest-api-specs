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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * The ingestion type.
 */
union IngestionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IPFIX: "IPFIX",
}

/**
 * Ingestion source type.
 */
union SourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Resource: "Resource",
}

/**
 * Emission format type.
 */
union EmissionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IPFIX: "IPFIX",
}

/**
 * Emission destination type.
 */
union DestinationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureMonitor: "AzureMonitor",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ApiVersionParameter {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `2022-05-01`: "2022-05-01",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `2022-08-01`: "2022-08-01",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `2022-11-01`: "2022-11-01",
}

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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
 * Metadata pertaining to creation and last modification of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model TrackedResourceSystemData extends SystemData {}

/**
 * Tags object for patch operations.
 */
model TagsObject {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
