import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Nginx.NginxPlus;

model NginxDeployment
  is Azure.ResourceManager.TrackedResource<NginxDeploymentProperties> {
  ...ResourceNameParameter<
    Resource = NginxDeployment,
    KeyName = "deploymentName",
    SegmentName = "nginxDeployments",
    NamePattern = "^([a-z0-9A-Z][a-z0-9A-Z-]{0,28}[a-z0-9A-Z]|[a-z0-9A-Z])$"
  >;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: IdentityProperties;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ResourceSku;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface NginxDeploymentsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /**
         * The name of targeted NGINX deployment
         */
        @path
        @segment("nginxDeployments")
        @pattern("^([a-z0-9A-Z][a-z0-9A-Z-]{0,28}[a-z0-9A-Z]|[a-z0-9A-Z])$")
        deploymentName: string,
      },
      ErrorResponse
    > {}

@armResourceOperations
interface NginxDeployments {
  /**
   * Get the NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Deployments_Get")
  get is ArmResourceRead<NginxDeployment>;

  /**
   * Create or update the NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Deployments_CreateOrUpdate")
  createOrUpdate is NginxDeploymentsOps.CreateOrUpdateAsync<
    NginxDeployment,
    OptionalRequestBody = true
  >;

  /**
   * Update the NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @operationId("Deployments_Update")
  update is NginxDeploymentsOps.CustomPatchAsync<
    NginxDeployment,
    PatchModel = NginxDeploymentUpdateParameters,
    Response = ArmResponse<NginxDeployment> | (ArmResourceCreatedResponse<NginxDeployment> &
      ArmLroLocationHeader),
    OptionalRequestBody = true
  >;

  /**
   * Delete the NGINX deployment resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Deployments_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    NginxDeployment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all NGINX deployments under the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Deployments_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    NginxDeployment,
    Response = ArmResponse<NginxDeploymentListResponse>
  >;

  /**
   * List the NGINX deployments resources
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Deployments_List")
  list is ArmListBySubscription<
    NginxDeployment,
    Response = ArmResponse<NginxDeploymentListResponse>
  >;
}

@@doc(NginxDeployment.name, "The name of targeted NGINX deployment");
@@doc(NginxDeployment.properties, "");
@@doc(NginxDeployments.createOrUpdate::parameters.resource, "");
@@doc(NginxDeployments.update::parameters.properties, "");
