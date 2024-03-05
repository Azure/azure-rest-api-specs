// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";
import "@typespec/versioning";

import "./common/auth.tsp";
import "./common/version.tsp";
import "./common/params.tsp";
import "./common/items.tsp";
import "./common/jobs.tsp";
import "./common/sessions.tsp";
import "./common/providers.tsp";
import "./common/storage.tsp";
import "./common/quotas.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using OpenAPI;

@service({
  title: "Azure Quantum Workspace Services",
})
@useAuth(AzureEntraAuth | AzureApiKeyAuth)
@versioned(APIVersion)
@server(
  "https://{region}.{serviceBaseUrl}",
  "Endpoint for the Azure Quantum",
  {
    @doc("The Azure region where the Azure Quantum Workspace is located.")
    region: string,

    @doc("The Azure Quantum service base url.")
    serviceBaseUrl: string = "quantum.azure.com",
  }
)
@OpenAPI.info({
  contact: {
    email: "azqengg@microsoft.com",
  },
})
@doc("Azure Quantum Workspace Services")
namespace Quantum.Workspace.Services;

@autoRoute
interface JobOperationsRoute extends JobOperations {}

@autoRoute
interface SessionOperationsRoute extends SessionOperations {}

@autoRoute
interface ProviderOperationsRoute extends ProviderOperations {}

@autoRoute
interface StorageOperationsRoute extends StorageOperations {}

@autoRoute
interface QuotaOperationsRoute extends QuotaOperations {}

@autoRoute
interface WorkspaceOperationsRoute extends WorkspaceOperations {}
