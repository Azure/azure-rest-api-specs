import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./managedOps.tsp";

using Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Managed Operations control plane service" })
@doc("Managed Operations API.")
@versioned(Microsoft.ManagedOps.Versions)
namespace Microsoft.ManagedOps;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("2025-05-19-preview")
  v2025_05_19_preview: "2025-05-19-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
