import "@cadl-lang/rest";
import "@cadl-lang/versioning";
import "@cadl-lang/compiler";
import "@azure-tools/cadl-providerhub";
import "@azure-tools/cadl-azure-core";
import "@azure-tools/cadl-autorest";
import "@azure-tools/cadl-azure-resource-manager";

import "./ApiVersions.tsp";
import "./routes.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace
@service({
  title: "Azure Migrate Assessment Service",
})

@versioned(ApiVersions)
@doc("Azure Migrate Resource Provider management API.")
namespace Microsoft.Migrate;

interface Operations extends Azure.ResourceManager.Operations {}