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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
model Profile extends ResourcewithSettableName {
  properties?: ProfileProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("profileName")
  @segment("NetworkExperimentProfiles")
  @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
  name: string;

  /**
   * Gets a unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations
interface Profiles {
  /**
   * Gets an NetworkExperiment Profile by ProfileName
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkExperimentProfiles_Get")
  @summary("Gets an NetworkExperiment Profile by ProfileName")
  get is ArmResourceRead<Profile, Error = ErrorResponse>;

  /**
   * Creates an NetworkExperiment Profile
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkExperimentProfiles_CreateOrUpdate")
  @summary("Creates an NetworkExperiment Profile")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Profile,
    Response = ArmResourceUpdatedResponse<Profile> | ArmResourceCreatedResponse<
      Profile,
      ArmLroLocationHeader<FinalResult = Profile> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Profile;
    }),
    Error = ErrorResponse
  >;

  /**
   * Updates an NetworkExperimentProfiles
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkExperimentProfiles_Update")
  @summary("Updates an NetworkExperimentProfiles by NetworkExperimentProfile name")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Profile,
    PatchModel = ProfileUpdateModel,
    Response = ArmResponse<Profile> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Profile> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: Profile;
    }),
    Error = ErrorResponse
  >;

  /**
   * Deletes an NetworkExperiment Profile by ProfileName
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkExperimentProfiles_Delete")
  @summary("Deletes an NetworkExperiment Profile by ProfileName")
  delete is ArmResourceDeleteWithoutOkAsync<
    Profile,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * Gets a list of Network Experiment Profiles within a resource group under a subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets a list of Network Experiment Profiles within a resource group under a subscription")
  @operationId("NetworkExperimentProfiles_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    Profile,
    Response = ArmResponse<ProfileList>,
    Error = ErrorResponse
  >;

  /**
   * Gets a list of Network Experiment Profiles under a subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets a list of Network Experiment Profiles under a subscription")
  @operationId("NetworkExperimentProfiles_List")
  list is ArmListBySubscription<
    Profile,
    Response = ArmResponse<ProfileList>,
    Error = ErrorResponse
  >;

  /**
   * Gets a list of Preconfigured Endpoints
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets a list of Preconfigured Endpoints")
  @operationId("PreconfiguredEndpoints_List")
  @list
  @get
  @action("PreconfiguredEndpoints")
  preconfiguredEndpointsList is ArmResourceActionSync<
    Profile,
    void,
    ArmResponse<PreconfiguredEndpointList>,
    Error = ErrorResponse
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
