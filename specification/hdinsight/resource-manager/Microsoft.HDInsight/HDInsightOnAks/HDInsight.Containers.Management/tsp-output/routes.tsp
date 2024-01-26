import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.HDInsight;

interface LocationsOperations {
  /**
   * Check the availability of the resource name.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HDInsight/locations/{location}/checkNameAvailability")
  @post
  checkNameAvailability is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the Azure region.
       */
      @minLength(1)
      @path
      location: string;

      /**
       * The name and type of the resource.
       */
      @body
      NameAvailabilityParameters: NameAvailabilityParameters;
    },
    NameAvailabilityResult
  >;
}

interface AvailableClusterPoolVersionsOperations {
  /**
   * Returns a list of available cluster pool versions.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HDInsight/locations/{location}/availableClusterPoolVersions")
  @get
  listByLocation is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the Azure region.
       */
      @minLength(1)
      @path
      location: string;
    },
    ClusterPoolVersionsListResult
  >;
}

interface AvailableClusterVersionsOperations {
  /**
   * Returns a list of available cluster versions.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HDInsight/locations/{location}/availableClusterVersions")
  @get
  listByLocation is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the Azure region.
       */
      @minLength(1)
      @path
      location: string;
    },
    ClusterVersionsListResult
  >;
}
