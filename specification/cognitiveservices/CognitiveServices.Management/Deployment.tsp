import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Cognitive Services account deployment.
 */
@parentResource(Account)
model Deployment is Azure.ResourceManager.ProxyResource<DeploymentProperties> {
  ...ResourceNameParameter<
    Resource = Deployment,
    KeyName = "deploymentName",
    SegmentName = "deployments",
    NamePattern = ""
  >;

  /**
   * The resource model definition representing SKU
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@armResourceOperations
interface Deployments {
  /**
   * Gets the specified deployments associated with the Cognitive Services account.
   */
  get is ArmResourceRead<Deployment>;

  /**
   * Update the state of specified deployments associated with the Cognitive Services account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Deployment>;

  /**
   * Update specified deployments associated with the Cognitive Services account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Deployment,
    PatchModel = PatchResourceTagsAndSku
  >;

  /**
   * Deletes the specified deployment associated with the Cognitive Services account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Deployment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the deployments associated with the Cognitive Services account.
   */
  list is ArmResourceListByParent<Deployment, Response = DeploymentListResult>;

  /**
   * Lists the specified deployments skus associated with the Cognitive Services account.
   */
  @get
  @action("skus")
  @list
  listSkus is ArmResourceActionSync<
    Deployment,
    void,
    ArmResponse<DeploymentSkuListResult>
  >;

  /**
   * Pauses inferencing on a deployment by setting the deploymentState to 'Paused' (see #/definitions/DeploymentProperties/properties/deploymentState). Only Standard, DataZoneStandard, and GlobalStandard SKUs support this operation. Inference requests to the paused deployment endpoint will receive HTTP 423 (Locked). This operation is idempotent.
   */
  pause is ArmResourceActionSync<Deployment, void, ArmResponse<Deployment>>;

  /**
   * Resumes inferencing on a previously paused deployment by setting the deploymentState to 'Running' (see #/definitions/DeploymentProperties/properties/deploymentState). This operation is idempotent and can be safely called on already running deployments.
   */
  resume is ArmResourceActionSync<Deployment, void, ArmResponse<Deployment>>;
}

@@doc(Deployment.name,
  "The name of the deployment associated with the Cognitive Services Account"
);
@@encodedName(Deployment.etag, "application/json", "etag");
@@doc(Deployment.properties,
  "Properties of Cognitive Services account deployment."
);
@@doc(Deployments.createOrUpdate::parameters.resource,
  "The deployment properties."
);
@@doc(Deployments.update::parameters.properties, "The deployment properties.");
@@summary(Deployments.pause, "Pause a deployment");
@@summary(Deployments.resume, "Resume a deployment");
