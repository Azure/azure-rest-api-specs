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
  get is ArmResourceRead<
    DeploymentStacksWhatIfResult,
    BaseParameters = TBaseParams
  >;

  /** Lists Deployment stacks at the specified scope. */
  list is ArmResourceListByParent<
    DeploymentStacksWhatIfResult,
    BaseParameters = TBaseParams
  >;

  /** Creates or updates a Deployment stack at the specified scope. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DeploymentStacksWhatIfResult,
    BaseParameters = TBaseParams
  >;

  /** Deletes a Deployment stack by name at the specified scope. When operation completes, status code 200 returned without content. */
  delete is ArmResourceDeleteWithoutOkAsync<
    DeploymentStacksWhatIfResult,
    BaseParameters = TBaseParams,
    Parameters = ActionOnUnmanageDeleteParameters,
    Response = ArmDeletedResponse | ArmDeletedNoContentResponse
  >;

  /** Returns property-level changes that will be made by the deployment if executed. */
  @action("whatIf")
  whatIf is ArmResourceActionAsync<
    DeploymentStacksWhatIfResult,
    void,
    DeploymentStacksWhatIfResult,
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
