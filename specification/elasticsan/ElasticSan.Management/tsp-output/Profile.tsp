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
@doc("Defines an Network Experiment Profile and lists of Experiments")
model Profile is TrackedResource<ProfileProperties> {
  @doc("The Profile identifier associated with the Tenant and Partner")
  @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
  @path
  @key("profileName")
  @segment("NetworkExperimentProfiles")
  name: string;

  @doc("Gets a unique read-only string that changes whenever the resource is updated.")
  etag?: string;
}

@armResourceOperations
interface Profiles {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets an NetworkExperiment Profile by ProfileName")
  @operationId("NetworkExperimentProfiles_Get")
  get is ArmResourceRead<Profile>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates an NetworkExperiment Profile")
  @operationId("NetworkExperimentProfiles_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Profile>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates an NetworkExperimentProfiles")
  @operationId("NetworkExperimentProfiles_Update")
  update is ArmCustomPatchAsync<Profile, ProfileUpdateModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an NetworkExperiment Profile by ProfileName")
  @operationId("NetworkExperimentProfiles_Delete")
  delete is ArmResourceDeleteAsync<Profile>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of Network Experiment Profiles within a resource group under a subscription")
  @operationId("NetworkExperimentProfiles_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Profile>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of Network Experiment Profiles under a subscription")
  @operationId("NetworkExperimentProfiles_List")
  list is ArmListBySubscription<Profile>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PreconfiguredEndpoints_List")
  @summary("Gets a list of Preconfigured Endpoints")
  @doc("Gets a list of Preconfigured Endpoints")
  // FIXME: PreconfiguredEndpoints_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}/PreconfiguredEndpoints")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(80)
      @minLength(1)
      @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The Profile identifier associated with the Tenant and Partner")
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
