import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

// Network Supported API Versions.
import "./NetworkApiVersions.tsp";

// Add Network Assessment service routes here.
import "./networkroutes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations endpoint is defined in the parent AssessmentProjects.Management"
@armProviderNamespace
@service(#{ title: "Azure Migrate Assessment Service" })
@versioned(NetworkApiVersions)
@doc("Azure Migrate Resource Provider management API.")
namespace Microsoft.Migrate;
