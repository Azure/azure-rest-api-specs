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
 * Cognitive Services account accelerator deployment, backed by managed compute (GPU) resources.
 */
@added(Versions.v2026_03_15_preview)
@parentResource(Account)
model AcceleratorDeployment
  is Azure.ResourceManager.ProxyResource<AcceleratorDeploymentProperties> {
  ...ResourceNameParameter<
    Resource = AcceleratorDeployment,
    KeyName = "deploymentName",
    SegmentName = "acceleratorDeployments",
    NamePattern = ""
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

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'tags' on the resource envelope for backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<tags> type used for 'AcceleratorDeployment' to support extensible key-value pairs matching service behavior"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@added(Versions.v2026_03_15_preview)
@armResourceOperations
interface AcceleratorDeployments {
  /**
   * Gets the specified accelerator deployment associated with the Cognitive Services account.
   */
  get is ArmResourceRead<AcceleratorDeployment>;

  /**
   * Creates or updates an accelerator deployment associated with the Cognitive Services account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AcceleratorDeployment>;

  /**
   * Updates the specified accelerator deployment associated with the Cognitive Services account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "PATCH for 'createOrUpdate' follows existing service implementation pattern"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AcceleratorDeployment,
    PatchModel = AcceleratorDeploymentPatch
  >;

  /**
   * Deletes the specified accelerator deployment associated with the Cognitive Services account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Delete response codes match existing service endpoint behavior"
  delete is ArmResourceDeleteWithoutOkAsync<
    AcceleratorDeployment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the accelerator deployments associated with the Cognitive Services account.
   */
  list is ArmResourceListByParent<
    AcceleratorDeployment,
    Response = AcceleratorDeploymentListResult
  >;
}

@@doc(AcceleratorDeployment.name,
  "The name of the accelerator deployment associated with the Cognitive Services Account"
);
@@encodedName(AcceleratorDeployment.etag, "application/json", "etag");
@@doc(AcceleratorDeployment.properties,
  "Properties of the Cognitive Services accelerator deployment."
);
@@doc(AcceleratorDeployments.createOrUpdate::parameters.resource,
  "The accelerator deployment properties."
);
@@doc(AcceleratorDeployments.update::parameters.properties,
  "The accelerator deployment patch properties."
);
