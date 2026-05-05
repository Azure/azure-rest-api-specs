import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * User credentials used for publishing activity.
 */
@parentResource(Site)
model Deployment is Azure.ResourceManager.ProxyResource<DeploymentProperties> {
  ...ResourceNameParameter<
    Resource = Deployment,
    KeyName = "id",
    SegmentName = "deployments",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface DeploymentOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** Deployment ID. */
        @path
        @segment("deployments")
        @key
        id: string,
      }
    > {}

@armResourceOperations
interface Deployments {
  /**
   * Description for Get a deployment by its ID for an app, or a deployment slot.
   */
  @summary("Get a deployment by its ID for an app, or a deployment slot.")
  getDeployment is DeploymentOps.Read<
    Deployment,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create a deployment for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create a deployment for an app, or a deployment slot.")
  createDeployment is DeploymentOps.CreateOrUpdateSync<
    Deployment,
    Response = ArmResourceUpdatedResponse<Deployment>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Delete a deployment by its ID for an app, or a deployment slot.
   */
  @summary("Delete a deployment by its ID for an app, or a deployment slot.")
  deleteDeployment is DeploymentOps.DeleteSync<
    Deployment,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List deployments for an app, or a deployment slot.
   */
  @summary("List deployments for an app, or a deployment slot.")
  listDeployments is DeploymentOps.List<
    Deployment,
    Response = ArmResponse<DeploymentCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List deployment log for specific deployment for an app, or a deployment slot.
   */
  @summary("List deployment log for specific deployment for an app, or a deployment slot.")
  @get
  @action("log")
  listDeploymentLog is DeploymentOps.ActionSync<
    Deployment,
    void,
    ArmResponse<Deployment>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface DeploymentOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API gets a deployment for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Deployment ID. */
        @path
        @segment("deployments")
        @key
        id: string,
      }
    > {}

@armResourceOperations
interface DeploymentOperationGroup {
  /**
   * Description for Get a deployment by its ID for an app, or a deployment slot.
   */
  @summary("Get a deployment by its ID for an app, or a deployment slot.")
  getDeploymentSlot is DeploymentOperationGroupOps.Read<
    Deployment,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create a deployment for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create a deployment for an app, or a deployment slot.")
  createDeploymentSlot is DeploymentOperationGroupOps.CreateOrUpdateSync<
    Deployment,
    Response = ArmResourceUpdatedResponse<Deployment>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Delete a deployment by its ID for an app, or a deployment slot.
   */
  @summary("Delete a deployment by its ID for an app, or a deployment slot.")
  deleteDeploymentSlot is DeploymentOperationGroupOps.DeleteSync<
    Deployment,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List deployments for an app, or a deployment slot.
   */
  @summary("List deployments for an app, or a deployment slot.")
  listDeploymentsSlot is DeploymentOperationGroupOps.List<
    Deployment,
    Response = ArmResponse<DeploymentCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List deployment log for specific deployment for an app, or a deployment slot.
   */
  @summary("List deployment log for specific deployment for an app, or a deployment slot.")
  @get
  @action("log")
  listDeploymentLogSlot is DeploymentOperationGroupOps.ActionSync<
    Deployment,
    void,
    ArmResponse<Deployment>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(Deployment.name, "Deployment ID.");
@@doc(Deployment.properties, "Deployment resource specific properties");
@@doc(Deployments.createDeployment::parameters.resource, "Deployment details.");
@@doc(DeploymentOperationGroup.createDeploymentSlot::parameters.resource,
  "Deployment details."
);
