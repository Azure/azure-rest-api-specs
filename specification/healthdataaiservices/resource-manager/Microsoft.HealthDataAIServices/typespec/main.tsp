import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.HealthDataAIServices")
@service({
  title: "Microsoft.HealthDataAIServices",
  version: "2023-06-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.HealthDataAIServices;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
#suppress "@azure-tools/typespec-azure-core/casing-style" "Case-sensitive name"

@doc("A HealthDataAIServicesProviderHub resource")
model DeidService is TrackedResource<DeidServiceProperties> {
  @doc("The name of the deid service")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("DeidServiceName")
  @segment("DeidServices")
  @path
  name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}

@doc("Details of the HealthDataAIServices DeidService.")
model DeidServiceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
  @visibility("read")
  @doc("Deid service url.")
  serviceUrl?: string;
}

@armResourceOperations
interface DeidServices {
  get is ArmResourceRead<DeidService>;
  create is ArmResourceCreateOrUpdateSync<DeidService>;
  update is ArmResourcePatchSync<DeidService, DeidServiceProperties>;
  delete is ArmResourceDeleteSync<DeidService>;
  listByResourceGroup is ArmResourceListByParent<DeidService>;
  listBySubscription is ArmListBySubscription<DeidService>;
}
