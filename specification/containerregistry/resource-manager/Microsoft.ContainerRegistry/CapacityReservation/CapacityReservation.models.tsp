import "./common.models.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.ContainerRegistry;

/** Request-rate reservation tiers. */
@added(Versions.vLatestPreview)
union RequestRateTier {
  /** One request-rate unit. */
  R1: "R1",

  /** Two request-rate units. */
  R2: "R2",

  /** Four request-rate units. */
  R4: "R4",

  /** Eight request-rate units. */
  R8: "R8",

  /** Sixteen request-rate units. */
  R16: "R16",

  /** Thirty-two request-rate units. */
  R32: "R32",

  /** Sixty-four request-rate units. */
  R64: "R64",

  string,
}

/** Egress reservation tiers. */
@added(Versions.vLatestPreview)
union EgressTier {
  /** 16 Gbps. */
  E1: "E1",

  /** 32 Gbps. */
  E2: "E2",

  /** 64 Gbps. */
  E3: "E3",

  /** 128 Gbps. */
  E4: "E4",

  /** 256 Gbps. */
  E5: "E5",

  /** 512 Gbps. */
  E6: "E6",

  string,
}

/** Ingress reservation tiers. */
@added(Versions.vLatestPreview)
union IngressTier {
  /** 0.5 Gbps. */
  I1: "I1",

  /** 1 Gbps. */
  I2: "I2",

  /** 2 Gbps. */
  I4: "I4",

  /** 4 Gbps. */
  I8: "I8",

  /** 8 Gbps. */
  I16: "I16",

  string,
}

/**
 * Customer-configurable properties of a capacity reservation.
 */
@added(Versions.vLatestPreview)
model CapacityReservationWritableProperties {
  /**
   * The request-rate tier label.
   */
  requestRateTier?: RequestRateTier;

  /**
   * The egress tier label.
   */
  egressTier?: EgressTier;

  /**
   * The ingress tier label.
   */
  ingressTier?: IngressTier;

  /**
   * The minimum number of minutes before the reservation can be deleted.
   */
  @minValue(1)
  @visibility(Lifecycle.Create)
  minimumCommitmentMinutes?: int32 = 5;
}

/**
 * Properties returned for a capacity reservation.
 */
@added(Versions.vLatestPreview)
model CapacityReservationProperties {
  ...CapacityReservationWritableProperties;

  /**
   * The tier catalog version used to resolve the admitted floors.
   */
  @visibility(Lifecycle.Read)
  tierCatalogVersion?: string;

  /**
   * The provisioning state of the capacity reservation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * A human-readable reason when provisioning failed.
   */
  @visibility(Lifecycle.Read)
  statusReason?: string;

  /**
   * The earliest time at which the reservation can be deleted.
   */
  @visibility(Lifecycle.Read)
  earliestDeletableAt?: utcDateTime;

  /**
   * The time at which the reservation was created.
   */
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  /**
   * The time at which the reservation was last modified.
   */
  @visibility(Lifecycle.Read)
  lastModifiedAt?: utcDateTime;
}

/**
 * Parameters for resizing a capacity reservation.
 */
@added(Versions.vLatestPreview)
model CapacityReservationUpdate {
  ...Foundations.ArmTagsProperty;

  /**
   * The updated reservation properties.
   */
  properties: CapacityReservationResizeProperties;
}

/**
 * Customer-configurable properties accepted when resizing a capacity reservation.
 */
@added(Versions.vLatestPreview)
model CapacityReservationResizeProperties {
  /**
   * The updated request-rate tier label.
   */
  requestRateTier?: RequestRateTier;

  /**
   * The updated egress tier label.
   */
  egressTier?: EgressTier;

  /**
   * The updated ingress tier label.
   */
  ingressTier?: IngressTier;
}

/**
 * A request to associate or disassociate a registry.
 */
@added(Versions.vLatestPreview)
model RegistryAssociationRequest {
  /**
   * The full ARM ID of a `Microsoft.ContainerRegistry/registries` resource, using the format
   * `/subscriptions/.../resourceGroups/.../providers/Microsoft.ContainerRegistry/registries/...`.
   * The registry must be in the reservation's subscription; its resource group may differ.
   */
  registryId: string;
}

