// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/http";

import "../common/versions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

@doc("The REST API version.")
@minLength(10)
@maxLength(18)
@pattern("^[0-9]{4}-[0-9]{2}-[0-9]{2}(?:-preview)?$")
@extension("x-ms-parameter-location", "client")
scalar ApiVersion extends string;

@doc("The Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
@minLength(36)
@maxLength(36)
@pattern("^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$")
@extension("x-ms-parameter-location", "client")
scalar SubscriptionId extends string;

@doc("Name of an Azure resource group.")
@minLength(1)
@maxLength(90)
// https://learn.microsoft.com/azure/azure-resource-manager/management/resource-name-rules#microsoftresources
@pattern("^[a-zA-Z][a-zA-Z0-9\\-_\\.]*$")
@extension("x-ms-parameter-location", "client")
scalar ResourceGroupName extends string;

alias ResourceProviderName = "Microsoft.Quantum";

@doc("Name of the Azure Quantum workspace.")
@minLength(2)
@maxLength(50)
// https://learn.microsoft.com/azure/azure-resource-manager/management/resource-name-rules#microsoftquantum
@pattern("^[a-zA-Z][a-zA-Z0-9\\-_]*$")
@extension("x-ms-parameter-location", "client")
scalar WorkspaceName extends string;

@doc("Common URL parameters.")
model CommonParams {
  @query("api-version")
  @doc("The REST API version.")
  apiVersion: ApiVersion;

  @path
  @segment("subscriptions")
  @doc("The Azure subscription ID.")
  subscriptionId: SubscriptionId;

  @path
  @segment("resourceGroups")
  @doc("Name of an Azure resource group.")
  resourceGroupName: ResourceGroupName;

  @path
  @segment("providers")
  @doc("The Azure Quantum resource provider.")
  provider: ResourceProviderName;

  @path
  @segment("workspaces")
  @doc("Name of the Azure Quantum workspace.")
  @minLength(2)
  @maxLength(50)
  // https://learn.microsoft.com/azure/azure-resource-manager/management/resource-name-rules#microsoftquantum
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-_]*$")
  @extension("x-ms-parameter-location", "client")
  workspaceName: WorkspaceName;
}

@doc("Azure Subscription.")
@resource("subscriptions")
model Subscription {
  @doc("The Azure subscription ID.")
  @key
  @visibility("read", "create", "update", "delete")
  subscriptionId: SubscriptionId;
}

@doc("Azure Resource Group.")
@resource("resourceGroups")
@parentResource(Subscription)
model ResourceGroup {
  @doc("Name of an Azure resource group.")
  @key
  @visibility("read", "create", "update", "delete")
  resourceGroupName: ResourceGroupName;
}

@doc("Azure Resource Provider.")
@resource("providers")
@parentResource(ResourceGroup)
model ResourceProvider {
  @doc("Name of an Azure resource provider.")
  @key
  @visibility("read", "create", "update", "delete")
  providerName: ResourceProviderName;
}

@doc("Azure Quantum workspace.")
@resource("workspaces")
@parentResource(Provider)
model QuantumWorkspace {
  @doc("Name of the workspace.")
  @key
  @visibility("read", "create", "update", "delete")
  workspaceName: WorkspaceName;
}
