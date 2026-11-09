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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-common-types-version" "Retain common-types v5 for this existing API version to preserve its emitted contract."
  v2023_06_01_preview: "2023-06-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
