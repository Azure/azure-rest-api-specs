import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.FrontDoor;
@doc("Defines an Network Experiment Profile and lists of Experiments")
model Profile is TrackedResource<ProfileProperties> {
  @doc("The Profile identifier associated with the Tenant and Partner")
  @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
  @key("profileName")
  @segment("NetworkExperimentProfiles")
  name: string;

  @doc("Gets a unique read-only string that changes whenever the resource is updated.")
  etag?: string;
}

@armResourceOperations
interface NetworkExperimentProfiles {
  @doc("Gets an NetworkExperiment Profile by ProfileName")
  get is ArmResourceRead<Profile>;
  @doc("Creates an NetworkExperiment Profile")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Profile>;
  @doc("Updates an NetworkExperimentProfiles")
  update is ArmCustomPatchAsync<Profile, ProfileUpdateModel>;
  @doc("Deletes an NetworkExperiment Profile by ProfileName")
  delete is ArmResourceDeleteAsync<Profile>;
  @doc("Gets a list of Network Experiment Profiles within a resource group under a subscription")
  listByResourceGroup is ArmResourceListByParent<Profile>;
  @doc("Gets a list of Network Experiment Profiles under a subscription")
  list is ArmListBySubscription<Profile>;
}

@armResourceOperations
interface PreconfiguredEndpoints {
  @summary("Gets a list of Preconfigured Endpoints")
  @doc("Gets a list of Preconfigured Endpoints")
  // FIXME: PreconfiguredEndpoints_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}/PreconfiguredEndpoints")
  @get
  List is Azure.Core.Foundations.Operation<
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
