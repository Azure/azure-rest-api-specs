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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;

  ...Azure.ResourceManager.EntityTagProperty;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Deployment,
    PatchModel = PatchResourceTagsAndSku
  >;

  /**
   * Deletes the specified deployment associated with the Cognitive Services account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Deployment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the deployments associated with the Cognitive Services account.
   */
  list is ArmResourceListByParent<Deployment>;

  /**
   * Lists the specified deployments skus associated with the Cognitive Services account.
   */
  @get
  @action("skus")
  listSkus is ArmResourceActionSync<
    Deployment,
    void,
    ArmResponse<DeploymentSkuListResult>
  >;
}

@@doc(Deployment.name,
  "The name of the deployment associated with the Cognitive Services Account"
);
@@encodedName(Deployment.eTag, "application/json", "etag");
@@doc(Deployment.properties,
  "Properties of Cognitive Services account deployment."
);
@@doc(Deployments.createOrUpdate::parameters.resource,
  "The deployment properties."
);
@@doc(Deployments.update::parameters.properties, "The deployment properties.");
