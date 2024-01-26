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
   * Gets the capabilities for the specified location.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HDInsight/locations/{location}/capabilities")
  @get
  getCapabilities is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The Azure location (region) for which to make the request.
       */
      @path
      location: string;
    },
    CapabilitiesResult
  >;

  /**
   * Lists the usages for the specified location.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HDInsight/locations/{location}/usages")
  @get
  listUsages is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The Azure location (region) for which to make the request.
       */
      @path
      location: string;
    },
    UsagesListResult
  >;

  /**
   * Lists the billingSpecs for the specified subscription and location.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HDInsight/locations/{location}/billingSpecs")
  @get
  listBillingSpecs is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The Azure location (region) for which to make the request.
       */
      @path
      location: string;
    },
    BillingResponseListResult
  >;

  /**
   * Check the cluster name is available or not.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HDInsight/locations/{location}/checkNameAvailability")
  @post
  checkNameAvailability is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The Azure location (region) for which to make the request.
       */
      @path
      location: string;

      @body
      parameters: NameAvailabilityCheckRequestParameters;
    },
    NameAvailabilityCheckResult
  >;

  /**
   * Validate the cluster create request spec is valid or not.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HDInsight/locations/{location}/validateCreateRequest")
  @post
  validateClusterCreateRequest is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The Azure location (region) for which to make the request.
       */
      @path
      location: string;

      @body
      parameters: ClusterCreateRequestValidationParameters;
    },
    ClusterCreateValidationResult
  >;
}
