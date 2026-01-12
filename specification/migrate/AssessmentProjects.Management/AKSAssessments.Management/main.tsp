import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

import "./aksroutes.tsp";
import "./AKSApiVersions.tsp";
import "./back-compatible.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations interface is intentionally excluded"
@armProviderNamespace
@service(#{ title: "Azure Migrate Assessment Service" })
@versioned(AKSApiVersions)
@doc("Azure Migrate Resource Provider management API.")
namespace Microsoft.Migrate;
