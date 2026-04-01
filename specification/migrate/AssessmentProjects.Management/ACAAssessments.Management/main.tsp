import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

import "./acaroutes.tsp";
import "./ACAApiVersions.tsp";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations endpoint is provided by the parent AssessmentProjects.Management project"
@armProviderNamespace
@service(#{ title: "Azure Migrate Assessment Service" })
@versioned(ACAApiVersions)
@doc("Azure Migrate Resource Provider management API.")
namespace Microsoft.Migrate;
