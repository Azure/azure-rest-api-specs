using Azure.Core;

namespace Microsoft.AszLabHardware;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The status of the current operation.")
@lroStatus
union ProvisioningState {
  @doc("Resource has been created.")
  Succeeded: "Succeeded",

  @doc("Resource creation failed.")
  Failed: "Failed",

  @doc("Resource creation was canceled.")
  Canceled: "Canceled",

  @doc("Resource is being provisioned")
  Provisioning: "Provisioning",

  @doc("Resource is being updated")
  Updating: "Updating",

  @doc("Resource is being deleted")
  Deleting: "Deleting",

  @doc("Resource work has been accepted")
  Accepted: "Accepted",

  string,
}
