import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./employee.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Contoso Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.Contoso management service" })
@versioned(Microsoft.Contoso.Versions)
namespace Microsoft.Contoso;

/** The available API versions. */
enum Versions {
  /** 2021-10-01-preview version */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-common-types-version" "Retain common-types v5 for this existing API version to preserve its emitted contract."
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2021_10_01_preview: "2021-10-01-preview",

  /** 2021-11-01 version */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-common-types-version" "Retain common-types v5 for this existing API version to preserve its emitted contract."
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2021_11_01: "2021-11-01",
}

interface Operations extends Azure.ResourceManager.Operations {}
