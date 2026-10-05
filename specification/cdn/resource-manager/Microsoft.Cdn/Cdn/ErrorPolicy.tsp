import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Cdn;
/**
 * An error policy describes how Azure Front Door treats the error responses returned by an origin. Error policies are referenced by routes and can be reused across them.
 */
@added(Versions.v2026_09_01_preview)
@parentResource(Profile)
model ErrorPolicy
  is Azure.ResourceManager.ProxyResource<ErrorPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ErrorPolicy,
    KeyName = "errorPolicyName",
    SegmentName = "errorPolicies",
    NamePattern = ""
  >;
}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface ErrorPolicies {
  /**
   * Gets an existing error policy within a profile.
   */
  get is ArmResourceRead<ErrorPolicy>;

  /**
   * Creates a new error policy within the specified profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Replacing an error policy is long running and returns 202, matching the other Azure Front Door resources in this specification."
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    ErrorPolicy,
    Response =
      | ArmResourceUpdatedResponse<ErrorPolicy>
      | ArmResourceCreatedResponse<ErrorPolicy>
      | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = ErrorPolicy> &
          ArmLroLocationHeader<FinalResult = ErrorPolicy> &
          Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Updates an existing error policy within a profile.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ErrorPolicy,
    PatchModel = ErrorPolicyUpdateParameters,
    Response =
      | ArmResponse<ErrorPolicy>
      | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = ErrorPolicy> &
          ArmLroLocationHeader<FinalResult = ErrorPolicy> &
          Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing error policy within a profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Deleting an error policy is long running and returns 202, matching the other Azure Front Door resources in this specification."
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    ErrorPolicy,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
          ArmLroLocationHeader &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all of the existing error policies within a profile.
   */
  @list
  listByProfile is ArmResourceListByParent<ErrorPolicy>;
}

@@doc(
  ErrorPolicy.name,
  "Name of the error policy which is unique within the profile."
);
@@doc(
  ErrorPolicy.properties,
  "The JSON object that contains the properties of the error policy."
);
@@doc(ErrorPolicies.create::parameters.resource, "Error policy properties");
@@doc(ErrorPolicies.update::parameters.properties, "Error policy properties");
