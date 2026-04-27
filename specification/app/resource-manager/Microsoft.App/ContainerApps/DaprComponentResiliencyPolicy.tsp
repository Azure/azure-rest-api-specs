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

alias DaprComponentResiliencyPolicyOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the managed environment. */
    @path
    @segment("managedEnvironments")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    environmentName: string;

    /** Name of the Dapr Component. */
    @path
    @segment("daprComponents")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    componentName: string;
  },
  {
    /** Name of the Dapr Component Resiliency Policy. */
    @path
    @segment("resiliencyPolicies")
    @key
    name: string;
  },
  ErrorType = DefaultErrorResponse
>;

@armResourceOperations
interface DaprComponentResiliencyPolicies {
  /**
   * Get a Dapr component resiliency policy.
   */
  @summary("Get a Dapr component resiliency policy.")
  get is DaprComponentResiliencyPolicyOps.Read<DaprComponentResiliencyPolicy>;

  /**
   * Creates or updates a resiliency policy for a Dapr component.
   */
  @summary("Creates or updates a Dapr component resiliency policy.")
  createOrUpdate is DaprComponentResiliencyPolicyOps.CreateOrUpdateAsync<
    DaprComponentResiliencyPolicy,
    Response = ArmResourceUpdatedResponse<DaprComponentResiliencyPolicy> | (CreatedResponse & {
      @bodyRoot body: DaprComponentResiliencyPolicy;
    })
  >;

  /**
   * Delete a resiliency policy for a Dapr component.
   */
  @summary("Delete a Dapr component resiliency policy.")
  delete is DaprComponentResiliencyPolicyOps.DeleteSync<DaprComponentResiliencyPolicy>;

  /**
   * Get the resiliency policies for a Dapr component.
   */
  @summary("Get the resiliency policies for a Dapr component.")
  list is DaprComponentResiliencyPolicyOps.List<
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
