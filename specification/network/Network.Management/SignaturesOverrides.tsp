import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FirewallPolicy.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Contains all specific policy signatures overrides for the IDPS
 */
@singleton("default")
@parentResource(FirewallPolicy)
model SignaturesOverrides
  is Azure.ResourceManager.ProxyResource<SignaturesOverridesProperties> {
  ...ResourceNameParameter<
    Resource = SignaturesOverrides,
    KeyName = "signatureOverride",
    SegmentName = "signatureOverrides",
    NamePattern = ""
  >;
}

@armResourceOperations
interface FirewallPolicyIdpsSignaturesOverrides {
  /**
   * Returns all signatures overrides for a specific policy.
   */
  get is ArmResourceRead<SignaturesOverrides>;

  /**
   * Will override/create a new signature overrides for the policy's IDPS
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  put is ArmResourceCreateOrReplaceSync<
    SignaturesOverrides,
    Response = ArmResourceUpdatedResponse<SignaturesOverrides>
  >;

  /**
   * Will update the status of policy's signature overrides for IDPS
   */
  @patch(#{ implicitOptionality: false })
  patch is ArmCustomPatchSync<
    SignaturesOverrides,
    PatchModel = SignaturesOverrides
  >;

  /**
   * Returns all signatures overrides objects for a specific policy as a list containing a single value.
   */
  list is ArmResourceListByParent<
    SignaturesOverrides,
    Response = ArmResponse<SignaturesOverridesList>
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
