import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./resources/organization.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft Azure DevOps Platform" })
@doc("Azure DevOps Platform Management API")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AzureDevOpsPlatform;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Microsoft.AzureDevOpsPlatform API Versions")
enum Versions {
  @doc("Azure DevOps Platform API version 2024-04-01-preview")
  v2024_04_01_preview: "2024-04-01-preview",
}
