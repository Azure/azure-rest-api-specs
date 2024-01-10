import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.NetApp;

interface NetAppResourceOperations {
  @summary("Check resource name availability")
  @doc("Check if a resource name is available.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetApp/locations/{location}/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of Azure region.")
      @minLength(1)
      @path
      location: string;

      @doc("Name availability request.")
      @body
      body: ResourceNameAvailabilityRequest;
    },
    CheckAvailabilityResponse
  >;

  @summary("Check file path availability")
  @doc("Check if a file path is available.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetApp/locations/{location}/checkFilePathAvailability")
  @post
  CheckFilePathAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of Azure region.")
      @minLength(1)
      @path
      location: string;

      @doc("File path availability request.")
      @body
      body: FilePathAvailabilityRequest;
    },
    CheckAvailabilityResponse
  >;

  @summary("Check quota availability")
  @doc("Check if a quota is available.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetApp/locations/{location}/checkQuotaAvailability")
  @post
  CheckQuotaAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of Azure region.")
      @minLength(1)
      @path
      location: string;

      @doc("Quota availability request.")
      @body
      body: QuotaAvailabilityRequest;
    },
    CheckAvailabilityResponse
  >;

  @summary("Describes region specific information.")
  @doc("Provides storage to network proximity and logical zone mapping information.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetApp/locations/{location}/regionInfo")
  @get
  QueryRegionInfo is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of Azure region.")
      @minLength(1)
      @path
      location: string;
    },
    RegionInfo
  >;

  @summary("Describe a network sibling set")
  @doc("Get details of the specified network sibling set.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetApp/locations/{location}/queryNetworkSiblingSet")
  @post
  QueryNetworkSiblingSet is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of Azure region.")
      @minLength(1)
      @path
      location: string;

      @doc("Network sibling set to query.")
      @body
      body: QueryNetworkSiblingSetRequest;
    },
    NetworkSiblingSet
  >;

  @summary("Update the network features of a network sibling set")
  @doc("Update the network features of the specified network sibling set.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetApp/locations/{location}/updateNetworkSiblingSet")
  @post
  UpdateNetworkSiblingSet is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of Azure region.")
      @minLength(1)
      @path
      location: string;

      @doc("Update for the specified network sibling set.")
      @body
      body: UpdateNetworkSiblingSetRequest;
    },
    NetworkSiblingSet | void
  >;
}

interface NetAppResourceQuotaLimitsOperations {
  @summary("Get quota limits")
  @doc("Get the default and current limits for quotas")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetApp/locations/{location}/quotaLimits")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of Azure region.")
      @minLength(1)
      @path
      location: string;
    },
    SubscriptionQuotaItemList
  >;

  @summary("Get quota limits")
  @doc("Get the default and current subscription quota limit")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetApp/locations/{location}/quotaLimits/{quotaLimitName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of Azure region.")
      @minLength(1)
      @path
      location: string;

      @doc("The name of the Quota Limit")
      @path
      quotaLimitName: string;
    },
    SubscriptionQuotaItem
  >;
}
