import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./UpdateAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DeviceUpdate;
/**
 * Deployment details.
 */
@parentResource(UpdateAccount)
model Deployment
  is Azure.ResourceManager.TrackedResource<DeploymentProperties> {
  ...ResourceNameParameter<
    Resource = Deployment,
    KeyName = "deploymentName",
    SegmentName = "deployments",
    NamePattern = "^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$"
  >;
}

@armResourceOperations
interface Deployments {
  /**
   * Returns Deployment details.
   */
  get is ArmResourceRead<Deployment>;

  /**
   * Creates or updates a Deployment.
   */
  create is ArmResourceCreateOrReplaceSync<Deployment>;

  /**
   * Updates Deployment.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<Deployment, TagUpdate>;

  /**
   * Delete Deployment.
   */
  delete is ArmResourceDeleteSync<Deployment>;

  /**
   * Returns deployments for the given update account name.
   */
  listByUpdateAccount is ArmResourceListByParent<Deployment>;

  /**
   * Calculates the list of devices in a deployment along with their state. Useful for getting a list of failed devices.
   */
  calculateDeviceStates is ArmResourceActionSync<
    Deployment,
    void,
    DeploymentDeviceStatesList
  >;

  /**
   * Calculate the status of a deployment including a breakdown of how many devices in the deployment are in progress, completed, or failed.
   */
  calculateStatus is ArmResourceActionSync<Deployment, void, DeploymentStatus>;
}

@@maxLength(Deployment.name, 73);
@@minLength(Deployment.name, 1);
@@doc(Deployment.name, "Deployment Name.");
@@doc(Deployments.create::parameters.resource, "Deployment details.");
@@doc(Deployments.update::parameters.properties, "Updated tags.");
@@doc(Deployments.calculateDeviceStates::parameters.body,
  "Device state filter. Uses OData syntax. Example: deviceState eq 'Succeeded'"
);

@@encodedName(Deployments.create::parameters.resource,
  "application/json",
  "deployment"
);
@@clientName(Deployments.create::parameters.resource, "deployment");

@@encodedName(Deployments.update::parameters.properties,
  "application/json",
  "tagUpdatePayload"
);
@@clientName(Deployments.update::parameters.properties, "tagUpdatePayload");
