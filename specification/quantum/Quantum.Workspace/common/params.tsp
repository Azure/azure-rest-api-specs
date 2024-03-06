// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

namespace Quantum.Workspace.Common;

@doc("Common URL parameters.")
model CommonParams {
  @query("api-version")
  @doc("The REST API version.")
  @minLength(10)
  @maxLength(18)
  @pattern("^[0-9]{4}-[0-9]{2}-[0-9]{2}(?:-preview)?$")
  @extension("x-ms-parameter-location", "client")
  // Note: it must be a string or it will create a linting error
  apiVersion: string;

  @path
  @segment("subscriptions")
  @doc("The Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
  @minLength(36)
  @maxLength(36)
  @pattern("^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$")
  @extension("x-ms-parameter-location", "client")
  subscriptionId: string;

  @path
  @segment("resourceGroups")
  @doc("Name of an Azure resource group.")
  @minLength(1)
  @maxLength(90)
  // https://learn.microsoft.com/azure/azure-resource-manager/management/resource-name-rules#microsoftresources
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-_\\.]*$")
  @extension("x-ms-parameter-location", "client")
  resourceGroupName: string;

  @path
  @segment("providers")
  @doc("The Azure Quantum provider.")
  provider: "Microsoft.Quantum";

  @path
  @segment("workspaces")
  @doc("Name of the workspace.")
  @minLength(2)
  @maxLength(50)
  // https://learn.microsoft.com/azure/azure-resource-manager/management/resource-name-rules#microsoftquantum
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-_]*$")
  @extension("x-ms-parameter-location", "client")
  workspaceName: string;
}

@doc("Azure Subscription.")
@resource("subscriptions")
model Subscription {
  @doc("The Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
  @key
  @visibility("read")
  @minLength(36)
  @maxLength(36)
  @pattern("^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$")
  @extension("x-ms-parameter-location", "client")
  subscriptionId: string;
}

@doc("Azure Resource Group.")
@resource("resourceGroups")
@parentResource(Subscription)
model ResourceGroup {
  @doc("Name of an Azure resource group.")
  @key
  @visibility("read")
  @minLength(1)
  @maxLength(90)
  // https://learn.microsoft.com/azure/azure-resource-manager/management/resource-name-rules#microsoftresources
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-_\\.]*$")
  @extension("x-ms-parameter-location", "client")
  resourceGroupName: string;
}

@doc("Azure Resource Provider.")
@resource("providers")
@parentResource(ResourceGroup)
model Provider {
  @doc("Name of an Azure resource provider.")
  @key
  @visibility("read")
  providerName: "Microsoft.Quantum";
}

@doc("Azure Quantum workspace.")
@resource("workspaces")
@parentResource(Provider)
model Workspace {
  @doc("Name of the workspace.")
  @key
  @visibility("read")
  @minLength(2)
  @maxLength(50)
  // https://learn.microsoft.com/azure/azure-resource-manager/management/resource-name-rules#microsoftquantum
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-_]*$")
  @extension("x-ms-parameter-location", "client")
  workspaceName: string;
}
