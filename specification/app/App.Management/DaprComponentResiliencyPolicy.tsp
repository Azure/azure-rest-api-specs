import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DaprComponent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Dapr Component Resiliency Policy.
 */
@parentResource(DaprComponent)
model DaprComponentResiliencyPolicy
  is Azure.ResourceManager.ProxyResource<DaprComponentResiliencyPolicyProperties> {
  ...ResourceNameParameter<
    Resource = DaprComponentResiliencyPolicy,
    KeyName = "name",
    SegmentName = "resiliencyPolicies",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DaprComponentResiliencyPolicies {
  /**
   * Get a Dapr component resiliency policy.
   */
  get is ArmResourceRead<DaprComponentResiliencyPolicy>;

  /**
   * Creates or updates a resiliency policy for a Dapr component.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<DaprComponentResiliencyPolicy>;

  /**
   * Delete a resiliency policy for a Dapr component.
   */
  delete is ArmResourceDeleteSync<DaprComponentResiliencyPolicy>;

  /**
   * Get the resiliency policies for a Dapr component.
   */
  list is ArmResourceListByParent<
    DaprComponentResiliencyPolicy,
    Response = ArmResponse<DaprComponentResiliencyPoliciesCollection>
  >;
}

@@doc(DaprComponentResiliencyPolicy.name,
  "Name of the Dapr Component Resiliency Policy."
);
@@doc(DaprComponentResiliencyPolicy.properties,
  "Dapr Component Resiliency Policy resource specific properties"
);
@@doc(DaprComponentResiliencyPolicies.createOrUpdate::parameters.resource,
  "Configuration details of the Dapr Component Resiliency Policy."
);
