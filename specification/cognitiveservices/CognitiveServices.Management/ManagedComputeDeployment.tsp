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
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "CogSvc uses lowercase 'etag' field name — EntityTagProperty uses 'eTag' which would be a breaking change"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@added(Versions.v2026_03_15_preview)
@removed(Versions.v2026_05_01)
@armResourceOperations
interface ManagedComputeDeployments {
  /**
   * Gets the specified managed compute deployment associated with the Cognitive Services account.
   */
  get is ArmResourceRead<ManagedComputeDeployment>;

  /**
   * Creates or updates a managed compute deployment associated with the Cognitive Services account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedComputeDeployment>;

  /**
   * Updates the specified managed compute deployment associated with the Cognitive Services account.
   */
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
    PatchModel = PatchResourceSku
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
  ManagedComputeDeployments.update::parameters.properties,
  "The managed compute deployment patch properties."
);
