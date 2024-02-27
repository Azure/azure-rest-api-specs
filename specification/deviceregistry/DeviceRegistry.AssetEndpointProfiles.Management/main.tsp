import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-resource-manager";
import "./assetEndpointProfile.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Private;
using Azure.ResourceManager.Foundations;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint"
@armProviderNamespace
@service({
  title: "Microsoft.DeviceRegistry management service",
  version: "2023-11-01-preview",
})
@doc("Microsoft.DeviceRegistry Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.DeviceRegistry;
