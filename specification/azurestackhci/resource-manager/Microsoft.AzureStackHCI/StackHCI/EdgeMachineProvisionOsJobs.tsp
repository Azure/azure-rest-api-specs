import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "./EdgeMachine.tsp";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureStackHCI;

/** Provision OS jobs resource of an edge machine. */
@added(Versions.v2027_01_15_preview)
@parentResource(EdgeMachine)
model ProvisionOsJobs
  is Azure.ResourceManager.ProxyResource<EdgeMachineProvisionOsJobProperties> {
  ...ResourceNameParameter<
    Resource = ProvisionOsJobs,
    KeyName = "provisionOsJobName",
    SegmentName = "provisionOsJobs",
    NamePattern = "^[a-zA-Z0-9-]{3,63}$"
  >;
}

@@doc(
  ProvisionOsJobs.name,
  "Name of the provision OS job. Must be 3 to 63 characters containing only letters, digits, and hyphens."
);

/** Operations for edge machine provision OS job history. */
@added(Versions.v2027_01_15_preview)
@armResourceOperations
interface ProvisionOsJobOperations {
  /** Get a provision OS job, including its job properties. */
  get is ArmResourceRead<ProvisionOsJobs>;

  /** Create or update a provision OS job. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ProvisionOsJobs>;

  /** Delete a provision OS job. */
  delete is ArmResourceDeleteWithoutOkAsync<ProvisionOsJobs>;

  /** List provision OS jobs by edge machine. */
  list is ArmResourceListByParent<
    ProvisionOsJobs,
    Response = ArmResponse<ProvisionOsJobListResult>
  >;
}
