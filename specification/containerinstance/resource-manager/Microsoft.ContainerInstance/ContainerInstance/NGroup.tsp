import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerInstance;
/**
 * Describes the NGroups resource.
 */
model NGroup
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<NGroupProperties> {
  ...ResourceNameParameter<
    Resource = NGroup,
    KeyName = "ngroupsName",
    SegmentName = "ngroups",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;
  ...Azure.ResourceManager.AvailabilityZonesProperty;

  /**
   * The identity of the NGroup, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: NGroupIdentity;
}

@armResourceOperations
interface NGroups {
  /**
   * Get the properties of the specified NGroups resource.
   */
  get is ArmResourceRead<NGroup>;

  /**
   * Create or update a NGroups resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NGroup>;

  /**
   * Update a specified NGroups resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NGroup,
    PatchModel = NGroupPatch,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = NGroup> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the NGroups resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    NGroup,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of all NGroups resources under a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<NGroup>;

  /**
   * Gets a list of all NGroups resources under a subscription.
   */
  list is ArmListBySubscription<NGroup>;

  /**
   * Starts all container groups in the specified NGroups resource. Compute resources will be allocated and billing will start.
   */
  start is ArmResourceActionAsyncBase<
    NGroup,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NGroup>
  >;

  /**
   * Stops all container groups in the specified NGroups resource. Compute resources will be deallocated and billing will stop.
   */
  stop is ArmResourceActionSync<NGroup, void, NoContentResponse>;

  /**
   * Restarts all container groups in the specified NGroups resource in place. If container image has updates, new image will be downloaded.
   */
  restart is ArmResourceActionAsyncBase<
    NGroup,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NGroup>
  >;
}

@@maxLength(NGroup.name, 63);
@@minLength(NGroup.name, 1);
@@doc(NGroup.name, "The NGroups name.");
@@doc(NGroup.properties, "Describes the properties of the NGroups resource.");
@@doc(NGroups.createOrUpdate::parameters.resource, "The NGroup object.");
@@doc(NGroups.update::parameters.properties, "The NGroup object.");
