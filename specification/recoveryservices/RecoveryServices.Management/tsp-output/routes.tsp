import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.RecoveryServices;

interface RecoveryServicesOperations {
  @summary("""
API to check for resource name availability.
A name is available if no other resource exists that has the same SubscriptionId, Resource Name and Type
or if one or more such resources exist, each of these must be GC'd and their time of deletion be more than 24 Hours Ago
""")
  @doc("""
API to check for resource name availability.
A name is available if no other resource exists that has the same SubscriptionId, Resource Name and Type
or if one or more such resources exist, each of these must be GC'd and their time of deletion be more than 24 Hours Ago
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/locations/{location}/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("Location of the resource")
      @path
      location: string;

      @doc("Contains information about Resource type and Resource name")
      @body
      input: CheckNameAvailabilityParameters;
    },
    CheckNameAvailabilityResult
  >;

  @summary("API to get details about capabilities provided by Microsoft.RecoveryServices RP")
  @doc("API to get details about capabilities provided by Microsoft.RecoveryServices RP")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{location}/capabilities")
  @post
  Capabilities is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("Location of the resource")
      @path
      location: string;

      @doc("Contains information about Resource type and properties to get capabilities")
      @body
      input: ResourceCapabilities;
    },
    CapabilitiesResponse
  >;
}
