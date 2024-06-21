import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PortalExtension.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.PortalServices;
/**
 * Extension Deployment
 */
@parentResource(PortalExtension)
model ExtensionDeployment
  is Azure.ResourceManager.TrackedResource<ExtensionDeploymentProperties> {
  /**
   * The name of the deployment
   */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9]+$")
  @path
  @key("deploymentName")
  @segment("deployments")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface PortalExtensionDeployments {
  /**
   * Gets the portal extension deployment.
   */
  get is ArmResourceRead<ExtensionDeployment>;

  /**
   * Deploys an extension.
   */
  create is ArmResourceCreateOrReplaceAsync<ExtensionDeployment>;

  /**
   * Updates an existing portal extension deployment.
   */
  update is ArmCustomPatchSync<
    ExtensionDeployment,
    PatchableExtensionDeployment
  >;

  /**
   * Only deletes if in a terminal state. Deletes the record only but not the actively running code.
   */
  delete is ArmResourceDeleteSync<ExtensionDeployment>;

  /**
   * Gets all the portal extension deployments within an extension.
   */
  listByExtensions is ArmResourceListByParent<ExtensionDeployment>;

  /**
   * Stops or cancels the deployment, if in progress.
   */
  stop is ArmResourceActionSync<ExtensionDeployment, void, void>;
}

@@doc(PortalExtensionDeployments.create::parameters.resource,
  "deployment definition"
);
@@doc(PortalExtensionDeployments.update::parameters.properties,
  "The updatable fields of a portal extension deployment."
);

@@clientName(PortalExtensionDeployments.update::parameters.properties,
  "parameters"
);
@@encodedName(PortalExtensionDeployments.update::parameters.properties,
  "application/json",
  "parameters"
);
