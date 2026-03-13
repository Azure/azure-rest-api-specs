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
// FIXME: SecurityOperator has no properties property
/**
 * Security operator under a given subscription and pricing
 */
@subscriptionResource
model SecurityOperator is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = SecurityOperator,
    KeyName = "securityOperatorName",
    SegmentName = "securityOperators",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9_]+$"
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Azure.ResourceManager.CommonTypes.Identity;
}

@armResourceOperations
interface SecurityOperators {
  /**
   * Get a specific security operator for the requested scope.
   */
  get is ArmResourceRead<
    SecurityOperator,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Creates Microsoft Defender for Cloud security operator on the given scope.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    SecurityOperator,
    Request = void,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResourceUpdatedResponse<SecurityOperator>
  >;

  /**
   * Delete Microsoft Defender for Cloud securityOperator in the subscription.
   */
  delete is ArmResourceDeleteSync<
    SecurityOperator,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Lists Microsoft Defender for Cloud securityOperators in the subscription.
   */
  list is ArmResourceListByParent<
    SecurityOperator,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<SecurityOperatorList>
  >;
}

@@maxLength(SecurityOperator.name, 63);
@@minLength(SecurityOperator.name, 3);
@@doc(SecurityOperator.name, "name of the securityOperator");
