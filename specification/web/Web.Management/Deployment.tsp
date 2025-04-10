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

namespace Microsoft.CertificateRegistration;
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
}

@armResourceOperations
interface DeploymentOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = Deployment,
        KeyName = "id",
        SegmentName = "deployments",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Deployments {
  /**
   * Description for Get a deployment by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetDeployment")
  getDeployment is DeploymentOps.Read<Deployment>;

  /**
   * Description for Create a deployment for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateDeployment")
  createDeployment is DeploymentOps.CreateOrUpdateSync<
    Deployment,
    Response = ArmResourceUpdatedResponse<Deployment>
  >;

  /**
   * Description for Delete a deployment by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeleteDeployment")
  deleteDeployment is DeploymentOps.DeleteSync<Deployment>;

  /**
   * Description for List deployments for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListDeployments")
  listDeployments is DeploymentOps.List<
    Deployment,
    Response = ArmResponse<DeploymentCollection>
  >;

  /**
   * Description for List deployment log for specific deployment for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("log")
  @operationId("WebApps_ListDeploymentLog")
  listDeploymentLog is DeploymentOps.ActionSync<
    Deployment,
    void,
    ArmResponse<Deployment>
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
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "slot",
          SegmentName = "slots",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = Deployment,
        KeyName = "id",
        SegmentName = "deployments",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DeploymentOperationGroup {
  /**
   * Description for Get a deployment by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetDeploymentSlot")
  getDeploymentSlot is DeploymentOperationGroupOps.Read<Deployment>;

  /**
   * Description for Create a deployment for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateDeploymentSlot")
  createDeploymentSlot is DeploymentOperationGroupOps.CreateOrUpdateSync<
    Deployment,
    Response = ArmResourceUpdatedResponse<Deployment>
  >;

  /**
   * Description for Delete a deployment by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeleteDeploymentSlot")
  deleteDeploymentSlot is DeploymentOperationGroupOps.DeleteSync<Deployment>;

  /**
   * Description for List deployments for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListDeploymentsSlot")
  listDeploymentsSlot is DeploymentOperationGroupOps.List<
    Deployment,
    Response = ArmResponse<DeploymentCollection>
  >;

  /**
   * Description for List deployment log for specific deployment for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("log")
  @operationId("WebApps_ListDeploymentLogSlot")
  listDeploymentLogSlot is DeploymentOperationGroupOps.ActionSync<
    Deployment,
    void,
    ArmResponse<Deployment>
  >;
}

@@doc(Deployment.name, "Deployment ID.");
@@doc(Deployment.properties, "Deployment resource specific properties");
@@doc(Deployments.createDeployment::parameters.resource, "Deployment details.");
@@doc(DeploymentOperationGroup.createDeploymentSlot::parameters.resource,
  "Deployment details."
);
