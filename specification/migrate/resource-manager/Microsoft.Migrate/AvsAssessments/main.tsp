import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

// Avs Supported API Versions.
import "./AvsApiVersions.tsp";

// Add Avs Assessment service routes here.
import "./avsasmroutes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations interface is intentionally excluded"
@armProviderNamespace
@service(#{ title: "Azure Migrate Assessment Service" })
@versioned(AvsApiVersions)
@doc("Azure Migrate Resource Provider management API.")
namespace Microsoft.Migrate;
