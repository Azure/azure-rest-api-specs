import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./CodeSigningAccount.tsp";
import "./CertificateProfile.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@doc("Code Signing resource provider api.")
@armProviderNamespace("Microsoft.CodeSigning")
@service(#{ title: "CodeSigningManagementClient" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.CodeSigning;

@doc("The available API versions.")
enum Versions {
  @doc("The 2024-02-05-preview API version.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_02_05_preview: "2024-02-05-preview",

  v2024_09_30_preview: "2024-09-30-preview",
}
