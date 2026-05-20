import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./models-whatIf.tsp";
import "./routeTypes.tsp";
import "./routes-whatIf.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Resources.DeploymentStacks;

// Interface for all stack operations with the scoping parameterized.
// For some reason, the ArmResourceActionAsync type requires the base params extends this reflection model type.
interface DeploymentStackCommonOps<
  Scope extends Azure.ResourceManager.Foundations.SimpleResource,
  ResourceName extends valueof string = ""
> {
  /** Gets the Deployment stack with the given name. */
  get is Extension.Read<
    Scope,
    DeploymentStack,
    OverrideResourceName = ResourceName
  >;

  /** Lists Deployment stacks at the specified scope. */
  list is Extension.ListByTarget<
    Scope,
    DeploymentStack,
    OverrideResourceName = ResourceName
  >;

  /** Runs preflight validation on the Deployment stack template at the specified scope to verify its acceptance to Azure Resource Manager. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Back compat. There's a 400 response for validation failures."
  @added(Versions.v2024_03_01)
  @action("validate")
  validateStack is Extension.ActionAsync<
    Scope,
    DeploymentStack,
    DeploymentStack,
    DeploymentStackValidateResult,
    OverrideResourceName = ResourceName,
    Error = ErrorResponse | ValidationBadRequestResponse<DeploymentStackValidateResult>
  >;

  /** Creates or updates a Deployment stack at the specified scope. */
  createOrUpdate is Extension.CreateOrReplaceAsync<
    Scope,
    DeploymentStack,
    OverrideResourceName = ResourceName
  >;

  /** Deletes a Deployment stack by name at the specified scope. When operation completes, status code 200 returned without content. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Back compat. Synchronous deletes are possible."
  delete is Extension.DeleteWithoutOkAsync<
    Scope,
    DeploymentStack,
    OverrideResourceName = ResourceName,
    Parameters = ActionOnUnmanageDeleteParameters,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /** Exports the template used to create the Deployment stack at the specified scope. */
  @action("exportTemplate")
  exportTemplate is Extension.ActionSync<
    Scope,
    DeploymentStack,
    void,
    ArmResponse<DeploymentStackTemplateDefinition>,
    OverrideResourceName = ResourceName
  >;
}

@armResourceOperations
@tag("DeploymentStacksAtResourceGroup")
interface DeploymentStacksAtResourceGroup
  extends DeploymentStackCommonOps<Extension.ResourceGroup> {}

@armResourceOperations
@tag("DeploymentStacksAtSubscription")
interface DeploymentStacksAtSubscription
  extends DeploymentStackCommonOps<Extension.Subscription> {}

@armResourceOperations
@tag("DeploymentStacksAtManagementGroup")
interface DeploymentStacksAtManagementGroup
  extends DeploymentStackCommonOps<Extension.ManagementGroup<"managementGroupId">> {}
