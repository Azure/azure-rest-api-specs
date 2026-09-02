import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@added(Versions.v2026_10_01)
@doc("A user-supplied description with a maximum length of 1024 characters.")
@maxLength(1024)
scalar WritableDescription extends string;

@removed(Versions.v2026_10_01)
@doc("Current states.")
union State {
  string,

  @doc("Is ready and operational")
  Ready: "Ready",

  @doc("Is being dropped/deleted")
  Dropping: "Dropping",

  @doc("Is disabled")
  Disabled: "Disabled",

  @doc("Is starting up")
  Starting: "Starting",

  @doc("Is stopping")
  Stopping: "Stopping",

  @doc("Is stopped")
  Stopped: "Stopped",

  @doc("Is being updated")
  Updating: "Updating",

  @doc("Is healthy")
  Healthy: "Healthy",

  @added(Versions.v2026_05_01_preview)
  @doc("Is succeeded")
  Succeeded: "Succeeded",

  @added(Versions.v2026_05_01_preview)
  @doc("Is upgrading")
  Upgrading: "Upgrading",
}

@added(Versions.v2026_10_01)
@doc("A PostgreSQL major version supported by HorizonDB. API version 2026-10-01 accepts only 17. Future API versions may add named values, and clients must tolerate unknown values returned by the service.")
union PostgreSqlVersion {
  string,

  /** PostgreSQL major version 17. */
  V17: "17",
}

@doc("Indicates if public network access is enabled or not.")
union PublicNetworkAccessState {
  string,

  @doc("Public network access is enabled")
  Enabled: "Enabled",

  @doc("Public network access is disabled")
  Disabled: "Disabled",
}

@doc("The provisioning state.")
@lroStatus
union ProvisioningState {
  Azure.ResourceManager.ResourceProvisioningState,

  /** The HorizonDB resource operation is actively running. */
  InProgress: "InProgress",

  /** The HorizonDB resource is still provisioning. */
  Provisioning: "Provisioning",
}
