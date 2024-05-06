import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./instance.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.IoTOperationsDataProcessor;

@doc("A Dataset resource belonging to an Instance resource.")
@parentResource(Instance)
model Dataset is TrackedResource<DatasetProperties> {
  @doc("Name of dataset.")
  @key("datasetName")
  @segment("datasets")
  @pattern("^[a-z0-9][a-z0-9-]{1,60}[a-z0-9]$")
  @path
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("The properties of a Dataset resource.")
model DatasetProperties {
  @doc("Detailed description of the Dataset.")
  description?: string;

  @doc("Path to the payload in the message. Enrich will add only the payload to the enriched message, other fields will not be kept except for in the indexes.")
  payload?: string;

  @doc("Path to an RFC3339 timestamp in the message. If no path is provided, the ingestion time of the record is used for time-based joins.")
  timestamp?: string;

  @doc("Time to live for individual records.")
  ttl?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("List of keys that can be used for joining on enrich.")
  keys?: Record<DatasetPropertyKey>;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Key that can be used for joining on enrich.")
model DatasetPropertyKey {
  @doc("Path to the input value from the message.")
  path: string;

  @doc("If true the property will be used as a primary key. At most one primary key can exists.")
  primaryKey?: boolean;
}

@armResourceOperations
interface Datasets {
  get is ArmResourceRead<Dataset>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Dataset>;
  update is ArmCustomPatchSync<Dataset>;
  delete is ArmResourceDeleteWithoutOkAsync<Dataset>;
  listByInstance is ArmResourceListByParent<Dataset>;
}
