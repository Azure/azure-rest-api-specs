import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./policy.tsp";
import "./backcompat.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

/** Creates a Microsoft.Purview management client. */
@armProviderNamespace
@service(#{ title: "PurviewPolicyClient" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Purview;

/** The available API versions. */
enum Versions {
  /** 2023-06-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_06_01_preview: "2023-06-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
