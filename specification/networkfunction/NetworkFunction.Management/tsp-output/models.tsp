import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureTrafficCollector;

enum ProvisioningState {
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

enum SourceType {
  Resource,
}

enum EmissionType {
  IPFIX,
}

enum DestinationType {
  AzureMonitor,
}

enum ApiVersionParameter {
  `2022-05-01`,
  `2022-08-01`,
  `2022-11-01`,
}

@doc("""
Result of the request to list Azure Traffic Collector operations. It contains a
list of operations and a URL link to get the next set of results.
""")
model OperationListResult is Azure.Core.Page<Operation>;

@doc("Azure Traffic Collector REST API operation definition.")
model Operation {
  @doc("Operation name: {provider}/{resource}/{operation}")
  name?: string;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;

  @doc("Display metadata associated with the operation.")
  display?: OperationDisplay;

  @doc("Origin of the operation")
  origin?: string;
}

@doc("Display metadata associated with the operation.")
model OperationDisplay {
  @doc("Service provider: Microsoft NetworkFunction.")
  provider?: string;

  @doc("Resource on which the operation is performed etc.")
  resource?: string;

  @doc("Type of operation: get, read, delete, etc.")
  operation?: string;

  @doc("Description of the operation.")
  description?: string;
}

@doc("An error response from the service.")
@error
model CloudError {
  @doc("An error response from the service.")
  error?: CloudErrorBody;
}

@doc("An error response from the service.")
model CloudErrorBody {
  @doc("""
An identifier for the error. Codes are invariant and are intended to be
consumed programmatically.
""")
  code?: string;

  @doc("""
A message describing the error, intended to be suitable for display in a user
interface.
""")
  message?: string;

  @doc("""
The target of the particular error. For example, the name of the property in
error.
""")
  target?: string;

  @doc("A list of additional details about the error.")
  details?: CloudErrorBody[];
}

@doc("Response for the ListTrafficCollectors API service call.")
model AzureTrafficCollectorListResult is Azure.Core.Page<AzureTrafficCollector>;

@doc("Azure Traffic Collector resource.")
model AzureTrafficCollector {
  ...TrackedResource;

  @doc("Properties of the Azure Traffic Collector.")
  properties?: AzureTrafficCollectorPropertiesFormat;

  @doc("A unique read-only string that changes whenever the resource is updated.")
  @visibility("read")
  etag?: string;
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
  provisioningState?: ProvisioningState;
}

@doc("Resource reference properties.")
model ResourceReference {
  @doc("Resource ID.")
  @visibility("read")
  id?: string;
}

@doc("Common resource representation.")
model TrackedResource {
  @doc("Resource ID.")
  @visibility("read")
  id?: string;

  @doc("Resource name.")
  @visibility("read")
  name?: string;

  @doc("Resource type.")
  @visibility("read")
  type?: string;

  @doc("Resource location.")
  location: string;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: TrackedResourceSystemData;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model TrackedResourceSystemData {
  ...SystemData;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: CreatedByType;
}

@doc("Tags object for patch operations.")
model TagsObject {
  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Response for the ListCollectorPolicies API service call.")
model CollectorPolicyListResult is Azure.Core.Page<CollectorPolicy>;

@doc("Collector policy resource.")
model CollectorPolicy {
  ...TrackedResource;

  @doc("Properties of the Collector Policy.")
  properties?: CollectorPolicyPropertiesFormat;

  @doc("A unique read-only string that changes whenever the resource is updated.")
  @visibility("read")
  etag?: string;
}

@doc("Collection policy properties.")
model CollectorPolicyPropertiesFormat {
  @doc("Ingestion policies.")
  ingestionPolicy?: IngestionPolicyPropertiesFormat;

  @doc("Emission policies.")
  emissionPolicies?: EmissionPoliciesPropertiesFormat[];

  @doc("The provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;
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
  sourceType?: SourceType;

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
  destinationType?: DestinationType;
}

@doc("An azure resource object")
model ProxyResource {
  @doc("Azure resource Id")
  @visibility("read")
  id?: string;

  @doc("Azure resource type")
  @visibility("read")
  type?: string;

  @doc("Azure resource name")
  @visibility("read")
  name?: string;
}
