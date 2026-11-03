import "./shared.tsp";
import "@typespec/versioning";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.DBforPostgreSQL;

/**
 * Virtual network subnet usage parameter
 */
model VirtualNetworkSubnetUsageParameter {
  /**
   * Virtual network resource id.
   */
  virtualNetworkArmResourceId?: string;
}

/**
 * Virtual network subnet usage data.
 */
model VirtualNetworkSubnetUsageModel {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @identifiers(#["subnetName"])
  delegatedSubnetsUsage?: DelegatedSubnetUsage[];

  /**
   * location of the delegated subnet usage
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * subscriptionId of the delegated subnet usage
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;
}

/**
 * Delegated subnet usage data.
 */
model DelegatedSubnetUsage {
  /**
   * Name of the delegated subnet for which IP addresses are in use
   */
  @visibility(Lifecycle.Read)
  subnetName?: string;

  /**
   * Number of IP addresses used by the delegated subnet
   */
  @visibility(Lifecycle.Read)
  usage?: int64;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface VirtualNetworkSubnetUsageOperationGroup {
  /**
   * Lists the virtual network subnet usage for a given virtual network.
   */
  @autoRoute
  @action("checkVirtualNetworkSubnetUsage")
  list is ArmProviderActionSync<
    Request = VirtualNetworkSubnetUsageParameter,
    Response = VirtualNetworkSubnetUsageModel,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
