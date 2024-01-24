import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NginxDeployment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Nginx.NginxPlus;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(NginxDeployment)
@Azure.ResourceManager.Private.armResourceInternal(NginxConfigurationProperties)
@includeInapplicableMetadataInPayload(false)
model NginxConfiguration extends ProxyResourceBase {
  /**
   * The name of configuration, only 'default' is supported value due to the singleton of NGINX conf
   */
  @path
  @key("configurationName")
  @segment("configurations")
  name: string;

  @extension("x-ms-client-flatten", true)
  properties?: NginxConfigurationProperties;
}

@armResourceOperations
interface NginxConfigurations {
  /**
   * Get the NGINX configuration of given NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Configurations_Get")
  get is ArmResourceRead<NginxConfiguration>;

  /**
   * Create or update the NGINX configuration for given NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Configurations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NginxConfiguration,
    BaseParameters<NginxConfiguration>,
    ArmAsyncOperationHeader
  >;

  /**
   * Reset the NGINX configuration of given NGINX deployment to default
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Configurations_Delete")
  delete is ArmResourceDeleteAsync<NginxConfiguration>;

  /**
   * List the NGINX configuration of given NGINX deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Configurations_List")
  list is ArmResourceListByParent<NginxConfiguration>;
}

@@projectedName(NginxConfigurations.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(NginxConfigurations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NginxConfigurations.createOrUpdate::parameters.resource,
  "The NGINX configuration"
);
