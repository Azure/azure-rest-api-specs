import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ScriptLog.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace DeploymentScriptsClient;

/**
 * Custom base parameters to preserve the original lowercase "resourcegroups"
 * path segment for backward compatibility.
 */
model DeploymentScriptBaseParameters {
  ...CommonTypes.ApiVersionParameter;
  ...CommonTypes.SubscriptionIdParameter;

  /** The name of the resource group. The name is case insensitive. */
  @path
  @minLength(1)
  @maxLength(90)
  @segment("resourcegroups")
  resourceGroupName: string;
}

/**
 * Deployment script object.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Existing API uses discriminator pattern for backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Custom kind property for backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Using extends to match original spec structure"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for ARM resource registration"
@discriminator("kind")
@Azure.ResourceManager.Private.armResourceInternal({})
@Http.Private.includeInapplicableMetadataInPayload(false)
model DeploymentScript
  extends Azure.ResourceManager.Foundations.TrackedResource {
  ...ResourceNameParameter<
    Resource = DeploymentScript,
    KeyName = "scriptName",
    SegmentName = "deploymentScripts",
    NamePattern = ""
  >;

  /**
   * Type of the script.
   */
  kind: ScriptType;

  /**
   * Optional property. Managed identity to be used for this deployment script. Currently, only user-assigned MSI is supported.
   */
  @madeOptional(Versions.v2020_10_01)
  identity?: ManagedServiceIdentity;
}

@@clientName(DeploymentScripts.create::parameters.resource, "deploymentScript");
@@clientName(DeploymentScripts.update::parameters.properties,
  "deploymentScript"
);

@armResourceOperations
interface DeploymentScripts {
  /**
   * Creates a deployment script.
   */
  create is ArmResourceCreateOrReplaceAsync<
    DeploymentScript,
    BaseParameters = DeploymentScriptBaseParameters,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates deployment script tags with specified values.
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    DeploymentScript,
    PatchModel = DeploymentScriptUpdateParameter,
    BaseParameters = DeploymentScriptBaseParameters,
    OptionalRequestBody = true
  >;

  /**
   * Gets a deployment script with a given name.
   */
  get is ArmResourceRead<
    DeploymentScript,
    BaseParameters = DeploymentScriptBaseParameters
  >;

  /**
   * Deletes a deployment script. When operation completes, status code 200 returned without content.
   */
  delete is ArmResourceDeleteSync<
    DeploymentScript,
    BaseParameters = DeploymentScriptBaseParameters
  >;

  /**
   * Lists deployments scripts.
   */
  listByResourceGroup is ArmResourceListByParent<
    DeploymentScript,
    BaseParameters = DeploymentScriptBaseParameters,
    Response = ArmResponse<DeploymentScriptListResult>
  >;

  /**
   * Lists all deployment scripts for a given subscription.
   */
  listBySubscription is ArmListBySubscription<
    DeploymentScript,
    Response = ArmResponse<DeploymentScriptListResult>
  >;

  /**
   * Gets deployment script logs for a given deployment script name.
   */
  getLogs is ArmResourceListByParent<
    ScriptLog,
    BaseParameters = DeploymentScriptBaseParameters,
    Response = ArmResponse<ScriptLogsList>
  >;

  /**
   * Gets deployment script logs for a given deployment script name.
   */
  getLogsDefault is ArmResourceRead<
    ScriptLog,
    BaseParameters = DeploymentScriptBaseParameters,
    Parameters = {
      /**
       * The number of lines to show from the tail of the deployment script log. Valid value is a positive number up to 1000. If 'tail' is not provided, all available logs are shown up to container instance log capacity of 4mb.
       */
      @query("tail")
      tail?: int32;
    }
  >;
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
