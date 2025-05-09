// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Quantum.Workspace;

/** Azure Entra OAuth2 Authentication */
model AzureEntraAuth
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials;
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token";
      scopes: ["https://quantum.microsoft.com/.default"];
    }
  ]>;

/** Azure Api-Key Authentication */
model AzureApiKeyAuth
  is ApiKeyAuth<ApiKeyLocation.header, "x-ms-quantum-api-key">;
