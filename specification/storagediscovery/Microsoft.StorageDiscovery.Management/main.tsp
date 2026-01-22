import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./versions.tsp";
import "./workspace.tsp";
import "./report.tsp";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;
using Azure.Core;

/**
 * The Azure Storage Discovery Management API.
 */
@armProviderNamespace
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
@service(#{ title: "StorageDiscoveryClient" })
@versioned(ApiVersion)
namespace Microsoft.StorageDiscovery;
