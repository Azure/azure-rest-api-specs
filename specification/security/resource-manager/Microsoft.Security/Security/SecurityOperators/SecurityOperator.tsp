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

namespace SecurityOperatorsAPI;
// FIXME: SecurityOperator has no properties property
/**
 * Security operator under a given subscription and pricing
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@subscriptionResource
model SecurityOperator is Azure.ResourceManager.ProxyResource<never> {
  ...ResourceNameParameter<
    Resource = SecurityOperator,
    KeyName = "securityOperatorName",
    SegmentName = "securityOperators",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9_]+$"
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Azure.ResourceManager.CommonTypes.Identity;
}

alias SecurityOperatorOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the pricing configuration. */
    @path
    @segment("pricings")
    @key
    @minLength(3)
    @maxLength(63)
    @pattern("^[a-zA-Z][a-zA-Z0-9_]+$")
    pricingName: string;
  },
  {
    /** Name of the security operator. */
    @path
    @segment("securityOperators")
    @key
    @minLength(3)
    @maxLength(63)
    @pattern("^[a-zA-Z][a-zA-Z0-9_]+$")
    securityOperatorName: string;
  },
  ErrorType = CloudError
>;

@armResourceOperations
interface SecurityOperators {
  /**
   * Get a specific security operator for the requested scope.
   */
  get is SecurityOperatorOps.Read<
    SecurityOperator,
    OverrideErrorType = CloudError
  >;

  /**
   * Creates Microsoft Defender for Cloud security operator on the given scope.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is SecurityOperatorOps.CreateOrUpdateSync<
    SecurityOperator,
    Request = void,
    Response = ArmResourceUpdatedResponse<SecurityOperator>
  >;

  /**
   * Delete Microsoft Defender for Cloud securityOperator in the subscription.
   */
  delete is SecurityOperatorOps.DeleteSync<SecurityOperator>;

  /**
   * Lists Microsoft Defender for Cloud securityOperators in the subscription.
   */
  list is SecurityOperatorOps.List<
    SecurityOperator,
    Response = ArmResponse<SecurityOperatorList>,
    OverrideErrorType = CloudError
  >;
}

@@maxLength(SecurityOperator.name, 63);
@@minLength(SecurityOperator.name, 3);
@@doc(SecurityOperator.name, "name of the securityOperator");



