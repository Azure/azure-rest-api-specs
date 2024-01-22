import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.NetApp;

interface NetAppResourceOperations {
  /**
   * Check if a resource name is available.
   */
  @summary("Check resource name availability")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetApp/locations/{location}/checkNameAvailability")
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
       * The name of Azure region.
       */
      @minLength(1)
      @path
      location: string;

      /**
       * Name availability request.
       */
      @body
      body: ResourceNameAvailabilityRequest;
    },
    CheckAvailabilityResponse
  >;

  /**
   * Check if a file path is available.
   */
  @summary("Check file path availability")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetApp/locations/{location}/checkFilePathAvailability")
  @post
  checkFilePathAvailability is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of Azure region.
       */
      @minLength(1)
      @path
      location: string;

      /**
       * File path availability request.
       */
      @body
      body: FilePathAvailabilityRequest;
    },
    CheckAvailabilityResponse
  >;

  /**
   * Check if a quota is available.
   */
  @summary("Check quota availability")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetApp/locations/{location}/checkQuotaAvailability")
  @post
  checkQuotaAvailability is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of Azure region.
       */
      @minLength(1)
      @path
      location: string;

      /**
       * Quota availability request.
       */
      @body
      body: QuotaAvailabilityRequest;
    },
    CheckAvailabilityResponse
  >;

  /**
   * Provides storage to network proximity and logical zone mapping information.
   */
  @summary("Describes region specific information.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetApp/locations/{location}/regionInfo")
  @get
  queryRegionInfo is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of Azure region.
       */
      @minLength(1)
      @path
      location: string;
    },
    RegionInfo
  >;

  /**
   * Get details of the specified network sibling set.
   */
  @summary("Describe a network sibling set")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetApp/locations/{location}/queryNetworkSiblingSet")
  @post
  queryNetworkSiblingSet is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of Azure region.
       */
      @minLength(1)
      @path
      location: string;

      /**
       * Network sibling set to query.
       */
      @body
      body: QueryNetworkSiblingSetRequest;
    },
    NetworkSiblingSet
  >;

  /**
   * Update the network features of the specified network sibling set.
   */
  @summary("Update the network features of a network sibling set")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetApp/locations/{location}/updateNetworkSiblingSet")
  @post
  updateNetworkSiblingSet is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of Azure region.
       */
      @minLength(1)
      @path
      location: string;

      /**
       * Update for the specified network sibling set.
       */
      @body
      body: UpdateNetworkSiblingSetRequest;
    },
    NetworkSiblingSet | void
  >;
}

interface NetAppResourceQuotaLimitsOperations {
  /**
   * Get the default and current limits for quotas
   */
  @summary("Get quota limits")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetApp/locations/{location}/quotaLimits")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of Azure region.
       */
      @minLength(1)
      @path
      location: string;
    },
    SubscriptionQuotaItemList
  >;

  /**
   * Get the default and current subscription quota limit
   */
  @summary("Get quota limits")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetApp/locations/{location}/quotaLimits/{quotaLimitName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of Azure region.
       */
      @minLength(1)
      @path
      location: string;

      /**
       * The name of the Quota Limit
       */
      @path
      quotaLimitName: string;
    },
    SubscriptionQuotaItem
  >;
}
