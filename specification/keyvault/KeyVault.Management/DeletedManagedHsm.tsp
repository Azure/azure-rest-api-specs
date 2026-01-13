import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KeyVault;

@subscriptionResource
@parentResource(SubscriptionLocationResource)
model DeletedManagedHsm
  is Azure.ResourceManager.ProxyResource<DeletedManagedHsmProperties> {
  ...ResourceNameParameter<
    Resource = DeletedManagedHsm,
    KeyName = "name",
    SegmentName = "deletedManagedHSMs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DeletedManagedHsms {
  /**
   * Gets the specified deleted managed HSM.
   */
  getDeleted is ArmResourceRead<DeletedManagedHsm, Error = ManagedHsmError>;

  /**
   * Permanently deletes the specified managed HSM.
   */
  @action("purge")
  purgeDeleted is ArmResourceActionAsyncBase<
    DeletedManagedHsm,
    void,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = ManagedHsmError
  >;
}

@@doc(DeletedManagedHsm.name, "The name of the deleted managed HSM.");
@@doc(DeletedManagedHsm.properties, "Properties of the deleted managed HSM");
