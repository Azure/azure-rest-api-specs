import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./operation.tsp";
import "./networkcontainer.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.ContainerNetworking Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.ContainerNetworking" })
@versioned(Versions)
namespace Microsoft.ContainerNetworking;

/** Contoso API versions */
@doc("The available API versions for Microsoft.ContainerNetworking")
enum Versions {
  /** 2025-03-31-preview version */
  @doc("2025-03-31-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_03_31_preview: "2025-03-31-preview",
}
