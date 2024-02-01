import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Microsoft.ComputeSchedule management service",
  version: "2023-12-01-preview",
})
@doc("Microsoft.ComputeSchedule Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@useDependency(Azure.Core.Versions.v1_0_Preview_1)
namespace Microsoft.ComputeSchedule;
