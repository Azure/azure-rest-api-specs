import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./instance.tsp";
import "./target.tsp";
import "./solution.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@armProviderNamespace
@service({
  title: "Microsoft.IoTOperationsOrchestrator management service.",
})
@doc("Microsoft.IoTOperationsOrchestrator Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.IoTOperationsOrchestrator;

/** Api versions */
enum Versions {
  /** 2023-10-04-preview preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2023-10-04-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}
