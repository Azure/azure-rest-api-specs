import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./AutoProject.tsp";
import "./autoProjectModels.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * REST API for Azure Logic Apps — AutoProject resource.
 */
@armProviderNamespace
@service(#{ title: "LogicManagementClient" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.Logic;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-01-01-preview API version.
   */
  v2026_01_01_preview: "2026-01-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
