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
interface DeploymentStackWhatIfCommon<
  Scope extends Azure.ResourceManager.Foundations.SimpleResource,
  ResourceName extends valueof string = ""
> {
  /** Gets the Deployment stack with the given name. */
  get is Extension.Read<
    Scope,
    DeploymentStacksWhatIfResult,
    OverrideResourceName = ResourceName
  >;

  /** Lists Deployment stacks at the specified scope. */
  list is Extension.ListByTarget<
    Scope,
    DeploymentStacksWhatIfResult,
    OverrideResourceName = ResourceName
  >;

  /** Creates or updates a Deployment stack at the specified scope. */
  createOrUpdate is Extension.CreateOrReplaceAsync<
    Scope,
    DeploymentStacksWhatIfResult,
    OverrideResourceName = ResourceName
  >;

  /** Deletes a Deployment stack by name at the specified scope. When operation completes, status code 200 returned without content. */
  delete is Extension.DeleteWithoutOkAsync<
    Scope,
    DeploymentStacksWhatIfResult,
    OverrideResourceName = ResourceName,
    Parameters = ActionOnUnmanageDeleteParameters,
    Response = ArmDeletedResponse | ArmDeletedNoContentResponse
  >;

  /** Returns property-level changes that will be made by the deployment if executed. */
  @action("whatIf")
  whatIf is Extension.ActionAsync<
    Scope,
    DeploymentStacksWhatIfResult,
    void,
    DeploymentStacksWhatIfResult,
    OverrideResourceName = ResourceName
  >;
}

@armResourceOperations
@added(Versions.v2025_07_01)
@tag("DeploymentStacksWhatIfResultsAtResourceGroup")
interface DeploymentStacksWhatIfResultsAtResourceGroup
  extends DeploymentStackWhatIfCommon<Extension.ResourceGroup> {}

@armResourceOperations
@added(Versions.v2025_07_01)
@tag("DeploymentStacksWhatIfResultsAtSubscription")
interface DeploymentStacksWhatIfResultsAtSubscription
  extends DeploymentStackWhatIfCommon<Extension.Subscription> {}

@armResourceOperations
@added(Versions.v2025_07_01)
@tag("DeploymentStacksWhatIfResultsAtManagementGroup")
interface DeploymentStacksWhatIfResultsAtManagementGroup
  extends DeploymentStackWhatIfCommon<Extension.ManagementGroup<"managementGroupId">> {}
