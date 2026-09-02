// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;

namespace Quantum.Workspace;

/** The REST API version. */
@minLength(10)
@maxLength(18)
@pattern("^[0-9]{4}-[0-9]{2}-[0-9]{2}(?:-preview)?$")
@extension("x-ms-parameter-location", "client")
scalar ApiVersion extends string;

/** The Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000). */
@minLength(36)
@maxLength(36)
@pattern("^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$")
@extension("x-ms-parameter-location", "client")
scalar SubscriptionId extends string;

/** Name of an Azure resource group. */
@minLength(1)
@maxLength(90)
// https://learn.microsoft.com/azure/azure-resource-manager/management/resource-name-rules#microsoftresources
@pattern("^[a-zA-Z][a-zA-Z0-9\\-_\\.]*$")
@extension("x-ms-parameter-location", "client")
scalar ResourceGroupName extends string;

alias ResourceProviderName = "Microsoft.Quantum";

/** Name of the Azure Quantum workspace. */
@minLength(2)
@maxLength(50)
// https://learn.microsoft.com/azure/azure-resource-manager/management/resource-name-rules#microsoftquantum
@pattern("^[a-zA-Z][a-zA-Z0-9\\-_]*$")
@extension("x-ms-parameter-location", "client")
scalar WorkspaceName extends string;

/** Common URL parameters. */
model CommonParams {
  /** The Azure subscription ID. */
  @path
  @segment("subscriptions")
  subscriptionId: SubscriptionId;

  /** Name of the Azure resource group. */
  @path
  @segment("resourceGroups")
  resourceGroupName: ResourceGroupName;

  /** The Azure Quantum resource provider. */
  @path
  @segment("providers")
  provider: ResourceProviderName;

  /** Name of the Azure Quantum workspace. */
  @path
  @segment("workspaces")
  workspaceName: WorkspaceName;
}

/** Azure Subscription. */
@resource("subscriptions")
model Subscription {
  /** The Azure subscription ID. */
  @key
  @visibility(
    Lifecycle.Read,
    Lifecycle.Create,
    Lifecycle.Update,
    Lifecycle.Delete
  )
  subscriptionId: SubscriptionId;
}

/** Azure Resource Group. */
@resource("resourceGroups")
@parentResource(Subscription)
model ResourceGroup {
  /** Name of the Azure resource group. */
  @key
  @visibility(
    Lifecycle.Read,
    Lifecycle.Create,
    Lifecycle.Update,
    Lifecycle.Delete
  )
  resourceGroupName: ResourceGroupName;
}

/** Azure Resource Provider. */
@resource("providers")
@parentResource(ResourceGroup)
model ResourceProvider {
  /** The Azure Quantum resource provider. */
  @key
  @visibility(
    Lifecycle.Read,
    Lifecycle.Create,
    Lifecycle.Update,
    Lifecycle.Delete
  )
  providerName: ResourceProviderName;
}

/** Azure Quantum workspace. */
@resource("workspaces")
@parentResource(ResourceProvider)
model QuantumWorkspace {
  /** Name of the Azure Quantum workspace. */
  @key
  @visibility(
    Lifecycle.Read,
    Lifecycle.Create,
    Lifecycle.Update,
    Lifecycle.Delete
  )
  workspaceName: WorkspaceName;
}
