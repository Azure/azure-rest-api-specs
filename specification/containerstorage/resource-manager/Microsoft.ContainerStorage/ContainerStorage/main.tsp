import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

import "./pool.tsp";
import "./volume.tsp";
import "./snapshot.tsp";
import "./assignment.tsp";
import "./back-compatible.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Azure-ContainerStorageRP" })
@versioned(Versions)
@doc("Azure Container Storage Resource Provider API.")
namespace Microsoft.ContainerStorage;

/** Api versions */
enum Versions {
  /** 2023-07-01-preview preview version */
  `2023-07-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}