/**
 * A registry associated with a capacity reservation.
 */
@added(Versions.vLatestPreview)
model ReservationRegistryAssociation {
  /**
   * The full ARM ID of the associated `Microsoft.ContainerRegistry/registries` resource, normalized to lowercase.
   */
  registryId: string;

  /**
   * The state of the association.
   */
  associationState: string;

  /**
   * The time at which the registry was associated.
   */
  associatedAt: utcDateTime;
}

/**
 * The result of listing registries associated with a capacity reservation.
 */
@added(Versions.vLatestPreview)
model ReservationRegistryAssociationListResult {
  /**
   * The registry associations.
   */
  @pageItems
  @identifiers(#["registryId"])
  value: ReservationRegistryAssociation[];

  /**
   * The URI for the next page of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The result of listing capacity reservations.
 */
@added(Versions.vLatestPreview)
model CapacityReservationListResult {
  /**
   * The capacity reservations.
   */
  @pageItems
  value: CapacityReservation[];

  /**
   * The URI for the next page of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Parameters for seeding a stamp capacity ledger in Dogfood.
 */
@added(Versions.vLatestPreview)
model SeedCapacityLedgerRequest {
  /**
   * The stamp identifier.
   */
  stampId: string;

  /**
   * The stamp deployment identifier used to derive VM scale set resource identifiers.
   */
  deploymentId?: string;

  /**
   * The current registry pool node count.
   */
  @minValue(0)
  registryStandingNodeCount: int32;

  /**
   * The maximum registry pool node count.
   */
  @minValue(0)
  registryMaxNodeCount: int32;

  /**
   * The registry pool SKU bucket.
   */
  registrySkuBucket?: string;

  /**
   * The registry VM scale set resource identifier.
   */
  registryVmssResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * The current data proxy pool node count.
   */
  @minValue(0)
  dataProxyStandingNodeCount: int32;

  /**
   * The maximum data proxy pool node count.
   */
  @minValue(0)
  dataProxyMaxNodeCount: int32;

  /**
   * The data proxy pool SKU bucket.
   */
  dataProxySkuBucket?: string;

  /**
   * The data proxy VM scale set resource identifier.
   */
  dataProxyVmssResourceId?: Azure.Core.armResourceIdentifier;
}

/**
 * Capacity information for one stamp pool.
 */
@added(Versions.vLatestPreview)
model StampPoolCapacity {
  /**
   * The current standing node count.
   */
  standingNodeCount: int32;

  /**
   * The pending target node count.
   */
  pendingNodeCount?: int32;

  /**
   * The maximum node count.
   */
  maxNodeCount: int32;

  /**
   * The pool SKU bucket.
   */
  skuBucket?: string;

  /**
   * The VM scale set resource identifier.
   */
  vmssResourceId?: Azure.Core.armResourceIdentifier;
}

/**
 * The stamp capacity ledger after seeding.
 */
@added(Versions.vLatestPreview)
model StampCapacityLedger {
  /**
   * The stamp identifier.
   */
  stampId: string;

  /**
   * The Azure region containing the stamp.
   */
  region: Azure.Core.azureLocation;

  /**
   * The registry pool capacity.
   */
  registryPool: StampPoolCapacity;

  /**
   * The data proxy pool capacity.
   */
  dataProxyPool: StampPoolCapacity;

  /**
   * The total reserved request rate.
   */
  totalReservedRequestRate: float64;

  /**
   * The total reserved egress in gigabits per second.
   */
  totalReservedEgressGbps: float64;

  /**
   * The total reserved ingress in gigabits per second.
   */
  totalReservedIngressGbps: float64;

  /**
   * The maximum reservable request rate.
   */
  maxRequestRate: float64;

  /**
   * The maximum reservable egress in gigabits per second.
   */
  maxEgressGbps: float64;

  /**
   * The maximum reservable ingress in gigabits per second.
   */
  maxIngressGbps: float64;

  /**
   * The benchmark version used to compute capacity.
   */
  benchmarkVersion?: string;

  /**
   * Whether the stamp is currently scaling.
   */
  scaling: boolean;

  /**
   * The number of pending capacity claims.
   */
  pendingClaimCount: int32;
}
