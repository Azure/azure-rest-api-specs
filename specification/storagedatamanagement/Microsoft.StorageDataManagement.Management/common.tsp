import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.StorageDataManagement;

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  ResourceProvisioningState,
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Suppress warnings for close enums"
@doc("The type of the backing data source")
union SourceType {
  @doc("Source type - Bucket")
  Bucket: "Bucket",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Suppress warnings for close enums"
@doc("The state of the connector")
union State {
  @doc("Whether the connector is enabled")
  Enabled: "Enabled",

  @doc("Whether the connector is disabled")
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Suppress warnings for close enums"
@doc("The auth type supported for bucket connection.")
union AuthType {
  @doc("Access Key auth type")
  AccessKey: "AccessKey",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Suppress warnings for close enums"
@doc("The connection type for bucket connection")
union ConnectionType {
  @doc("Endpoint connection type")
  Endpoint: "Endpoint",

  @doc("Private Link connection type")
  PrivateLink: "PrivateLink",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Suppress warnings for close enums"
@doc("The TLS Verification options")
union TlsVerification {
  @doc("Perform TLS Verification")
  Perform: "Perform",

  @doc("Use AllowSelfSignedCerts as TlsVerification")
  AllowSelfSignedCerts: "AllowSelfSignedCerts",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Suppress warnings for close enums"
@doc("The supported PrivateLinkId types")
union PrivateLinkIdType {
  @doc("ResourceId for PrivateLink ID")
  ResourceId: "ResourceId",

  @doc("Alias for Private Link")
  Alias: "Alias",
}
