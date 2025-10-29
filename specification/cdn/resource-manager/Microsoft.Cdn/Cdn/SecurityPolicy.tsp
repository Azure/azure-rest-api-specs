import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * SecurityPolicy association for AzureFrontDoor profile
 */
@parentResource(Profile)
model SecurityPolicy
  is Azure.ResourceManager.ProxyResource<SecurityPolicyProperties> {
  ...ResourceNameParameter<
    Resource = SecurityPolicy,
    KeyName = "securityPolicyName",
    SegmentName = "securityPolicies",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SecurityPolicies {
  /**
   * Gets an existing security policy within a profile.
   */
  get is ArmResourceRead<SecurityPolicy>;

  /**
   * Creates a new security policy within the specified profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    SecurityPolicy,
    Response = ArmResourceUpdatedResponse<SecurityPolicy> | ArmResourceCreatedResponse<SecurityPolicy> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = SecurityPolicy> &
      ArmLroLocationHeader<FinalResult = SecurityPolicy>> & {
      @bodyRoot
      _: SecurityPolicy;
    })
  >;

  /**
   * Updates an existing security policy within a profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  patch is ArmCustomPatchAsync<
    SecurityPolicy,
    PatchModel = SecurityPolicyUpdateParameters,
    Response = ArmResponse<SecurityPolicy> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = SecurityPolicy> &
      ArmLroLocationHeader<FinalResult = SecurityPolicy>> & {
      @bodyRoot
      _: SecurityPolicy;
    })
  >;

  /**
   * Deletes an existing security policy within profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    SecurityPolicy,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists security policies associated with the profile
   */
  @list
  listByProfile is ArmResourceListByParent<SecurityPolicy>;
}

@@doc(SecurityPolicy.name, "Name of the security policy under the profile.");
@@doc(SecurityPolicy.properties,
  "The json object that contains properties required to create a security policy"
);
@@doc(SecurityPolicies.create::parameters.resource,
  "The security policy properties."
);
@@doc(SecurityPolicies.patch::parameters.properties,
  "Security policy update properties"
);
