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
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("2025-07-28-preview")
  v2025_07_28_preview: "2025-07-28-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
