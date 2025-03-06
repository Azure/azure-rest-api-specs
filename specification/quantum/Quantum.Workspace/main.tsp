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
@service(#{ title: "Azure Quantum Workspace Services" })
@useAuth(AzureEntraAuth | AzureApiKeyAuth)
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
@versioned(QuantumWorkspaceAPIVersion)
@OpenAPI.info(#{ contact: #{ email: "azqengg@microsoft.com" } })
namespace Quantum.Workspace;
