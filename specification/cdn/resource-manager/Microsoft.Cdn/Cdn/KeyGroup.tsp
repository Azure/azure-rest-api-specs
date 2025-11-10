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
 * Contains a list of references of UrlSigningKey type secret objects.
 */
@added(Versions.v2025_09_01_preview)
@parentResource(Profile)
model KeyGroup is Azure.ResourceManager.ProxyResource<KeyGroupProperties> {
  ...ResourceNameParameter<
    Resource = KeyGroup,
    KeyName = "keyGroupName",
    SegmentName = "keyGroups",
    NamePattern = "^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$"
  >;
}

/**
 * Defines a KeyGroup response body for long-running operations.
 */
@added(Versions.v2025_09_01_preview)
model KeyGroupAcceptedBody {
  /**
   * Defines a KeyGroup response body
   */
  @bodyRoot
  @added(Versions.v2025_09_01_preview)
  _: KeyGroup;
}

@added(Versions.v2025_09_01_preview)
@armResourceOperations
interface KeyGroups {
  /**
   * Gets an existing KeyGroup within a profile.
   */
  get is ArmResourceRead<KeyGroup>;

  /**
   * Creates or updates a new KeyGroup within the specified profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createUpdate is ArmResourceCreateOrReplaceAsync<
    KeyGroup,
    Response = ArmResourceUpdatedResponse<KeyGroup> | ArmResourceCreatedResponse<KeyGroup> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> &
      KeyGroupAcceptedBody)
  >;

  /**
   * Updates an existing KeyGroup within the specified profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    KeyGroup,
    PatchModel = KeyGroupUpdatePropertiesParameters,
    Response = ArmResponse<KeyGroup> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> &
      KeyGroupAcceptedBody)
  >;

  /**
   * Deletes an existing KeyGroup within profile.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    KeyGroup,
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists existing AzureFrontDoor KeyGroups.
   */
  listByProfile is ArmResourceListByParent<KeyGroup>;
}

@@maxLength(KeyGroup.name, 260);
@@minLength(KeyGroup.name, 1);
@@doc(KeyGroup.name, "Name of the KeyGroup under the profile.");
@@doc(KeyGroup.properties,
  "The JSON object that contains the properties of the key group to create."
);
@@doc(KeyGroups.createUpdate::parameters.resource, "The KeyGroup properties.");
@@doc(KeyGroups.update::parameters.properties, "The KeyGroup properties.");
