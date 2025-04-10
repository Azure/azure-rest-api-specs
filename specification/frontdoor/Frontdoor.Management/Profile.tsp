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
 * Defines an Network Experiment Profile and lists of Experiments
 */
model Profile is Azure.ResourceManager.TrackedResource<ProfileProperties> {
  ...ResourceNameParameter<
    Resource = Profile,
    KeyName = "profileName",
    SegmentName = "NetworkExperimentProfiles",
    NamePattern = "^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$"
  >;

  /**
   * Gets a unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface Profiles {
  /**
   * Gets an NetworkExperiment Profile by ProfileName
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkExperimentProfiles_Get")
  get is ArmResourceRead<Profile>;

  /**
   * Creates an NetworkExperiment Profile
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("NetworkExperimentProfiles_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Profile,
    Response = ArmResourceUpdatedResponse<Profile> | ArmResourceCreatedResponse<
      Profile,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Profile;
    })
  >;

  /**
   * Updates an NetworkExperimentProfiles
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("NetworkExperimentProfiles_Update")
  update is ArmCustomPatchAsync<
    Profile,
    PatchModel = ProfileUpdateModel,
    Response = ArmResponse<Profile> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Profile;
    })
  >;

  /**
   * Deletes an NetworkExperiment Profile by ProfileName
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("NetworkExperimentProfiles_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    Profile,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of Network Experiment Profiles within a resource group under a subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkExperimentProfiles_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    Profile,
    Response = ArmResponse<ProfileList>
  >;

  /**
   * Gets a list of Network Experiment Profiles under a subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkExperimentProfiles_List")
  list is ArmListBySubscription<Profile, Response = ArmResponse<ProfileList>>;

  /**
   * Gets a list of Preconfigured Endpoints
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("PreconfiguredEndpoints")
  @operationId("PreconfiguredEndpoints_List")
  preconfiguredEndpointsList is ArmResourceActionSync<
    Profile,
    void,
    ArmResponse<PreconfiguredEndpointList>
  >;
}

@@doc(Profile.name,
  "The Profile identifier associated with the Tenant and Partner"
);
@@doc(Profile.properties, "The properties of a Profile");
@@doc(Profiles.createOrUpdate::parameters.resource,
  "An Network Experiment Profile"
);
@@doc(Profiles.update::parameters.properties, "The Profile Update Model");
