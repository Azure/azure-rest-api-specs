using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Migrate;

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

@added(ApiVersions.v2026_06_01_preview)
@doc("Identifies how a wave plan was produced.")
union PlanSource {
  @doc("The wave plan was produced by the system solver.")
  SystemGenerated: "SystemGenerated",

  @doc("The wave plan was uploaded by the customer.")
  Imported: "Imported",

  string,
}
