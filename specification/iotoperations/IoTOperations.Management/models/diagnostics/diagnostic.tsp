import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/**
 * Instance diagnostic resource
 */
@parentResource(InstanceResource)
@added(Versions.`2025-07-01-preview`)
model DiagnosticResource is ProxyResource<DiagnosticProperties> {
  /**
   * Name of Instance diagnostic resource
   */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("diagnosticName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("diagnostics")
  name: string;

  /**
   * Edge location of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;
}

/**
 * Represents the activation state of Diagnostic.
 */
@added(Versions.`2025-07-01-preview`)
union DiagnosticsRemoteSupportActivationState {
  string,

  /**
   * Remote Support is enabled.
   */
  Enabled,

  /**
   * Remote Support is disabled.
   */
  Disabled,

  /**
   * Remote Support has Expired.
   */
  Expired,
}

/**
 * DiagnosticAccessLevels allowed
 */
@added(Versions.`2025-07-01-preview`)
union DiagnosticsRemoteSupportAccessLevels {
  string,

  /**
   * Diagnose access level
   */
  Diagnose,

  /**
   * Diagnose And Repair Access Level
   */
  DiagnoseAndRepair,
}

/**
 * RemoteSupport properties
 */
@added(Versions.`2025-07-01-preview`)
model DiagnosticsRemoteSupportProperties {
  /**
   * Activation state of Diagnostic.
   */
  state?: DiagnosticsRemoteSupportActivationState;

  /**
   * Access level for Diagnostic.
   */
  accessLevel?: DiagnosticsRemoteSupportAccessLevels;

  /**
   * Expiration timestamp for Diagnostic.
   */
  expirationTimestamp?: string;
}

/**
 * Diagnostic Resource properties
 */
@added(Versions.`2025-07-01-preview`)
model DiagnosticProperties {
  /**
   * Remote Support Settings For Diagnostic.
   */
  remoteSupport?: DiagnosticsRemoteSupportProperties;

  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
