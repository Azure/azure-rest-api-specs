import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
@doc("User credentials used for publishing activity.")
@parentResource(Site)
model Deployment is ProxyResource<DeploymentProperties> {
  @doc("Deployment ID.")
  @path
  @key("id")
  @segment("deployments")
  name: string;
}

@armResourceOperations
interface Deployments {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get a deployment by its ID for an app, or a deployment slot.")
  @operationId("WebApps_GetDeployment")
  getDeployment is ArmResourceRead<Deployment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Create a deployment for an app, or a deployment slot.")
  @operationId("WebApps_CreateDeployment")
  createDeployment is ArmResourceCreateOrReplaceSync<Deployment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Delete a deployment by its ID for an app, or a deployment slot.")
  @operationId("WebApps_DeleteDeployment")
  deleteDeployment is ArmResourceDeleteSync<Deployment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for List deployments for an app, or a deployment slot.")
  @operationId("WebApps_ListDeployments")
  listDeployments is ArmResourceListByParent<Deployment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListDeploymentLog")
  @summary("List deployment log for specific deployment for an app, or a deployment slot.")
  @doc("Description for List deployment log for specific deployment for an app, or a deployment slot.")
  // FIXME: WebApps_ListDeploymentLog could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/deployments/{id}/log")
  @get
  listDeploymentLog is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("The ID of a specific deployment. This is the value of the name property in the JSON response from \"GET /api/sites/{siteName}/deployments\".")
      @path
      id: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    Deployment
  >;
}

@@projectedName(Deployments.createDeployment::parameters.resource,
  "json",
  "deployment"
);
@@extension(Deployments.createDeployment::parameters.resource,
  "x-ms-client-name",
  "deployment"
);
@@doc(Deployments.createDeployment::parameters.resource, "Deployment details.");
