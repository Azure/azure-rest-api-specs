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
 * An agent link (web agent association) within a CDN profile.
 */
@added(Versions.v2025_09_01_preview)
@parentResource(Profile)
model ProfileAgent
  is Azure.ResourceManager.ProxyResource<ProfileAgentProperties> {
  ...ResourceNameParameter<
    Resource = ProfileAgent,
    KeyName = "agentName",
    SegmentName = "agents",
    NamePattern = ""
  >;
}

/**
 * Defines a ProfileAgent response body for long-running operations.
 */
@added(Versions.v2025_09_01_preview)
model ProfileAgentAcceptedBody {
  /**
   * Defines a ProfileAgent response body
   */
  @bodyRoot
  @added(Versions.v2025_09_01_preview)
  _: ProfileAgent;
}

@added(Versions.v2025_09_01_preview)
@armResourceOperations
interface ProfileAgents {
  /**
   * Gets an agent link (web agent association) within a CDN profile.
   */
  get is ArmResourceRead<ProfileAgent>;

  /**
   * Creates or updates an agent link (web agent association) within a CDN profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ProfileAgent,
    Response = ArmResourceUpdatedResponse<ProfileAgent> | ArmResourceCreatedResponse<ProfileAgent> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ProfileAgent>> &
      ProfileAgentAcceptedBody)
  >;

  /**
   * Updates an existing agent link (web agent association) within a CDN profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ProfileAgent,
    PatchModel = ProfileAgentUpdateParameters,
    Response = ArmResponse<ProfileAgent> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> &
      ProfileAgentAcceptedBody)
  >;

  /**
   * Deletes an existing agent link (web agent association) within a CDN profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ProfileAgent,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmLroLocationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all agent links (web agent associations) within a CDN profile.
   */
  listByProfile is ArmResourceListByParent<ProfileAgent>;
}

@@doc(ProfileAgent.name, "Name of the web agent association.");
@@doc(ProfileAgent.properties,
  "The properties of a profile agent association."
);
@@doc(ProfileAgents.createOrUpdate::parameters.resource,
  "Profile agent association properties."
);
@@doc(ProfileAgents.update::parameters.properties,
  "Profile agent association update properties."
);
