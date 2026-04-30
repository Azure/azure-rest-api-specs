import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FirewallPolicy.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace Microsoft.Network;
/**
 * Contains all specific policy signatures overrides for the IDPS
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewallPolicy)
@Http.Private.includeInapplicableMetadataInPayload(false)
@singleton("default")
@parentResource(FirewallPolicy)
model SignaturesOverrides extends WritableResource {
  /**
   * Will contain the properties of the resource (the actual signature overrides)
   */
  properties?: SignaturesOverridesProperties;

  /**
   * The name of the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @path
  @key("SignaturesOverridesName")
  @segment("signatureOverrides")
  name: string;
}

@@doc(SignaturesOverrides.name, "Contains the name of the resource (default)");

alias FirewallPolicyIdpsSignaturesOverridesListOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The name of the Firewall Policy. */
    @path
    @segment("firewallPolicies")
    @key
    firewallPolicyName: string;
  },
  {},
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/firewallPolicies/{firewallPolicyName}/signatureOverrides",
  }
>;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewallPolicy)
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface FirewallPolicyIdpsSignaturesOverrides {
  /**
   * Returns all signatures overrides for a specific policy.
   */
  get is ArmResourceRead<SignaturesOverrides, Error = CloudError>;

  /**
   * Will override/create a new signature overrides for the policy's IDPS
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  put is ArmResourceCreateOrReplaceSync<
    SignaturesOverrides,
    Response = ArmResourceUpdatedResponse<SignaturesOverrides>,
    Error = CloudError
  >;

  /**
   * Will update the status of policy's signature overrides for IDPS
   */
  @patch(#{ implicitOptionality: false })
  patch is ArmCustomPatchSync<
    SignaturesOverrides,
    PatchModel = SignaturesOverrides,
    Error = CloudError
  >;

  /**
   * Returns all signatures overrides objects for a specific policy as a list containing a single value.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/firewallPolicies/{firewallPolicyName}/signatureOverrides")
  @get
  list is FirewallPolicyIdpsSignaturesOverridesListOps.ActionSync<
    SignaturesOverrides,
    void,
    ArmResponse<SignaturesOverridesList>,
    OverrideErrorType = CloudError
  >;
}

@@doc(SignaturesOverrides.name, "");
@@doc(SignaturesOverrides.properties,
  "Will contain the properties of the resource (the actual signature overrides)"
);
@@doc(FirewallPolicyIdpsSignaturesOverrides.put::parameters.resource,
  "Will contain all properties of the object to put"
);
@@doc(FirewallPolicyIdpsSignaturesOverrides.patch::parameters.properties,
  "Will contain all properties of the object to put"
);
