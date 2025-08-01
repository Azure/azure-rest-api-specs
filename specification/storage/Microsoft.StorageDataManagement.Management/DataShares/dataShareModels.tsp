import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Storage;

// DataShare Properties
@doc("Details of the Storage DataShare.")
@added(Versions.v2025_07_01_preview)
model DataShareProperties {
  @visibility(Lifecycle.Read)
  @doc("System-generated identifier for the Storage DataShare. Not a valid input parameter when creating.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  dataShareIdentifier?: string;

  @doc("Arbitrary description of this Data Share. Max 250 characters.")
  @maxLength(250)
  description?: string;

  @visibility(Lifecycle.Read)
  @doc("The DataShare URI to be shared with the consumer. URI Format - 'azds://<location>:<dataShareName>:<dataShareIdentifier>'.")
  @pattern("^azds://[a-zA-Z0-9-]+:[a-zA-Z0-9-_]+:[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  dataShareUri: string;

  @doc("List of access policies that specify the permission allowed to a managed identity.")
  @OpenAPI.extension("x-ms-identifiers", [])
  accessPolicies: AccessPolicy[];

  @doc("List of assets that specify the properties of the shared resources.")
   @OpenAPI.extension("x-ms-identifiers", [])
  assets: Asset[];

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

// Access Policy
@doc("Policy that specify the permission allowed to a managed identity.")
@added(Versions.v2025_07_01_preview)
model AccessPolicy {
  @doc("The AAD principal ID of the Managed Identity.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  principalId: string;

  @doc("The AAD tenant ID of the Managed Identity.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  tenantId: string;

  @doc("Allowed permissions. Currently, only supported value is Read.")
  permission: AccessPolicyPermission;
}

// Asset
@doc("Properties of a shared resource.")
@added(Versions.v2025_07_01_preview)
model Asset {
  @doc("Source Path to be shared. It can be a folder or a blob. The asset path should contain container name followed by path within the container, e.g. /container1/logs/external.")
  assetPath: string;

  @doc("Consumer visible name of the original path.")
  displayName: string;
}
