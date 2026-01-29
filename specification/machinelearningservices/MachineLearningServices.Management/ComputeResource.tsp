import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;
// FIXME: ComputeResource has no properties property
/**
 * Machine Learning compute object wrapped into ARM resource envelope.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
#suppress "@azure-tools/typespec-client-generator-core/legacy-hierarchy-building-conflict" "Required for SDK backward compatibility"
@parentResource(Workspace)
model ComputeResource is Azure.ResourceManager.ProxyResource<Compute> {
  ...ResourceNameParameter<
    Resource = ComputeResource,
    KeyName = "computeName",
    SegmentName = "computes",
    NamePattern = "^[a-zA-Z](?![a-zA-Z0-9-]*-\\d+$)[a-zA-Z0-9\\-]{2,23}$"
  >;

  /**
   * Specifies the location of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API includes additional envelope properties"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  location?: string;

  /**
   * Contains resource tags defined as key/value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API includes additional envelope properties"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  tags?: Record<string> | null;

  /**
   * The sku of the workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API includes additional envelope properties"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract allows null values"
  sku?: Azure.ResourceManager.Foundations.Sku | null;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface ComputeResources {
  /**
   * Gets compute definition by its name. Any secrets (storage keys, service credentials, etc) are not returned - use 'keys' nested resource to get them.
   */
  get is ArmResourceRead<ComputeResource>;

  /**
   * Creates or updates compute. This call will overwrite a compute if it exists. This is a nonrecoverable operation. If your intent is to create a new compute, do a GET first to verify that it does not exist yet.
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "LRO final state pattern matches existing API behavior"
  @Azure.Core.useFinalStateVia("location")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ComputeResource,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ComputeResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates properties of a compute. This call will overwrite a compute if it exists. This is a nonrecoverable operation.
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "LRO final state pattern matches existing API behavior"
  @Azure.Core.useFinalStateVia("location")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ComputeResource,
    PatchModel = ClusterUpdateParameters,
    Response = ArmResponse<ComputeResource> &
      ArmCombinedLroHeaders<FinalResult = ComputeResource>
  >;

  /**
   * Deletes specified Machine Learning compute.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API returns additional response codes for LRO delete"
  delete is ArmResourceDeleteWithoutOkAsync<
    ComputeResource,
    Parameters = {
      /**
       * Delete the underlying compute if 'Delete', or detach the underlying compute from workspace if 'Detach'.
       */
      @query("underlyingResourceAction")
      underlyingResourceAction: UnderlyingResourceAction;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse
  >;

  /**
   * Gets computes in specified workspace.
   */
  list is ArmResourceListByParent<
    ComputeResource,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    },
    Response = ArmResponse<PaginatedComputeResourcesList>
  >;

  /**
   * Updates the custom services list. The list of custom services provided shall be overwritten.
   */
  @removed(Versions.v2025_12_01)
  @added(Versions.v2026_01_15_preview)
  @action("customServices")
  updateCustomServices is ArmResourceActionSync<
    ComputeResource,
    CustomService[],
    Response = {
      @body body: void;
    }
  >;

  /**
   * Get the details (e.g IP address, port etc) of all the compute nodes in the compute.
   */
  @list
  listNodes is ArmResourceActionSync<
    ComputeResource,
    void,
    ArmResponse<AmlComputeNodesInformation>
  >;

  /**
   * Gets secrets related to Machine Learning compute (storage keys, service credentials, etc).
   */
  listKeys is ArmResourceActionSync<
    ComputeResource,
    void,
    ArmResponse<ComputeSecrets>
  >;

  /**
   * Update Data Mounts of a Machine Learning compute.
   */
  @removed(Versions.v2025_12_01)
  @added(Versions.v2026_01_15_preview)
  @summary("Update Data Mounts of a Machine Learning compute.")
  updateDataMounts is ArmResourceActionSync<
    ComputeResource,
    ComputeInstanceDataMount[],
    Response = {
      @body body: void;
    }
  >;

  /**
   * Posts a start action to a compute instance
   */
  start is ArmResourceActionAsyncBase<
    ComputeResource,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ComputeResource>
  >;

  /**
   * Posts a stop action to a compute instance
   */
  stop is ArmResourceActionAsyncBase<
    ComputeResource,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ComputeResource>
  >;

  /**
   * Posts a restart action to a compute instance
   */
  restart is ArmResourceActionAsyncBase<
    ComputeResource,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ComputeResource>
  >;

  /**
   * Updates the idle shutdown setting of a compute instance.
   */
  @removed(Versions.v2025_12_01)
  @added(Versions.v2026_01_15_preview)
  updateIdleShutdownSetting is ArmResourceActionSync<
    ComputeResource,
    IdleShutdownSetting,
    Response = {
      @body body: void;
    }
  >;

  /**
   * Returns supported virtual machine sizes for resize.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required for swagger compatibility"
  @removed(Versions.v2025_12_01)
  @added(Versions.v2026_01_15_preview)
  @operationId("Compute_getAllowedResizeSizes")
  @action("getAllowedVmSizesForResize")
  getAllowedResizeSizes is ArmResourceActionSync<
    ComputeResource,
    void,
    ArmResponse<VirtualMachineSizeListResult>
  >;

  /**
   * Updates the size of a Compute Instance.
   */
  @removed(Versions.v2025_12_01)
  @added(Versions.v2026_01_15_preview)
  resize is ArmResourceActionAsyncBase<
    ComputeResource,
    ResizeSchema,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ComputeResource>
  >;
}

@@doc(ComputeResource.name, "Name of the Azure Machine Learning compute.");
@@doc(ComputeResources.createOrUpdate::parameters.resource,
  "Payload with Machine Learning compute definition."
);
@@doc(ComputeResources.update::parameters.properties,
  "Additional parameters for cluster update."
);
@@doc(ComputeResources.updateCustomServices::parameters.body,
  "New list of Custom Services."
);
@@doc(ComputeResources.updateDataMounts::parameters.body,
  "The parameters for creating or updating a machine learning workspace."
);
@@doc(ComputeResources.updateIdleShutdownSetting::parameters.body,
  "The object for updating idle shutdown setting of specified ComputeInstance."
);
@@doc(ComputeResources.resize::parameters.body,
  "The object for updating VM size setting of specified Compute Instance."
);
@@doc(ComputeResource.identity, "The identity of the resource.");
