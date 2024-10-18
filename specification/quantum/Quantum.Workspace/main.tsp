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

/** Azure Quantum Workspace Services */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Non standard use of openapi info metadata for azure spec"
@service({
  title: "Azure Quantum Workspace Services",
})
@useAuth(AzureEntraAuth | AzureApiKeyAuth)
@versioned(QuantumWorkspaceAPIVersion)
@server(
  "https://{region}.{serviceBaseUrl}",
  "Endpoint for the Azure Quantum",
  {
    /** The Azure region where the Azure Quantum Workspace is located. */
    region: string,

    /** The Azure Quantum service base url. */
    serviceBaseUrl: string = "quantum.azure.com",
  }
)
@OpenAPI.info({
  contact: {
    email: "azqengg@microsoft.com",
  },
})
namespace Quantum.Workspace.Services {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" """
    There is no support for JsonPatch in Azure.Core.
    The Azure.Core.ResourceUpdate does not support NoContentResponse and the JsonPatchDocument request body.
    See https://github.com/Azure/typespec-azure/issues/475
    """
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" """
    We had to use a custom ResourceList to avoid an autoroute bug for workspace/jobs and sesssions/{sessionId}/jobs.
    See https://github.com/Azure/typespec-azure/issues/494
    """
  interface Jobs extends Quantum.Workspace.Operations.JobOperations {}

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" """
    We had to use a custom ResourceList to avoid an autoroute bug for workspace/jobs and sesssions/{sessionId}/jobs.
    See https://github.com/Azure/typespec-azure/issues/494
    """
  interface Sessions extends Quantum.Workspace.Operations.SessionOperations {}

  interface Providers extends Quantum.Workspace.Operations.ProviderOperations {}

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no standard operation that fits this scenario"
  interface Storage extends Quantum.Workspace.Operations.StorageOperations {}

  interface Quotas extends Quantum.Workspace.Operations.QuotaOperations {}

  interface TopLevelItems
    extends Quantum.Workspace.Operations.ItemsOperations {}
}
