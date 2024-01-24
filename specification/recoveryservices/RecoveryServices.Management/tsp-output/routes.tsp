import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.RecoveryServices;

interface RecoveryServicesOperations {
  /**
   * API to check for resource name availability.
   * A name is available if no other resource exists that has the same SubscriptionId, Resource Name and Type
   * or if one or more such resources exist, each of these must be GC'd and their time of deletion be more than 24 Hours Ago
   */
  @summary("""
API to check for resource name availability.
A name is available if no other resource exists that has the same SubscriptionId, Resource Name and Type
or if one or more such resources exist, each of these must be GC'd and their time of deletion be more than 24 Hours Ago
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/locations/{location}/checkNameAvailability")
  @post
  checkNameAvailability is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * Location of the resource
       */
      @path
      location: string;

      /**
       * Contains information about Resource type and Resource name
       */
      @body
      input: CheckNameAvailabilityParameters;
    },
    CheckNameAvailabilityResult
  >;

  /**
   * API to get details about capabilities provided by Microsoft.RecoveryServices RP
   */
  @summary("API to get details about capabilities provided by Microsoft.RecoveryServices RP")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{location}/capabilities")
  @post
  capabilities is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * Location of the resource
       */
      @path
      location: string;

      /**
       * Contains information about Resource type and properties to get capabilities
       */
      @body
      input: ResourceCapabilities;
    },
    CapabilitiesResponse
  >;
}
