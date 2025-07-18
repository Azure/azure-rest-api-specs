import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./apiVersions.tsp";
import "./clusters.tsp";

using Http;
using Rest;
using Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.OrionDB")
@service(#{ title: "Microsoft.OrionDB management service" })
@versioned(ApiVersions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.OrionDB;

interface Operations extends Azure.ResourceManager.Operations {}