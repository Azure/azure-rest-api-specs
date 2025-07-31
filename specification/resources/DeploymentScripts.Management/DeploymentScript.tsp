import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace DeploymentScriptsClient;

/**
 * Deployment script object.
 */
@discriminator("kind")
model DeploymentScript
  is TrackedResource<DeploymentScriptPropertiesBase> {
  ...ResourceNameParameter<
    Resource = DeploymentScript,
    KeyName = "scriptName",
    SegmentName = "deploymentScripts",
    NamePattern = ""
  >;

  /**
   * Optional property. Managed identity to be used for this deployment script. Currently, only user-assigned MSI is supported.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;

  /**
   * Type of the script.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: ScriptType;
}

@armResourceOperations
interface DeploymentScripts {
  /**
   * Gets a deployment script with a given name.
   */
  get is ArmResourceRead<DeploymentScript>;

  /**
   * Creates a deployment script.
   */
  create is ArmResourceCreateOrReplaceAsync<
    DeploymentScript,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates deployment script tags with specified values.
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    DeploymentScript,
    PatchModel = DeploymentScriptUpdateParameter,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    OptionalRequestBody = true
  >;

  /**
   * Deletes a deployment script. When operation completes, status code 200 returned without content.
   */
  delete is ArmResourceDeleteSync<DeploymentScript>;

  /**
   * Lists deployments scripts.
   */
  listByResourceGroup is ArmResourceListByParent<DeploymentScript>;
  
  /**
   * Lists all deployment scripts for a given subscription.
   */
  listBySubscription is ArmListBySubscription<DeploymentScript>;
}

@@maxLength(DeploymentScript.name, 90);
@@minLength(DeploymentScript.name, 1);
@@doc(DeploymentScript.name, "Name of the deployment script.");
@@doc(DeploymentScripts.create::parameters.resource,
  "Deployment script supplied to the operation."
);
@@doc(DeploymentScripts.update::parameters.properties,
  "Deployment script resource with the tags to be updated."
);
