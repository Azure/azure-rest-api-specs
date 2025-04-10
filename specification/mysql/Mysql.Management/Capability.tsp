import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforMySQL;
/**
 * Represents a location capability set.
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model Capability
  is Azure.ResourceManager.ProxyResource<CapabilityPropertiesV2> {
  ...ResourceNameParameter<
    Resource = Capability,
    KeyName = "capabilitySetName",
    SegmentName = "capabilitySets",
    NamePattern = "^[a-z0-9][-a-z0-9]*(?<!-)$"
  >;
}

@armResourceOperations
interface Capabilities {
  /**
   * Get capabilities at specified location in a given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LocationBasedCapabilitySet_Get")
  get is ArmResourceRead<
    Capability,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Get capabilities at specified location in a given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LocationBasedCapabilitySet_List")
  list is ArmResourceListByParent<
    Capability,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<CapabilitySetsList>
  >;
}

@@doc(Capability.name, "Name of capability set");
@@doc(Capability.properties, "The properties of a location capability set.");
