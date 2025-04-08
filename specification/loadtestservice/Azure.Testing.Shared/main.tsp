// cheat-sheet - https://microsoft.github.io/typespec/standard-library/http/cheat-sheet
// tsp compile main.tsp --emit @azure-tools/typespec-autorest

import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using Azure.Core;

@versioned(Azure.Testing.Shared.Versions)
namespace Azure.Testing.Shared;

@doc("The Azure Testing workspace Model Version.")
enum Versions {
  @doc("Version 1.0")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v1_0: "2025-06-01-preview"
}

@doc("An Azure Testing workspace is the parent resource for most of the other testing service resources.")
@resource("workspaces")
model TestingWorkspace {
  @key("workspaceId")
  @doc("The workspace id.")
  @maxLength(64)
  @pattern("[A-Za-z0-9]+(_[A-Za-z0-9]+)*(-[A-Za-z0-9]+)+")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The fully-qualified Azure resource id for the workspace.")
  @visibility(Lifecycle.Read)
  resourceId: string;

  @doc("The workspace name.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The workspace kind - WebTesting.")
  @visibility(Lifecycle.Read)
  kind: WorkspaceKind;

  @doc("The state of workspace - Active | Inactive")
  @visibility(Lifecycle.Read)
  state: WorkspaceState;

  @doc("The Azure subscription id for the workspace.")
  @visibility(Lifecycle.Read)
  subscriptionId: uuid;

  @doc("The Azure subscription state - Registered | Unregistered | Warned | Suspended | Deleted")
  @visibility(Lifecycle.Read)
  subscriptionState: SubscriptionState;

  @doc("The Azure tenant id of the workspace.")
  @visibility(Lifecycle.Read)
  tenantId: uuid;

  @doc("The workspace resource location in Azure, for eg. eastus, southeastasia.")
  @visibility(Lifecycle.Read)
  location: string;

  ...WorkspaceAdditionalProperties;
}

@doc("The Azure Testing workspace additional dynamic properties.")
model WorkspaceAdditionalProperties {
  @visibility(Lifecycle.Read)
  @doc("The Web Testing workspace data plane URI.")
  webTestingDataplaneUri?: url;

  @doc("This property sets the connection region for Testing client workers to cloud-hosted browsers. If enabled, workers connect to browsers in the closest Azure region, ensuring lower latency. If disabled, workers connect to browsers in the Azure region in which the workspace was initially created.")
  regionalAffinity?: EnablementStatus = EnablementStatus.Enabled;

  @doc("When enabled, this feature allows the workspace to use local auth (through service access token) for executing operations.")
  localAuth?: EnablementStatus = EnablementStatus.Disabled;
}

@doc("The Azure Testing workspace state.")
union WorkspaceState {
  string,

  @doc("The workspace is Active.")
  "Active",

  @doc("The workspace is Inactive.")
  "Inactive",
}

@doc("The Azure Testing workspace kind.")
union WorkspaceKind {
  string,

  @doc("The workspace is of kind - WebTesting.")
  WebTesting: "WebTesting"
}

@doc("The Azure subscription state.")
union SubscriptionState {
  string,

  @doc("The subscription state is Registered.")
  "Registered",

  @doc("The subscription state is Warned.")
  "Warned",

  @doc("The subscription state is Suspended.")
  "Suspended",

  @doc("The subscription state is Deleted.")
  "Deleted",

  @doc("The subscription state is Unregistered.")
  "Unregistered",
}

@doc("The enablement status of a feature.")
union EnablementStatus {
  string,

  @doc("The feature is Enabled.")
  Enabled: "Enabled",

  @doc("The feature is Disabled.")
  Disabled: "Disabled",
}
