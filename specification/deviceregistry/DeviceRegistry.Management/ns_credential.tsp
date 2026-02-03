import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "singleton"
@added(Versions.v2025_11_01_preview)
@doc("A Credential Resource")
@parentResource(Namespace)
model Credential is TrackedResource<CredentialProperties> {
  @doc("The name of the Credential tracked resource.")
  @key("credentialName")
  @segment("credentials")
  @path
  name: "default";
}

@added(Versions.v2025_11_01_preview)
@doc("Details of the Credential Resource.")
model CredentialProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@added(Versions.v2025_11_01_preview)
@armResourceOperations
interface Credentials {
  get is ArmResourceRead<Credential>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Credential>;
  delete is ArmResourceDeleteWithoutOkAsync<Credential>;
  // Using 'ArmCustomPatchAsync' instead of 'ArmResourcePatchAsync' to define the correct patch payload for the resource.
  // This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
  // since otherwise it extends the ARM TrackedResource type.
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    Credential,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Credential,
      CredentialProperties
    >
  >;
  listByResourceGroup is ArmResourceListByParent<Credential>;
  synchronize is ArmResourceActionNoResponseContentAsync<Credential, void>;
}
