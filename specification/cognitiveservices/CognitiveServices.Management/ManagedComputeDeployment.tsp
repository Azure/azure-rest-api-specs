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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'sku' on the resource envelope for backward compatibility"
  sku?: Sku;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'etag' on the resource envelope for backward compatibility"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@added(Versions.v2026_03_15_preview)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "PATCH for 'createOrUpdate' follows existing service implementation pattern"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "ManagedComputeDeployment can have dependent resources, deleting it will be a LRO, result code will be 202. If the dependent resource is not provisioned, the result code will be 200."
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedComputeDeployment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the managed compute deployments associated with the Cognitive Services account.
   */
  list is ArmResourceListByParent<
    ManagedComputeDeployment,
    Response = ManagedComputeDeploymentListResult
  >;
}

@@doc(ManagedComputeDeployment.name,
  "The name of the managed compute deployment associated with the Cognitive Services Account"
);
@@encodedName(ManagedComputeDeployment.etag, "application/json", "etag");
@@doc(ManagedComputeDeployment.properties,
  "Properties of the Cognitive Services managed compute deployment."
);
@@doc(ManagedComputeDeployments.createOrUpdate::parameters.resource,
  "The managed compute deployment properties."
);
@@doc(ManagedComputeDeployments.update::parameters.properties,
  "The managed compute deployment patch properties."
);
