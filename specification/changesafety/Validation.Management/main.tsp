import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./validation.tsp";
import "./validator.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/ChangeControl.Management/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.ChangeSafety management service",
})
@versioned(Microsoft.ChangeSafety.Versions)
namespace Microsoft.ChangeSafety;

/** The available API versions. */
enum Versions {
  /** 2024-10-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_04_01_preview: "2024-10-01-preview",
}
