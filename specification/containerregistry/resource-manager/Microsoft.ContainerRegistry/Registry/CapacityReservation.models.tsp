using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.ContainerRegistry;

/**
 * Customer-configurable properties of a capacity reservation.
 */
@added(Versions.vLatestPreview)
model CapacityReservationWritableProperties {
  /**
   * The Dogfood stamp that supplies the reserved capacity.
   */
  stampId: string;

  /**
   * The request-rate floor in request units.
   */
  @minValue(0)
  requestRateRus?: float64 = 0;

  /**
   * The egress floor in gigabits per second.
   */
  @minValue(0)
  egressGbps?: float64 = 0;

  /**
   * The ingress floor in gigabits per second.
   */
  @minValue(0)
  ingressGbps?: float64 = 0;

  /**
   * The request-rate tier label.
   */
  requestRateTier?: string;

  /**
   * The egress tier label.
   */
  egressTier?: string;

  /**
   * The ingress tier label.
   */
  ingressTier?: string;

  /**
   * The minimum number of minutes before the reservation can be deleted.
   */
  @minValue(1)
  minimumCommitmentMinutes?: int32 = 5;
}

/**
 * Properties returned for a capacity reservation.
 */
@added(Versions.vLatestPreview)
model CapacityReservationProperties {
  ...CapacityReservationWritableProperties;

  /**
   * The admitted request-rate floor in request units.
   */
  @visibility(Lifecycle.Read)
  reservedRequestRate?: float64;

  /**
   * The admitted egress floor in gigabits per second.
   */
  @visibility(Lifecycle.Read)
  reservedEgressGbps?: float64;

  /**
   * The admitted ingress floor in gigabits per second.
   */
  @visibility(Lifecycle.Read)
  reservedIngressGbps?: float64;

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
   * The updated request-rate floor in request units.
   */
  @minValue(0)
  requestRateRus?: float64 = 0;

  /**
   * The updated egress floor in gigabits per second.
   */
  @minValue(0)
  egressGbps?: float64 = 0;

  /**
   * The updated ingress floor in gigabits per second.
   */
  @minValue(0)
  ingressGbps?: float64 = 0;

  /**
   * The updated request-rate tier label.
   */
  requestRateTier?: string;

  /**
   * The updated egress tier label.
   */
  egressTier?: string;

  /**
   * The updated ingress tier label.
   */
  ingressTier?: string;
}

/**
 * A request to associate or disassociate a registry.
 */
@added(Versions.vLatestPreview)
model RegistryAssociationRequest {
  /**
   * The name of a registry in the reservation's subscription and resource group.
   */
  registryName: string;
}

/**
 * A registry associated with a capacity reservation.
 */
@added(Versions.vLatestPreview)
model ReservationRegistryAssociation {
  /**
   * The registry resource identifier.
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
