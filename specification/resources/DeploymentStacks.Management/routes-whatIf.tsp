import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./models-whatIf.tsp";
import "./routeTypes.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Resources.DeploymentStacks;

// Interface for all what-if operations for deployment stacks.
@added(Versions.v2025_07_01)
interface DeploymentStackWhatIfCommon<TBaseParams extends TypeSpec.Reflection.Model> {
  /** Gets the Deployment stack with the given name. */
  getWhatIf is ArmResourceRead<DeploymentStackWhatIfResult, BaseParameters = TBaseParams>;

  /** Lists Deployment stacks at the specified scope. */
  listWhatIf is ArmResourceListByParent<
    DeploymentStackWhatIfResult,
    BaseParameters = TBaseParams
  >;

  /** Creates or updates a Deployment stack at the specified scope. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DeploymentStackWhatIfResult,
    BaseParameters = TBaseParams
  >;

  /** Deletes a Deployment stack by name at the specified scope. When operation completes, status code 200 returned without content. */
  delete is ArmResourceDeleteWithoutOkAsync<
    DeploymentStackWhatIfResult,
    BaseParameters = TBaseParams,
    Parameters = ActionOnUnmanageDeleteParameters,
    Response = ArmDeletedResponse | ArmDeletedNoContentResponse
  >;

  /** Exports the template used to create the Deployment stack at the specified scope. */
  @action("whatIf")
  whatIf is ArmResourceActionSync<
    DeploymentStackWhatIfResult,
    void,
    ArmResponse<DeploymentStackTemplateDefinition>,
    BaseParameters = TBaseParams
  >;
}

@armResourceOperations
@added(Versions.v2025_07_01)
@tag("DeploymentStacksWhatIfResultsAtResourceGroup")
interface DeploymentStacksWhatIfResultsAtResourceGroup
  extends DeploymentStackWhatIfCommon<ResourceGroupBaseParameters> {}

@armResourceOperations
@added(Versions.v2025_07_01)
@tag("DeploymentStacksWhatIfResultsAtSubscription")
interface DeploymentStacksWhatIfResultsAtSubscription
  extends DeploymentStackWhatIfCommon<SubscriptionBaseParameters> {}

@armResourceOperations
@added(Versions.v2025_07_01)
@tag("DeploymentStacksWhatIfResultsAtManagementGroup")
interface DeploymentStacksWhatIfResultsAtManagementGroup
  extends DeploymentStackWhatIfCommon<ManagementGroupIdBaseParameters> {}