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
  /**
   * Name of capability set
   */
  @key("capabilitySetName")
  @path
  @segment("capabilitySets")
  @pattern("^[a-z0-9][-a-z0-9]*(?<!-)$")
  name: string = "default";
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface LocationBasedCapabilityOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...LocationNameParameter,
      },
      {}
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface LocationBasedCapabilityOperationOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...LocationNameParameter,

        /**
         * Name of capability set
         */
        @path
        @segment("capabilitySets")
        @pattern("^[a-z0-9][-a-z0-9]*(?<!-)$")
        capabilitySetName: string = "default",
      },
      {}
    > {}

@armResourceOperations
interface LocationBasedCapabilitySet {
  /**
   * Get capabilities at specified location in a given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is LocationBasedCapabilityOperationOps.Read<Capability>;

  /**
   * Get capabilities at specified location in a given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("capabilitySets")
  @get
  @list
  list is LocationBasedCapabilityOps.Read<
    Capability,
    Response = ArmResponse<CapabilitySetsList>
  >;
}

@@doc(Capability.name, "Name of capability set");
@@doc(Capability.properties, "The properties of a location capability set.");
