// Models ////////////////////

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";

using Azure.Core;
using TypeSpec.Rest;

namespace Playwright;

@doc("Model of an access-token linked to a workspace.")
@resource("access-tokens")
@parentResource(Workspace)
model AccessToken {
  @key("accessTokenId")
  @doc("The access-token id.")
  @minLength(3)
  @maxLength(32)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  @visibility(Lifecycle.Read)
  id: uuid;

  // Standard Azure Resource Name parameter regex pattern - https://azure.github.io/typespec-azure/docs/libraries/azure-resource-manager/reference/data-types/#Azure.ResourceManager.ResourceNameParameter
  @minLength(3)
  @maxLength(24)
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @doc("The access-token name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: string;

  @doc("The access-token value in JWT format.")
  @visibility(Lifecycle.Read)
  jwtToken?: string;

  @doc("The access-token createdAt utcDateTime.")
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;

  @doc("The access-token expiryAt utcDateTime.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  expiryAt: utcDateTime;

  @doc("The access-token state - Active | Expired.")
  @visibility(Lifecycle.Read)
  state: AccessTokenState;
}

@doc("The access-token state.")
union AccessTokenState {
  string,

  @doc("The access-token is Active.")
  Active: "Active",

  @doc("The access-token is Expired.")
  Expired: "Expired",
}

@doc("The os to configure for remote script runs.")
union OS {
  string,

  @doc("Linux OS.")
  Linux: "Linux",

  @doc("Windows OS.")
  Windows: "Windows",
}

@doc("Playwright workspace is the parent resource for most of the other service resources.")
@resource("playwrightworkspaces")
model Workspace {
  @key("workspaceId")
  @doc("The workspace id.")
  @maxLength(32)
  @minLength(3)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  @visibility(Lifecycle.Read)
  id: uuid;

  @doc("Fully-qualified Azure resource id for the workspace.")
  @visibility(Lifecycle.Read)
  resourceId: armResourceIdentifier;

  @minLength(3)
  @maxLength(24)
  @pattern("^[a-zA-Z0-9-]{3,24}$")
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

  @doc("This property sets the connection region for client workers to cloud-hosted browsers. If enabled, workers connect to browsers in the closest Azure region, ensuring lower latency. If disabled, workers connect to browsers in the Azure region in which the workspace was initially created.")
  @visibility(Lifecycle.Read)
  regionalAffinity?: EnablementStatus = EnablementStatus.Enabled;

  @doc("When enabled, this feature allows the workspace to use local auth (through service access token) for executing operations.")
  @visibility(Lifecycle.Read)
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
