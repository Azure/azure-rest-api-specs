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

@armResourceOperations(#{ omitTags: true })
interface NGroups {
  /**
   * Get the properties of the specified NGroups resource.
   */
  @summary("NGroups GET REST API")
  get is ArmResourceRead<NGroup, Error = CloudError>;

  /**
   * Create or update a NGroups resource.
   */
  @summary("NGroup PUT REST API")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NGroup>;

  /**
   * Update a specified NGroups resource.
   */
  @patch(#{ implicitOptionality: false })
  @summary("NGroups PATCH REST API")
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
  @summary("NGroups Delete REST API")
  delete is ArmResourceDeleteWithoutOkAsync<
    NGroup,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of all NGroups resources under a resource group.
   */
  @summary("GET NGroups under a resource group REST API.")
  listByResourceGroup is ArmResourceListByParent<
    NGroup,
    Response = ArmResponse<NGroupsListResult>,
    Error = CloudError
  >;

  /**
   * Gets a list of all NGroups resources under a subscription.
   */
  @summary("List NGroups in a subscription.")
  list is ArmListBySubscription<
    NGroup,
    Response = ArmResponse<NGroupsListResult>,
    Error = CloudError
  >;

  /**
   * Starts all container groups in the specified NGroups resource. Compute resources will be allocated and billing will start.
   */
  @summary("Starts all container groups in the specified NGroups resource.")
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
  @summary("Stops all container groups in the specified NGroups resource.")
  stop is ArmResourceActionSync<
    NGroup,
    void,
    NoContentResponse,
    Error = CloudError
  >;

  /**
   * Restarts all container groups in the specified NGroups resource in place. If container image has updates, new image will be downloaded.
   */
  @summary("Restarts all container groups in the specified NGroups resource.")
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
