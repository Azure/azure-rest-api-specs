import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

/** Cluster Jobs resource */
@added(Versions.v2025_12_01_preview)
@parentResource(EdgeMachine)
model EdgeMachineJob
  is Azure.ResourceManager.ProxyResource<EdgeMachineJobProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineJob,
    KeyName = "jobsName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
}

@added(Versions.v2025_12_01_preview)
@armResourceOperations
interface EdgeMachineJobs {
  /** Get a EdgeMachineJob */
  get is ArmResourceRead<EdgeMachineJob>;

  /** Create a EdgeMachineJob */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeMachineJob>;

  /** Delete a EdgeMachineJob */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineJob>;

  /** List EdgeMachineJob resources by EdgeMachines */
  list is ArmResourceListByParent<EdgeMachineJob>;
}

@@doc(EdgeMachineJob.name, "Name of EdgeMachineJob");
