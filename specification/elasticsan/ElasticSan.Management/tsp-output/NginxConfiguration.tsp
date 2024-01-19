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

@parentResource(NginxDeployment)
model NginxConfiguration is ProxyResource<NginxConfigurationProperties> {
  @doc("The name of configuration, only 'default' is supported value due to the singleton of NGINX conf")
  @path
  @key("configurationName")
  @segment("configurations")
  name: string;
}

@armResourceOperations
interface NginxConfigurations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the NGINX configuration of given NGINX deployment")
  @operationId("Configurations_Get")
  get is ArmResourceRead<NginxConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update the NGINX configuration for given NGINX deployment")
  @operationId("Configurations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    NginxConfiguration,
    BaseParameters<NginxConfiguration>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Reset the NGINX configuration of given NGINX deployment to default")
  @operationId("Configurations_Delete")
  delete is ArmResourceDeleteAsync<NginxConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the NGINX configuration of given NGINX deployment.")
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
