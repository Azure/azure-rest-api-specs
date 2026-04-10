import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;

  /**
   * Location where the resource is stored
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
    /** Type of the action to do on the Just-in-Time access policy. */
    @path
    @key
    jitNetworkAccessPolicyInitiateType: JitNetworkAccessPolicyInitiateType;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}/{jitNetworkAccessPolicyInitiateType}",
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ allowStaticRoutes: true })
@tag("JitNetworkAccessPolicies")
interface JitNetworkAccessPolicies {
  /**
   * Policies for protecting resources using Just-in-Time access control for the subscription, location
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  get is ArmResourceRead<JitNetworkAccessPolicy, Error = CloudError>;

  /**
   * Create a policy for protecting resources using Just-in-Time access control
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    JitNetworkAccessPolicy,
    Response = ArmResourceUpdatedResponse<JitNetworkAccessPolicy>,
    Error = CloudError
  >;

  /**
   * Delete a Just-in-Time access control policy.
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  delete is ArmResourceDeleteSync<JitNetworkAccessPolicy, Error = CloudError>;

  /**
   * Policies for protecting resources using Just-in-Time access control for the subscription, location
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  listByResourceGroupAndRegion is ArmResourceListByParent<
    JitNetworkAccessPolicy,
    Response = ArmResponse<JitNetworkAccessPoliciesList>,
    Error = CloudError
  >;

  /**
   * Policies for protecting resources using Just-in-Time access control for the subscription, location
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  listByRegion is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.Subscription,
    JitNetworkAccessPolicy,
    Response = ArmResponse<JitNetworkAccessPoliciesList>,
    Error = CloudError
  >;

  /**
   * Initiate a JIT access from a specific Just-in-Time policy configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/locations/{ascLocation}/jitNetworkAccessPolicies/{jitNetworkAccessPolicyName}/{jitNetworkAccessPolicyInitiateType}")
  initiate is JitNetworkAccessPoliciesInitiateOps.ActionSync<
    JitNetworkAccessPolicy,
    JitNetworkAccessPolicyInitiateRequest,
    AcceptedResponse & {
      @bodyRoot
      _: JitNetworkAccessRequest;
    },
    OverrideErrorType = CloudError
  >;
}
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum JitNetworkAccessPolicyInitiateType {
  initiate,
}
@@doc(JitNetworkAccessPolicy.name,
  "Name of a Just-in-Time access configuration policy."
);
@@doc(JitNetworkAccessPolicy.properties, "");
@@doc(JitNetworkAccessPolicies.createOrUpdate::parameters.resource, "");
@@doc(JitNetworkAccessPolicies.initiate::parameters.body, "");


