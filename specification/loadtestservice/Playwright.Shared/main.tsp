// cheat-sheet - https://microsoft.github.io/typespec/standard-library/http/cheat-sheet
// tsp compile main.tsp --emit @azure-tools/typespec-autorest

import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using Azure.Core;

@versioned(Playwright.Shared.Versions)
namespace Playwright.Shared;

@doc("Playwright workspace model version.")
enum Versions {
  @doc("Version 1.0")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v1_0: "2025-07-01-preview",
}

@doc("Playwright workspace is the parent resource for most of the other service resources.")
@resource("playwrightworkspaces")
model Workspace {
  @key("workspaceId")
  @doc("The workspace id.")
  @maxLength(64)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  @visibility(Lifecycle.Read)
  id: uuid;

  @doc("Fully-qualified Azure resource id for the workspace.")
  @visibility(Lifecycle.Read)
  resourceId: armResourceIdentifier;

  @doc("The workspace name.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The state of workspace - Active | Inactive")
  @visibility(Lifecycle.Read)
  state: ResourceState;

  @doc("Azure subscription id for the workspace.")
  @visibility(Lifecycle.Read)
  subscriptionId: uuid;

  @doc("Azure subscription state - Registered | Unregistered | Warned | Suspended | Deleted")
  @visibility(Lifecycle.Read)
  subscriptionState: SubscriptionState;

  @doc("Azure tenant id for the workspace.")
  @visibility(Lifecycle.Read)
  tenantId: uuid;

  @doc("Azure location of the workspace, for eg. eastus, southeastasia.")
  @visibility(Lifecycle.Read)
  location: string;

  ...WorkspaceAdditionalProperties;
}

@doc("The additional properties of a workspace.")
model WorkspaceAdditionalProperties {
  @visibility(Lifecycle.Read)
  @doc("The workspace data plane URI.")
  dataplaneUri?: url;

  @doc("This property sets the connection region for client workers to cloud-hosted browsers. If enabled, workers connect to browsers in the closest Azure region, ensuring lower latency. If disabled, workers connect to browsers in the Azure region in which the workspace was initially created.")
  regionalAffinity?: EnablementStatus = EnablementStatus.Enabled;

  @doc("When enabled, this feature allows the workspace to use local auth (through service access token) for executing operations.")
  localAuth?: EnablementStatus = EnablementStatus.Disabled;
}

@doc("The Azure resource state.")
union ResourceState {
  string,

  @doc("The resource is Active.")
  Active: "Active",

  @doc("The resource is Inactive.")
  Inactive: "Inactive",
}

@doc("The Azure subscription state.")
union SubscriptionState {
  string,

  @doc("The subscription state is Registered.")
  Registered: "Registered",

  @doc("The subscription state is Warned.")
  Warned: "Warned",

  @doc("The subscription state is Suspended.")
  Suspended: "Suspended",

  @doc("The subscription state is Deleted.")
  Deleted: "Deleted",

  @doc("The subscription state is Unregistered.")
  Unregistered: "Unregistered",
}

@doc("The enablement status of a feature.")
union EnablementStatus {
  string,

  @doc("The feature is Enabled.")
  Enabled: "Enabled",

  @doc("The feature is Disabled.")
  Disabled: "Disabled",
}
