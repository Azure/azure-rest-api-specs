import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/** ******************* */
/**
 * skynet resource type model details.
 */
@doc("Instance skynet resource")
@parentResource(InstanceResource)
@added(Versions.`2025-07-01-preview`)
model SkynetResource is ProxyResource<SkynetProperties> {
  @doc("Name of Instance skynet resource")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("skynetName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("skynets")
  name: string;

  // Extended location is not included in ProxyResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;
}

@doc("Represents the activation state of Skynet.")
@added(Versions.`2025-07-01-preview`)
union RemoteSupportActivationState {
  string,

  @doc("Remote Support is enabled.")
  Enabled: "Enabled",

  @doc("Remote Support is disabled.")
  Disabled: "Disabled",

  @doc("Remote Support has Expired.")
  Expired: "Expired",
}

@doc("SkynetAccessLevels allowed")
@added(Versions.`2025-07-01-preview`)
union RemoteSupportAccessLevels {
  string,

  @doc("Diagnose access level")
  Diagnose: "Diagnose",

  @doc("Diagnose And Repair Access Level")
  DiagnoseAndRepair: "DiagnoseAndRepair",
}

@doc("RemoteSupport properties")
@added(Versions.`2025-07-01-preview`)
model RemoteSupportProperties {
  @doc("Activation state of Skynet.")
  state?: RemoteSupportActivationState;

  @doc("Access level for Skynet.")
  accessLevel?: RemoteSupportAccessLevels;

  @doc("Expiration timestamp for Skynet.")
  expirationTimestamp?: string;
}

@doc("Skynet Resource properties")
@added(Versions.`2025-07-01-preview`)
model SkynetProperties {
  @doc("Remote Support Settings For Skynet.")
  remoteSupport?: RemoteSupportProperties;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}
