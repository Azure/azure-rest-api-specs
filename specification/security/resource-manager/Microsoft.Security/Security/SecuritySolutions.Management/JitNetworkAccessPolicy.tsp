import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;

@parentResource(ResourceGroupLocationResource)
model JitNetworkAccessPolicy
  is Azure.ResourceManager.ProxyResource<
    JitNetworkAccessPolicyProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = JitNetworkAccessPolicy,
    KeyName = "jitNetworkAccessPolicyName",
    SegmentName = "jitNetworkAccessPolicies",
    NamePattern = ""
  >;

  /**
   * Kind of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: string;

  /**
   * Location where the resource is stored
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

alias JitNetworkAccessPoliciesInitiateOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The location where ASC stores the data of the subscription. can be retrieved from Get locations */
    @path
    @segment("locations")
    @key
    ascLocation: string;

    /** Name of a Just-in-Time access configuration policy. */
    @path
    @segment("jitNetworkAccessPolicies")
    @key
    jitNetworkAccessPolicyName: string;
  },
  {
    @path
    @key
    jitNetworkAccessPolicyInitiateType: JitNetworkAccessPolicyInitiateType;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}/{jitNetworkAccessPolicyInitiateType}",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface JitNetworkAccessPolicies {
  /**
   * Policies for protecting resources using Just-in-Time access control for the subscription, location
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  get is ArmResourceRead<JitNetworkAccessPolicy>;

  /**
   * Create a policy for protecting resources using Just-in-Time access control
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    JitNetworkAccessPolicy,
    Response = ArmResourceUpdatedResponse<JitNetworkAccessPolicy>
  >;

  /**
   * Delete a Just-in-Time access control policy.
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  delete is ArmResourceDeleteSync<JitNetworkAccessPolicy>;

  /**
   * Policies for protecting resources using Just-in-Time access control for the subscription, location
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  listByResourceGroupAndRegion is ArmResourceListByParent<
    JitNetworkAccessPolicy,
    Response = ArmResponse<JitNetworkAccessPoliciesList>
  >;

  /**
   * Policies for protecting resources using Just-in-Time access control for the subscription, location
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  listByRegion is Extension.ListByTarget<
    Extension.Subscription,
    JitNetworkAccessPolicy,
    Response = ArmResponse<JitNetworkAccessPoliciesList>
  >;

  /**
   * Initiate a JIT access from a specific Just-in-Time policy configuration.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}/{jitNetworkAccessPolicyInitiateType}")
  initiate is JitNetworkAccessPoliciesInitiateOps.ActionSync<
    JitNetworkAccessPolicy,
    JitNetworkAccessPolicyInitiateRequest,
    AcceptedResponse & {
      @bodyRoot
      _: JitNetworkAccessRequest;
    }
  >;
}
enum JitNetworkAccessPolicyInitiateType {
  initiate,
}
@@doc(JitNetworkAccessPolicy.name,
  "Name of a Just-in-Time access configuration policy."
);
@@doc(JitNetworkAccessPolicy.properties, "");
@@doc(JitNetworkAccessPolicies.createOrUpdate::parameters.resource, "");
@@doc(JitNetworkAccessPolicies.initiate::parameters.body, "");
