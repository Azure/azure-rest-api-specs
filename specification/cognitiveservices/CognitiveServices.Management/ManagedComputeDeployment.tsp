import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/**
 * Cognitive Services account managed compute deployment, backed by managed compute (GPU) resources.
 */
@added(Versions.v2026_03_15_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_15_preview)
@removed(Versions.v2026_07_01)
@added(Versions.v2026_07_15_preview)
@removed(Versions.v2026_09_01)
@added(Versions.v2026_09_15_preview)
@parentResource(Account)
model ManagedComputeDeployment
  is Azure.ResourceManager.ProxyResource<ManagedComputeDeploymentProperties> {
  ...ResourceNameParameter<
    Resource = ManagedComputeDeployment,
    KeyName = "deploymentName",
    SegmentName = "managedComputeDeployments",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9._-]{0,63}$"
  >;

  /**
   * The resource model definition representing SKU
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "CogSvc defines its own Sku model — using ResourceSkuProperty causes duplicate-client-name errors in Java/Python SDK generation due to collision with ARM common-type Sku"
  sku?: Sku;

  /**
   * Identity for the managed compute deployment. For VmManagedCompute, specify a user-assigned identity attached to the selected Foundry project.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Cognitive Services uses its existing Identity contract for managed compute deployments"
  @added(Versions.v2026_09_15_preview)
  identity?: Identity;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Cognitive Services supports tags on this proxy resource"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<string> preserves the existing Cognitive Services tag shape"
  @added(Versions.v2026_09_15_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "CogSvc uses lowercase 'etag' field name — EntityTagProperty uses 'eTag' which would be a breaking change"
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Properties to update the tags and SKU of a managed compute deployment.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "The managed compute PATCH contract updates tags and SKU; deployment identity is supplied through PUT."
@added(Versions.v2026_09_15_preview)
model ManagedComputeDeploymentPatch {
  ...PatchResourceTagsAndSku;
}

@added(Versions.v2026_03_15_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_15_preview)
@removed(Versions.v2026_07_01)
@added(Versions.v2026_07_15_preview)
@removed(Versions.v2026_09_01)
@added(Versions.v2026_09_15_preview)
@armResourceOperations
interface ManagedComputeDeployments {
  /**
   * Gets the specified managed compute deployment associated with the Cognitive Services account.
   */
  get is ArmResourceRead<ManagedComputeDeployment>;

  /**
   * Creates or updates a managed compute deployment associated with the Cognitive Services account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedComputeDeployment,
    Parameters = {
      /**
       * Foundry project used when creating a VmManagedCompute deployment. If omitted, the account's default project is used.
       * A project must be specified through this header or configured as the account default.
       * For an existing deployment, the project resolved at creation is retained.
       */
      @added(Versions.v2026_09_15_preview)
      @header("azureai-project")
      azureAiProject?: string;
    }
  >;

  /**
   * Updates the specified managed compute deployment associated with the Cognitive Services account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Earlier API versions retain the existing SKU-only PATCH contract."
  @added(Versions.v2026_03_15_preview)
  @removed(Versions.v2026_05_01)
  @added(Versions.v2026_05_15_preview)
  @removed(Versions.v2026_07_01)
  @added(Versions.v2026_07_15_preview)
  @removed(Versions.v2026_09_01)
  @renamedFrom(Versions.v2026_09_15_preview, "update")
  @sharedRoute
  @patch(#{ implicitOptionality: false })
  updateLegacy is ArmCustomPatchAsync<
    ManagedComputeDeployment,
    LroHeaders = ArmLroLocationHeader<
      Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
      ManagedComputeDeployment,
      string
    > &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmAsyncOperationHeader,
    PatchModel = PatchResourceSku
  >;

  /**
   * Updates the specified managed compute deployment associated with the Cognitive Services account.
   */
  @added(Versions.v2026_09_15_preview)
  @sharedRoute
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ManagedComputeDeployment,
    LroHeaders = ArmLroLocationHeader<
      Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
      ManagedComputeDeployment,
      string
    > &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmAsyncOperationHeader,
    PatchModel = ManagedComputeDeploymentPatch
  >;

  /**
   * Deletes the specified managed compute deployment associated with the Cognitive Services account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Managed compute deployment delete can complete synchronously with 200 OK, or asynchronously with 202 Accepted and LRO headers."
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedComputeDeployment,
    LroHeaders = ArmCombinedLroHeaders<ArmOperationStatus, void> &
      Azure.Core.Foundations.RetryAfterHeader,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders<
          ArmOperationStatus,
          void
        > &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the managed compute deployments associated with the Cognitive Services account.
   */
  list is ArmResourceListByParent<
    ManagedComputeDeployment,
    Response = ManagedComputeDeploymentListResult
  >;
}

@@doc(
  ManagedComputeDeployment.name,
  "The name of the managed compute deployment associated with the Cognitive Services Account"
);
@@encodedName(ManagedComputeDeployment.etag, "application/json", "etag");
@@doc(
  ManagedComputeDeployment.properties,
  "Properties of the Cognitive Services managed compute deployment."
);
@@doc(
  ManagedComputeDeployments.createOrUpdate::parameters.resource,
  "The managed compute deployment properties."
);
@@doc(
  ManagedComputeDeployments.updateLegacy::parameters.properties,
  "The managed compute deployment patch properties."
);
@@doc(
  ManagedComputeDeployments.update::parameters.properties,
  "The managed compute deployment patch properties."
);
