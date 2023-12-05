import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./instance.tsp";
import "./pipeline.tsp";
import "./dataset.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
#suppress "@azure-tools/typespec-azure-core/casing-style"
@armProviderNamespace
@service({
  title: "Microsoft.IoTOperationsDataProcessor management service.",
  version: "2023-10-04-preview",
})
@doc("Microsoft.IoTOperationsDataProcessor Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.IoTOperationsDataProcessor;

interface Operations extends Azure.ResourceManager.Operations {}
