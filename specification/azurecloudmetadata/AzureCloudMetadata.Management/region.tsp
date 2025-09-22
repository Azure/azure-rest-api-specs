import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./geography.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureCloudMetadata;

/** Region resource. */
@tenantResource
model Region is ProxyResource<RegionProperties> {
  @doc("The region name")
  @segment("regions")
  @key("regionName")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  name: string;
}

/** Region details. */
model RegionProperties {
  ...MetadataProperties;

  /** Friendly name of region */
  friendlyName: string;

  /** Type of region */
  regionType: RegionType;

  /** State of region. */
  state: RegionState;

  /** Arm location of region. */
  armLocation: string;

  /** Availability zone support state of region. */
  availabilityZoneSupport: ZoneSupportState;

  /** Supported customer workloads of region. */
  supportedCustomerWorkloads: string;

  /** Billing region name of region. */
  billingRegionName: string;

  /** Buildout arm feature flag of region. */
  buildoutArmFeatureFlag?: string;

  /** Customer arm feature flag of region. */
  customerArmFeatureFlag?: string;

  /** Id of paired region of region. */
  pairRegionIds?: string;

  /** Recovery region guid of region. */
  recoveryRegionGuid?: string;

  /** rdfe Id of region. */
  rdfeId?: string;

  /** Data boundary of region. */
  dataBoundary?: string;

  /** Crp service account of region. */
  crpServiceAccount?: string;

  /** Dsts Dns of region. */
  dstsDns?: string;

  /** Default billing policy of region. */
  defaultBillingPolicy?: string;

  /** Default offer type of region. */
  defaultOfferType?: string;

  /** Dns servers of region. */
  dnsServers?: string;

  /** Rnm Dns name of region. */
  rnmDnsName?: string;

  /** Resource id of region's parent geography. */
  geographyResourceId: string;

  /** Future changes of region. */
  @added(Versions.v2025_10_01_preview)
  futureChanges: string;

  /** Zone resilience support state of region. */
  @added(Versions.v2025_10_01_preview)
  zoneResilienceSupport: string;

  /** The provisioning state of resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

/** The region's zone support state. */
union ZoneSupportState {
  /** Zone support state is no plan. */
  NoPlan: "No Plan",

  /** Zone support state is proposed. */
  Proposed: "Proposed",

  /** Zone support state is approved. */
  Approved: "Approved",

  /** Zone support state is on hold. */
  OnHold: "On Hold",

  /** Zone support state is cancelled. */
  Cancelled: "Cancelled",

  string,
}

/** The region type. */
union RegionType {
  /** A hero region */
  Hero: "Hero",

  /** A hub region */
  Hub: "Hub",

  /** A micro region */
  Micro: "Micro",

  /** A satellite region */
  Satellite: "Satellite",

  /** A AI region */
  AIReserve: "AI_Reserve",

  /** Region type is unknown */
  Unknown: "Unknown",

  string,
}

/** The region state. */
union RegionState {
  /** The region is being proposed */
  Proposed: "Proposed",

  /** The region is approved */
  Approved: "Approved",

  /** The region is on ring 0 complete */
  Ring0Complete: "Ring 0 Complete",

  /** The region is in buildout */
  Buildout: "Buildout",

  /** The region is in production SLA */
  ProductionSLA: "Production SLA",

  /** The region is decommissioning */
  Decommissioning: "Decommissioning",

  /** The region is retired */
  Retired: "Retired",

  /** The region is cancelled */
  Cancelled: "Cancelled",

  /** The region state is unknown */
  Unknown: "Unknown",

  string,
}

@armResourceOperations
interface Regions {
  get is ArmResourceRead<Region>;
  list is ArmResourceListAtScope<Region>;
}
