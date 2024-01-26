import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Nginx.NginxPlus;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(NginxDeploymentProperties)
model NginxDeployment extends TrackedResourceBase {
  /**
   * The name of targeted NGINX deployment
   */
  @path
  @key("deploymentName")
  @segment("nginxDeployments")
  @visibility("read")
  name: string;

  @extension("x-ms-client-flatten", true)
  properties?: NginxDeploymentProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface NginxDeployments {
  /**
   * Get the NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_Get")
  get is ArmResourceRead<NginxDeployment>;

  /**
   * Create or update the NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NginxDeployment,
    BaseParameters<NginxDeployment>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update the NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Deployments_Update")
  update is ArmCustomPatchAsync<
    NginxDeployment,
    NginxDeploymentUpdateParameters
  >;

  /**
   * Delete the NGINX deployment resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_Delete")
  delete is ArmResourceDeleteAsync<NginxDeployment>;

  /**
   * List all NGINX deployments under the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<NginxDeployment>;

  /**
   * List the NGINX deployments resources
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_List")
  list is ArmListBySubscription<NginxDeployment>;
}

@@projectedName(NginxDeployments.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(NginxDeployments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NginxDeployments.createOrUpdate::parameters.resource, "");
@@projectedName(NginxDeployments.update::parameters.properties, "json", "body");
@@extension(NginxDeployments.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(NginxDeployments.update::parameters.properties, "");
