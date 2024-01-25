import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Cognitive Services account deployment.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Account)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(DeploymentProperties)
model Deployment extends ProxyResourceBase {
  /**
   * The name of the deployment associated with the Cognitive Services Account
   */
  @path
  @key("deploymentName")
  @segment("deployments")
  @visibility("read")
  name: string;

  /**
   * Resource Etag.
   */
  @visibility("read")
  etag?: string;

  /**
   * Properties of Cognitive Services account deployment.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DeploymentProperties;

  ...Azure.ResourceManager.ResourceSku;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Deployment,
    BaseParameters<Deployment>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes the specified deployment associated with the Cognitive Services account.
   */
  delete is ArmResourceDeleteAsync<Deployment>;

  /**
   * Gets the deployments associated with the Cognitive Services account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_List")
  list is ArmResourceListByParent<Deployment>;
}

@@projectedName(Deployments.createOrUpdate::parameters.resource,
  "json",
  "deployment"
);
@@extension(Deployments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "deployment"
);
@@doc(Deployments.createOrUpdate::parameters.resource,
  "The deployment properties."
);
