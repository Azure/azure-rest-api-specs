import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Defines web application firewall policy.
 */
model WebApplicationFirewallPolicy
  is Azure.ResourceManager.TrackedResource<WebApplicationFirewallPolicyProperties> {
  ...ResourceNameParameter<
    Resource = WebApplicationFirewallPolicy,
    KeyName = "policyName",
    SegmentName = "FrontDoorWebApplicationFirewallPolicies",
    NamePattern = ""
  >;

  /**
   * Gets a unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  /**
   * The pricing tier of web application firewall policy. Defaults to Classic_AzureFrontDoor if not specified.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;
}

@armResourceOperations
interface WebApplicationFirewallPolicies {
  /**
   * Retrieve protection policy with specified name within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Policies_Get")
  get is ArmResourceRead<WebApplicationFirewallPolicy, Error = ErrorResponse>;

  /**
   * Create or update policy with specified rule set name within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("Policies_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    WebApplicationFirewallPolicy,
    Response = ArmResourceUpdatedResponse<WebApplicationFirewallPolicy> | ArmResourceCreatedResponse<
      WebApplicationFirewallPolicy,
      LroHeaders = ArmLroLocationHeader<FinalResult = WebApplicationFirewallPolicy> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = WebApplicationFirewallPolicy> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: WebApplicationFirewallPolicy;
    }),
    Error = ErrorResponse
  >;

  /**
   * Patch a specific frontdoor webApplicationFirewall policy for tags update under the specified subscription and resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Policies_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    WebApplicationFirewallPolicy,
    PatchModel = TagsObject,
    Response = ArmResponse<WebApplicationFirewallPolicy> & {
      ...ArmLroLocationHeader<FinalResult = WebApplicationFirewallPolicy>;
    },
    Error = ErrorResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes Policy
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Policies_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    WebApplicationFirewallPolicy,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = never
  >;

  /**
   * Lists all of the protection policies within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Policies_List")
  list is ArmResourceListByParent<
    WebApplicationFirewallPolicy,
    Response = ArmResponse<WebApplicationFirewallPolicyList>,
    Error = ErrorResponse
  >;

  /**
   * Lists all of the protection policies within a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Policies_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    WebApplicationFirewallPolicy,
    Response = ArmResponse<WebApplicationFirewallPolicyList>,
    Error = DefaultErrorResponse
  >;
}

@@maxLength(WebApplicationFirewallPolicy.name, 128);
@@doc(WebApplicationFirewallPolicy.name,
  "The name of the Web Application Firewall Policy."
);
@@doc(WebApplicationFirewallPolicy.properties,
  "Properties of the web application firewall policy."
);
@@doc(WebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "Policy to be created."
);
@@doc(WebApplicationFirewallPolicies.update::parameters.properties,
  "FrontdoorWebApplicationFirewallPolicy parameters to be patched."
);
