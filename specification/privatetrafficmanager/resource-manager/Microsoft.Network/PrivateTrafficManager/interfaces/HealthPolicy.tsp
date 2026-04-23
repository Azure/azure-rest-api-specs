import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "../models/HealthPolicyModels.tsp";

using Rest;
using Azure.ResourceManager;

namespace Microsoft.Network;

@@doc(HealthPolicy.name, "The name of the Traffic Manager health policy.");
@@doc(HealthPolicy.kind, "The kind of the Traffic Manager health policy.");
@@doc(HealthPolicy.properties,
  "The properties of the Traffic Manager health policy."
);
@doc("Class representing a Traffic Manager health policy.")
@parentResource(PrivateTrafficManagerProfile)
@discriminator("kind")
model HealthPolicy is ProxyResource<HealthPolicyProperties> {
  ...ResourceNameParameter<HealthPolicy>;
  ...ResourceKindProperty<HealthPolicyKind>;
}

@doc("Class representing a Traffic Manager health policy of kind Probe.")
model ProbeHealthPolicy extends HealthPolicy {
  kind: HealthPolicyKind.Probe;

  @doc("The health policy for Traffic Manager profile properties.")
  properties?: ProbeHealthPolicyProperties;
}

@@doc(HealthPolicies.createOrUpdate::parameters.resource,
  "The Traffic Manager health policy parameters supplied to the CreateOrUpdate operation."
);
@armResourceOperations
interface HealthPolicies {
  @doc("Gets a Traffic Manager health policy.")
  get is ArmResourceRead<HealthPolicy>;

  @doc("Create or update a Traffic Manager health policy.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<HealthPolicy>;

  // Note: PATCH operation not supported for polymorphic resources.
  // Use CreateOrUpdate (PUT) for modifications.

  @doc("Deletes a Traffic Manager health policy.")
  delete is ArmResourceDeleteWithoutOkAsync<HealthPolicy>;

  @doc("Lists all Health Policies within a Traffic Manager profile.")
  listByParent is ArmResourceListByParent<HealthPolicy>;
}
