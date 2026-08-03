import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

// Common list of supported API versions.
import "./WACAApiVersions.tsp";

// Add Assessment service routes here.
import "./wacasmroutes.tsp";

// using Autorest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations interface is intentionally excluded"
@armProviderNamespace
@service(#{ title: "Azure Migrate Assessment Service" })
@versioned(WACAApiVersions)
@doc("Azure Migrate Resource Provider management API.")
namespace Microsoft.Migrate;
