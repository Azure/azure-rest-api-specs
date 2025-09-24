import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ApplicationMigration;

@lroStatus
@doc("The resource provisioning state.")
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The resource is being provisioned.")
  Provisioning: "Provisioning",

  @doc("The resource is updating.")
  Updating: "Updating",

  @doc("The resource is being deleted.")
  Deleting: "Deleting",

  @doc("The resource create request has been accepted.")
  Accepted: "Accepted",
}

@doc("Connection status.")
union ConnectionStatus {
  string,

  @doc("The connection status is Successful.")
  Success: "Success",

  @doc("The connection status is InProgress.")
  InProgress: "InProgress",

  @doc("The connection status is Failed.")
  Failed: "Failed",
}

@doc("GitHub issue status.")
union GitHubIssueStatus {
  string,

  @doc("Issue is open.")
  Open: "Open",

  @doc("Issue is closed.")
  Closed: "Closed",

  @doc("Issue is deleted.")
  Deleted: "Deleted",
}

@doc("Tool type for GitHub issues.")
union ToolType {
  string,

  @doc("AppCAT tool type.")
  AppCAT: "AppCAT",
}

@doc("Repository information.")
model Repository {
  @doc("Repository URL.")
  url?: string;
}
