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
 * An authorization policy that maps authorization configurations to profile, domain, or route associations.
 */
@added(Versions.v2026_08_01_preview)
@parentResource(Profile)
model AuthPolicy is Azure.ResourceManager.ProxyResource<AuthPolicyProperties> {
  ...ResourceNameParameter<
    Resource = AuthPolicy,
    KeyName = "authPolicyName",
    SegmentName = "authPolicies",
    NamePattern = "^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$"
  >;
}

@added(Versions.v2026_08_01_preview)
@armResourceOperations
interface AuthPolicies {
  /**
   * Gets an existing authorization policy within a profile.
   */
  get is ArmResourceRead<AuthPolicy>;

  /**
   * Creates or updates an authorization policy within the specified profile.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    AuthPolicy,
    Response =
      | ArmResourceUpdatedResponse<AuthPolicy>
      | ArmResourceCreatedResponse<
          AuthPolicy,
          LroHeaders = ArmAsyncOperationHeader<FinalResult = AuthPolicy> &
            Azure.Core.Foundations.RetryAfterHeader
        >
  >;

  /**
   * Updates an existing authorization policy within a profile.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AuthPolicy,
    PatchModel = AuthPolicyUpdateParameters,
    Response =
      | ArmResponse<AuthPolicy>
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = AuthPolicy> &
          Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing authorization policy within a profile.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    AuthPolicy,
    Response =
      | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  /**
   * Lists authorization policies associated with the profile.
   */
  @list
  listByProfile is ArmResourceListByParent<AuthPolicy>;
}

@@doc(AuthPolicy.name, "Name of the authorization policy under the profile.");
@@minLength(AuthPolicy.name, 1);
@@maxLength(AuthPolicy.name, 260);
@@doc(
  AuthPolicy.properties,
  "Properties required to create an authorization policy."
);
@@doc(
  AuthPolicies.create::parameters.resource,
  "The authorization policy properties."
);
@@doc(
  AuthPolicies.update::parameters.properties,
  "Authorization policy update properties."
);
