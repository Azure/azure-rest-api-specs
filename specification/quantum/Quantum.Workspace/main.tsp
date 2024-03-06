// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";
import "@typespec/versioning";

import "./common/versions.tsp";
import "./common/auth.tsp";
import "./common/params.tsp";
import "./operations/items.tsp";
import "./operations/jobs.tsp";
import "./operations/sessions.tsp";
import "./operations/providers.tsp";
import "./operations/storage.tsp";
import "./operations/quotas.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using OpenAPI;

@service({
  title: "Azure Quantum Workspace Services",
})
@useAuth(AzureEntraAuth | AzureApiKeyAuth)
@versioned(QuantumWorkspaceAPIVersion)
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

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Backward compatibility with service and Swagger"
@autoRoute
interface Jobs extends Quantum.Workspace.Jobs.JobOperations {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Backward compatibility with service and Swagger"
@autoRoute
interface Sessions extends Quantum.Workspace.Sessions.SessionOperations {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Backward compatibility with service and Swagger"
@autoRoute
interface Providers extends Quantum.Workspace.Providers.ProviderOperations {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Backward compatibility with service and Swagger"
@autoRoute
interface Storage extends Quantum.Workspace.Storage.StorageOperations {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Backward compatibility with service and Swagger"
@autoRoute
interface Quotas extends Quantum.Workspace.Quotas.QuotaOperations {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Backward compatibility with service and Swagger"
@autoRoute
interface TopLevelItems extends Quantum.Workspace.Items.ItemsOperations {}
