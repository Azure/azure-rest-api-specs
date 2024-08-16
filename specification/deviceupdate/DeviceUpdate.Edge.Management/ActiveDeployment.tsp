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
 * The details of an active deployment that is currently being offered to agents.
 */
@parentResource(UpdateAccount)
model ActiveDeployment
  is Azure.ResourceManager.TrackedResource<ActiveDeploymentProperties> {
  ...ResourceNameParameter<
    Resource = ActiveDeployment,
    KeyName = "activeDeploymentName",
    SegmentName = "activeDeployments",
    NamePattern = "^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$"
  >;
}

@armResourceOperations
interface ActiveDeployments {
  /**
   * Returns Active Deployment details.
   */
  get is ArmResourceRead<ActiveDeployment>;

  /**
   * Creates or updates an Active Deployment.
   */
  create is ArmResourceCreateOrReplaceSync<ActiveDeployment>;

  /**
   * Updates Active Deployment.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<ActiveDeployment, TagUpdate>;

  /**
   * Delete Active Deployment.
   */
  delete is ArmResourceDeleteSync<ActiveDeployment>;

  /**
   * Returns active deployments for the given update account name.
   */
  listByUpdateAccount is ArmResourceListByParent<ActiveDeployment>;
}

@@maxLength(ActiveDeployment.name, 73);
@@minLength(ActiveDeployment.name, 1);
@@doc(ActiveDeployment.name, "Active Deployment Name.");
@@doc(ActiveDeployments.create::parameters.resource,
  "Active Deployment details."
);
@@doc(ActiveDeployments.update::parameters.properties, "Updated tags.");

@@encodedName(ActiveDeployments.create::parameters.resource,
  "application/json",
  "activeDeployment"
);
@@clientName(ActiveDeployments.create::parameters.resource, "activeDeployment");

@@encodedName(ActiveDeployments.update::parameters.properties,
  "application/json",
  "tagUpdatePayload"
);
@@clientName(ActiveDeployments.update::parameters.properties,
  "tagUpdatePayload"
);
