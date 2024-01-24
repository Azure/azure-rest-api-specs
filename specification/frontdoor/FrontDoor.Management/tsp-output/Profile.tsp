import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Defines an Network Experiment Profile and lists of Experiments
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(ProfileProperties)
@includeInapplicableMetadataInPayload(false)
model Profile extends FrontDoorResourceModel {
  /**
   * The Profile identifier associated with the Tenant and Partner
   */
  @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
  @path
  @key("profileName")
  @segment("NetworkExperimentProfiles")
  name: string;

  /**
   * Gets a unique read-only string that changes whenever the resource is updated.
   */
  etag?: string;

  /**
   * The properties of a Profile
   */
  @extension("x-ms-client-flatten", true)
  properties?: ProfileProperties;
}

@armResourceOperations
interface Profiles {
  /**
   * Gets an NetworkExperiment Profile by ProfileName
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkExperimentProfiles_Get")
  get is ArmResourceRead<Profile>;

  /**
   * Creates an NetworkExperiment Profile
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkExperimentProfiles_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Profile>;

  /**
   * Updates an NetworkExperimentProfiles
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("NetworkExperimentProfiles_Update")
  update is ArmCustomPatchAsync<Profile, ProfileUpdateModel>;

  /**
   * Deletes an NetworkExperiment Profile by ProfileName
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkExperimentProfiles_Delete")
  delete is ArmResourceDeleteAsync<Profile>;

  /**
   * Gets a list of Network Experiment Profiles within a resource group under a subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkExperimentProfiles_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Profile>;

  /**
   * Gets a list of Network Experiment Profiles under a subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkExperimentProfiles_List")
  list is ArmListBySubscription<Profile>;

  /**
   * Gets a list of Preconfigured Endpoints
   */
  // FIXME: PreconfiguredEndpoints_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PreconfiguredEndpoints_List")
  @summary("Gets a list of Preconfigured Endpoints")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}/PreconfiguredEndpoints")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(80)
      @minLength(1)
      @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The Profile identifier associated with the Tenant and Partner
       */
      @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
      @path
      profileName: string;
    },
    PreconfiguredEndpointList
  >;
}

@@projectedName(Profiles.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Profiles.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Profiles.createOrUpdate::parameters.resource,
  "An Network Experiment Profile"
);
@@projectedName(Profiles.update::parameters.properties, "json", "parameters");
@@extension(Profiles.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Profiles.update::parameters.properties, "The Profile Update Model");
