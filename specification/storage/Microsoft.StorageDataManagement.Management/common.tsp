import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Storage;

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  ResourceProvisioningState,
}

@doc("The type of the backing data source")
union SourceType {
  @doc("Source type - DataShare")
  DataShare: "DataShare",

  string,
}

@doc("The state of the connector")
union State {
  @doc("Whether the connector is active")
  Active: "Active",

  @doc("Whether the connector is inactive")
  Inactive: "Inactive",

  string,
}

@doc("The auth type supported for bucket connection.")
union AuthType {
  ManagedIdentity: "ManagedIdentity",
  string,
}

@doc("The connection type for bucket connection")
union ConnectionType {
  @doc("DataShare connection type")
  DataShare: "DataShare",

  string,
}

@doc("The TLS Verification options")
union TlsVerification {
  @doc("Perform TLS Verification")
  Perform: "Perform",

  @doc("Use AllowSelfSignedCerts as TlsVerification")
  AllowSelfSignedCerts: "AllowSelfSignedCerts",

  string,
}

@doc("The type of the backing data source.")
union DataSourceType {
  @doc("Azure DataShare data source type.")
  Azure_DataShare: "Azure_DataShare",

  string,
}

@doc("The permissions supported in access policies")
union AccessPolicyPermission {
  @doc("No permission")
  None: "None",

  @doc("Read permission")
  Read: "Read",

  string,
}
