import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.NetworkFunction;

interface Operations extends Azure.ResourceManager.Operations {}

enum CollectorProvisioningState {
  Succeeded,
  Updating,
  Deleting,
  Failed,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum IngestionType {
  IPFIX,
}

enum IngestionSourceType {
  Resource,
}

enum EmissionType {
  IPFIX,
}

enum EmissionDestinationType {
  AzureMonitor,
}

enum ApiVersionParameter {
  `2022-05-01`,
  `2022-08-01`,
  `2022-11-01`,
}

@doc("Azure Traffic Collector resource properties.")
model AzureTrafficCollectorPropertiesFormat {
  @doc("Collector Policies for Azure Traffic Collector.")
  @visibility("read")
  collectorPolicies?: ResourceReference[];

  @doc("The virtualHub to which the Azure Traffic Collector belongs.")
  virtualHub?: ResourceReference;

  @doc("The provisioning state of the application rule collection resource.")
  @visibility("read")
  provisioningState?: CollectorProvisioningState;
}

@doc("Resource reference properties.")
model ResourceReference {
  @doc("Resource ID.")
  @visibility("read")
  id?: string;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model TrackedResourceSystemData {
  ...SystemData;
}

@doc("An error response from the service.")
@error
model CloudError {
  @doc("An error response from the service.")
  error?: CloudErrorBody;
}

@doc("An error response from the service.")
model CloudErrorBody {
  @doc("An identifier for the error. Codes are invariant and are intended to be consumed programmatically.")
  code?: string;

  @doc("A message describing the error, intended to be suitable for display in a user interface.")
  message?: string;

  @doc("The target of the particular error. For example, the name of the property in error.")
  target?: string;

  @doc("A list of additional details about the error.")
  details?: CloudErrorBody[];
}

@doc("Collection policy properties.")
model CollectorPolicyPropertiesFormat {
  @doc("Ingestion policies.")
  ingestionPolicy?: IngestionPolicyPropertiesFormat;

  @doc("Emission policies.")
  emissionPolicies?: EmissionPoliciesPropertiesFormat[];

  @doc("The provisioning state.")
  @visibility("read")
  provisioningState?: CollectorProvisioningState;
}

@doc("Ingestion Policy properties.")
model IngestionPolicyPropertiesFormat {
  @doc("The ingestion type.")
  ingestionType?: IngestionType;

  @doc("Ingestion Sources.")
  ingestionSources?: IngestionSourcesPropertiesFormat[];
}

@doc("Ingestion policy properties.")
model IngestionSourcesPropertiesFormat {
  @doc("Ingestion source type.")
  sourceType?: IngestionSourceType;

  @doc("Resource ID.")
  resourceId?: string;
}

@doc("Emission policy properties.")
model EmissionPoliciesPropertiesFormat {
  @doc("Emission format type.")
  emissionType?: EmissionType;

  @doc("Emission policy destinations.")
  emissionDestinations?: EmissionPolicyDestination[];
}

@doc("Emission policy destination properties.")
model EmissionPolicyDestination {
  @doc("Emission destination type.")
  destinationType?: EmissionDestinationType;
}
