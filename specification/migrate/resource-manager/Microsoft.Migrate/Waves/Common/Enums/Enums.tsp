using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Migrate;

@doc("The terminal status of a CSV validation run.")
@added(ApiVersions.v2026_09_01_preview)
union ValidationStatus {
  @doc("The staged CSV passed validation.")
  Succeeded: "Succeeded",

  @doc("The staged CSV failed validation. An error CSV is available through sasUri.")
  Failed: "Failed",

  string,
}

@doc("The status of the current operation.")
union ProvisioningState {
  @doc("Resource provisioning Successful.")
  Succeeded: "Succeeded",

  @doc("Resource provisioning Failed.")
  Failed: "Failed",

  @doc("Resource provisioning Canceled.")
  Canceled: "Canceled",

  @doc("Resource is being Provisioned.")
  Provisioning: "Provisioning",

  @doc("Resource is being Updated.")
  Updating: "Updating",

  @doc("Resource is being Deleted.")
  Deleting: "Deleting",

  @doc("Resource is being Accepted.")
  Accepted: "Accepted",

  string,
}
