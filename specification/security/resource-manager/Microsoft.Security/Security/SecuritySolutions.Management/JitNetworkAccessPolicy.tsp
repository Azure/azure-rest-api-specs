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

@armResourceOperations
interface JitNetworkAccessPolicies {
  /**
   * Policies for protecting resources using Just-in-Time access control for the subscription, location
   */
  get is ArmResourceRead<JitNetworkAccessPolicy>;

  /**
   * Create a policy for protecting resources using Just-in-Time access control
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    JitNetworkAccessPolicy,
    Response = ArmResourceUpdatedResponse<JitNetworkAccessPolicy>
  >;

  /**
   * Delete a Just-in-Time access control policy.
   */
  delete is ArmResourceDeleteSync<JitNetworkAccessPolicy>;

  /**
   * Policies for protecting resources using Just-in-Time access control for the subscription, location
   */
  listByResourceGroupAndRegion is ArmResourceListByParent<
    JitNetworkAccessPolicy,
    Response = ArmResponse<JitNetworkAccessPoliciesList>
  >;

  // /**
  //  * Policies for protecting resources using Just-in-Time access control for the subscription, location
  //  */
  // listByRegion is ArmResourceListAtScope<
  //   JitNetworkAccessPolicy,
  //   // BaseParameters = Azure.ResourceManager.Foundations.LocationBaseParameters,
  //   Response = ArmResponse<JitNetworkAccessPoliciesList>
  // >;

  /**
   * Initiate a JIT access from a specific Just-in-Time policy configuration.
   */
  // @action("{jitNetworkAccessPolicyInitiateType}")
  initiate is ArmResourceActionSync<
    JitNetworkAccessPolicy,
    JitNetworkAccessPolicyInitiateRequest,
    AcceptedResponse & {
      @bodyRoot
      _: JitNetworkAccessRequest;
    },
    Parameters = {
      /**
       * Type of the action to do on the Just-in-Time access policy.
       */
      @path
      jitNetworkAccessPolicyInitiateType: "initiate";
    }
  >;
}

@@doc(JitNetworkAccessPolicy.name,
  "Name of a Just-in-Time access configuration policy."
);
@@doc(JitNetworkAccessPolicy.properties, "");
@@doc(JitNetworkAccessPolicies.createOrUpdate::parameters.resource, "");
@@doc(JitNetworkAccessPolicies.initiate::parameters.body, "");
