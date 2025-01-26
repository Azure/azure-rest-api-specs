import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/versioning";

import "./common.tsp";

// imports organized by resource type path names
import "./addons.tsp";
import "./authorizations.tsp";
import "./cloudLinks.tsp";
import "./clusters.tsp";
import "./datastores.tsp";
import "./globalReachConnections.tsp";
import "./hcxEnterpriseSites.tsp";
import "./iscsiPaths.tsp";
import "./locations.tsp";
import "./placementPolicies.tsp";
import "./privateClouds.tsp";
import "./scriptCmdlets.tsp";
import "./scriptExecutions.tsp";
import "./scriptPackages.tsp";
import "./virtualMachines.tsp";
import "./workloadNetworks-dhcpConfigurations.tsp";
import "./workloadNetworks-dnsServices.tsp";
import "./workloadNetworks-dnsZones.tsp";
import "./workloadNetworks-gateways.tsp";
import "./workloadNetworks-portMirroringProfiles.tsp";
import "./workloadNetworks-publicIPs.tsp";
import "./workloadNetworks-segments.tsp";
import "./workloadNetworks-virtualMachines.tsp";
import "./workloadNetworks-vmGroups.tsp";
import "./workloadNetworks.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
@armProviderNamespace("Microsoft.AVS")
@service({
  title: "Azure VMware Solution API",
})
@doc("Azure VMware Solution API")
@versioned(Versions)
namespace Microsoft.AVS;

@doc("Azure VMware Solution API versions.")
enum Versions {
  @doc("Azure VMware Solution API version 2023-09-01.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2023_09_01: "2023-09-01",
}

interface Operations extends Azure.ResourceManager.Operations {}
