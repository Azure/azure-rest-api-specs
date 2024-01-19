import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Network;

interface ManagedRuleSetsOperations {
  @doc("Lists all available managed rule sets.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Network/FrontDoorWebApplicationFirewallManagedRuleSets")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    ManagedRuleSetDefinitionList
  >;
}

interface FrontDoorNameAvailabilityOperations {
  @doc("Check the availability of a Front Door resource name.")
  @route("/providers/Microsoft.Network/checkFrontDoorNameAvailability")
  @post
  check is Azure.Core.Foundations.Operation<
    CheckNameAvailabilityInput,
    CheckNameAvailabilityOutput
  >;
}

interface FrontDoorNameAvailabilityWithSubscriptionOperations {
  @doc("Check the availability of a Front Door subdomain.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Network/checkFrontDoorNameAvailability")
  @post
  check is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Input to check.")
      @body
      checkFrontDoorNameAvailabilityInput: CheckNameAvailabilityInput;
    },
    CheckNameAvailabilityOutput
  >;
}
