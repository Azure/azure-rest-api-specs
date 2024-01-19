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

model NginxDeployment is TrackedResource<NginxDeploymentProperties> {
  @doc("The name of targeted NGINX deployment")
  @path
  @key("deploymentName")
  @segment("nginxDeployments")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface NginxDeployments {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the NGINX deployment")
  @operationId("Deployments_Get")
  get is ArmResourceRead<NginxDeployment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update the NGINX deployment")
  @operationId("Deployments_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    NginxDeployment,
    BaseParameters<NginxDeployment>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update the NGINX deployment")
  @operationId("Deployments_Update")
  update is ArmCustomPatchAsync<
    NginxDeployment,
    NginxDeploymentUpdateParameters
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the NGINX deployment resource")
  @operationId("Deployments_Delete")
  delete is ArmResourceDeleteAsync<NginxDeployment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all NGINX deployments under the specified resource group.")
  @operationId("Deployments_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<NginxDeployment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the NGINX deployments resources")
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
