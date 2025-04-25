import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

@doc("Instance diagnostic resource")
@parentResource(InstanceResource)
@added(Versions.`2025-07-01-preview`)
model DiagnosticResource is ProxyResource<DiagnosticProperties> {
  @doc("Name of Instance diagnostic resource")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("diagnosticName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("diagnostics")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;
}

@doc("Represents the activation state of Diagnostic.")
@added(Versions.`2025-07-01-preview`)
union DiagnosticsRemoteSupportActivationState {
  string,

  @doc("Remote Support is enabled.")
  Enabled: "Enabled",

  @doc("Remote Support is disabled.")
  Disabled: "Disabled",

  @doc("Remote Support has Expired.")
  Expired: "Expired",
}

@doc("DiagnosticAccessLevels allowed")
@added(Versions.`2025-07-01-preview`)
union DiagnosticsRemoteSupportAccessLevels {
  string,

  @doc("Diagnose access level")
  Diagnose: "Diagnose",

  @doc("Diagnose And Repair Access Level")
  DiagnoseAndRepair: "DiagnoseAndRepair",
}

@doc("RemoteSupport properties")
@added(Versions.`2025-07-01-preview`)
model DiagnosticsRemoteSupportProperties {
  @doc("Activation state of Diagnostic.")
  state?: DiagnosticsRemoteSupportActivationState;

  @doc("Access level for Diagnostic.")
  accessLevel?: DiagnosticsRemoteSupportAccessLevels;

  @doc("Expiration timestamp for Diagnostic.")
  expirationTimestamp?: string;
}

@doc("Diagnostic Resource properties")
@added(Versions.`2025-07-01-preview`)
model DiagnosticProperties {
  @doc("Remote Support Settings For Diagnostic.")
  remoteSupport?: DiagnosticsRemoteSupportProperties;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}
