import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Cdn;

@doc("Check the availability of a resource name. This is needed for resources where name is globally unique, such as a afdx endpoint.")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/checkEndpointNameAvailability")
@post
op checkEndpointNameAvailability is Azure.Core.Foundations.Operation<
  {
    @doc("Azure Subscription ID.")
    @path
    subscriptionId: string;

    @doc("Name of the Resource group within the Azure subscription.")
    @maxLength(90)
    @minLength(1)
    @pattern("^[-\\w\\._\\(\\)]+$")
    @path
    resourceGroupName: string;

    @doc("Input to check.")
    @body
    checkEndpointNameAvailabilityInput: EndpointNameAvailabilityContent;
  },
  EndpointNameAvailabilityResult
>;

@doc("Check the availability of a resource name. This is needed for resources where name is globally unique, such as a CDN endpoint.")
@route("/providers/Microsoft.Cdn/checkNameAvailability")
@post
op checkNameAvailability is Azure.Core.Foundations.Operation<
  CdnNameAvailabilityContent,
  CdnNameAvailabilityResult
>;

@doc("Check the availability of a resource name. This is needed for resources where name is globally unique, such as a CDN endpoint.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Cdn/checkNameAvailability")
@post
op checkNameAvailabilityWithSubscription is Azure.Core.Foundations.Operation<
  {
    @doc("Azure Subscription ID.")
    @path
    subscriptionId: string;

    @doc("Input to check.")
    @body
    checkNameAvailabilityInput: CdnNameAvailabilityContent;
  },
  CdnNameAvailabilityResult
>;

@doc("Check if the probe path is a valid path and the file can be accessed. Probe path is the path to a file hosted on the origin server to help accelerate the delivery of dynamic content via the CDN endpoint. This path is relative to the origin path specified in the endpoint configuration.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Cdn/validateProbe")
@post
op validateProbe is Azure.Core.Foundations.Operation<
  {
    @doc("Azure Subscription ID.")
    @path
    subscriptionId: string;

    @doc("Input to check.")
    @body
    validateProbeInput: ValidateProbeInput;
  },
  ValidateProbeResult
>;

interface ResourceUsageOperations {
  @doc("Check the quota and actual usage of the CDN profiles under the given subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Cdn/checkResourceUsage")
  @post
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    ResourceUsageListResult
  >;
}

interface EdgeNodesOperations {
  @doc("Edgenodes are the global Point of Presence (POP) locations used to deliver CDN content to end users.")
  @route("/providers/Microsoft.Cdn/edgenodes")
  @get
  list is Azure.Core.Foundations.Operation<{}, EdgenodeResult>;
}

interface ManagedRuleSetsOperations {
  @doc("Lists all available managed rule sets.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Cdn/cdnWebApplicationFirewallManagedRuleSets")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    ManagedRuleSetDefinitionList
  >;
}
