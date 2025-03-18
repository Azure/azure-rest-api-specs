import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./MessagingCatalog.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "Microsoft.MessagingCatalog" })
@doc("Messaging Catalog management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.MessagingCatalog;

/**
 * The available API versions.
 */
enum Versions {
  @doc("The 2024-10-01-preview API version.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_10_01_preview: "2024-10-01-preview",
}
