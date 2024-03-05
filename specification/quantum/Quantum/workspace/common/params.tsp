// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;

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
  @format("uuid")
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
