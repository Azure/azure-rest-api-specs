import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Orbital;

/**
 * The current state of the resource's creation, deletion, or modification.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  creating: "creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  succeeded: "succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  failed: "failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  canceled: "canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  updating: "updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  deleting: "deleting",
}

/**
 * The current state of the resource's creation, deletion, or modification.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union SpacecraftsPropertiesProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  creating: "creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  succeeded: "succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  failed: "failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  canceled: "canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  updating: "updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  deleting: "deleting",
}

/**
 * Direction (Uplink or Downlink).
 */
union Direction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Uplink: "Uplink",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Downlink: "Downlink",
}

/**
 * Polarization. e.g. (RHCP, LHCP).
 */
union Polarization {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RHCP: "RHCP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LHCP: "LHCP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  linearVertical: "linearVertical",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  linearHorizontal: "linearHorizontal",
}

/**
 * The current state of the resource's creation, deletion, or modification.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ContactsPropertiesProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  creating: "creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  succeeded: "succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  failed: "failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  canceled: "canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  updating: "updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  deleting: "deleting",
}

/**
 * Status of a contact.
 */
union ContactsStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  scheduled: "scheduled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  cancelled: "cancelled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  succeeded: "succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  failed: "failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  providerCancelled: "providerCancelled",
}

/**
 * The current state of the resource's creation, deletion, or modification.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ContactProfilesPropertiesProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  creating: "creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  succeeded: "succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  failed: "failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  canceled: "canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  updating: "updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  deleting: "deleting",
}

/**
 * Protocol either UDP or TCP.
 */
union Protocol {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TCP: "TCP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UDP: "UDP",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union CapabilityParameter {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EarthObservation: "EarthObservation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Communication: "Communication",
}

/**
 * Release Status of a ground station.
 */
union ReleaseMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Preview: "Preview",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GA: "GA",
}

/**
 * The status of operation.
 */
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
}

/**
 * Capability of the Ground Station.
 */
union Capability {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EarthObservation: "EarthObservation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Communication: "Communication",
}

/**
 * Auto-tracking configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum AutoTrackingConfiguration {
  disabled,
  xBand,
  sBand,
}

/**
 * List of Spacecraft Resource Properties.
 */
model SpacecraftsProperties {
  /**
   * The current state of the resource's creation, deletion, or modification.
   */
  provisioningState?: SpacecraftsPropertiesProvisioningState;

  /**
   * NORAD ID of the spacecraft.
   */
  noradId?: string;

  /**
   * Title line of the two-line element set (TLE).
   */
  titleLine: string;

  /**
   * Line 1 of the two-line element set (TLE).
   */
  tleLine1: string;

  /**
   * Line 2 of the two-line element set (TLE).
   */
  tleLine2: string;

  /**
   * Immutable list of Spacecraft links.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @OpenAPI.extension("x-ms-identifiers", #[])
  links: SpacecraftLink[];
}

/**
 * List of authorized spacecraft links per ground station and the expiration date of the authorization.
 */
model SpacecraftLink {
  /**
   * Link name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: string;

  /**
   * Center Frequency in MHz.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  centerFrequencyMHz: float32;

  /**
   * Bandwidth in MHz.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  bandwidthMHz: float32;

  /**
   * Direction (Uplink or Downlink).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  direction: Direction;

  /**
   * Polarization. e.g. (RHCP, LHCP).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  polarization: Polarization;

  /**
   * Authorized Ground Stations
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  authorizations?: AuthorizedGroundstation[];
}

/**
 * Authorized groundstation.
 */
model AuthorizedGroundstation {
  /**
   * Groundstation name.
   */
  groundStation: string;

  /**
   * Date of authorization expiration.
   */
  expirationDate: plainDate;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Tags object for patch operations.
 */
model TagsObject {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Properties of the Contact Resource.
 */
model ContactsProperties {
  /**
   * The current state of the resource's creation, deletion, or modification.
   */
  provisioningState?: ProvisioningState;

  /**
   * Status of a contact.
   */
  @visibility(Lifecycle.Read)
  status?: ContactsStatus;

  /**
   * Reservation start time of a contact (ISO 8601 UTC standard).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reservationStartTime: utcDateTime;

  /**
   * Reservation end time of a contact (ISO 8601 UTC standard).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reservationEndTime: utcDateTime;

  /**
   * Receive start time of a contact (ISO 8601 UTC standard).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  rxStartTime?: utcDateTime;

  /**
   * Receive end time of a contact (ISO 8601 UTC standard).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  rxEndTime?: utcDateTime;

  /**
   * Transmit start time of a contact (ISO 8601 UTC standard).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  txStartTime?: utcDateTime;

  /**
   * Transmit end time of a contact (ISO 8601 UTC standard).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  txEndTime?: utcDateTime;

  /**
   * Any error message while scheduling a contact.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * Maximum elevation of the antenna during the contact in decimal degrees.
   */
  @visibility(Lifecycle.Read)
  maximumElevationDegrees?: float32;

  /**
   * Azimuth of the antenna at the start of the contact in decimal degrees.
   */
  @visibility(Lifecycle.Read)
  startAzimuthDegrees?: float32;

  /**
   * Azimuth of the antenna at the end of the contact in decimal degrees.
   */
  @visibility(Lifecycle.Read)
  endAzimuthDegrees?: float32;

  /**
   * Azure Ground Station name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  groundStationName: string;

  /**
   * Spacecraft elevation above the horizon at contact start.
   */
  @visibility(Lifecycle.Read)
  startElevationDegrees?: float32;

  /**
   * Spacecraft elevation above the horizon at contact end.
   */
  @visibility(Lifecycle.Read)
  endElevationDegrees?: float32;

  /**
   * The configuration associated with the allocated antenna.
   */
  @visibility(Lifecycle.Read)
  antennaConfiguration?: ContactsPropertiesAntennaConfiguration;

  /**
   * The reference to the contact profile resource.
   */
  contactProfile: ResourceReference;
}

/**
 * The configuration associated with the allocated antenna.
 */
model ContactsPropertiesAntennaConfiguration {
  /**
   * The destination IP a packet can be sent to. This would for example be the TCP endpoint you would send data to.
   */
  destinationIp?: string;

  /**
   * List of Source IP
   */
  sourceIps?: string[];
}

/**
 * Resource Reference.
 */
model ResourceReference {
  /**
   * Resource ID.
   */
  id: string;
}

/**
 * Parameters that define the contact resource.
 */
model ContactParameters {
  /**
   * The reference to the contact profile resource.
   */
  contactProfile: ResourceReference;

  /**
   * Name of Azure Ground Station.
   */
  groundStationName: string;

  /**
   * Start time of a contact (ISO 8601 UTC standard).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  /**
   * End time of a contact (ISO 8601 UTC standard).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime: utcDateTime;
}

/**
 * Response for the ListAvailableContacts API service call.
 */
model AvailableContactsListResult is Azure.Core.Page<AvailableContacts>;

/**
 * Customer retrieves list of Available Contacts for a spacecraft resource. Later, one of the available contact can be selected to create a contact.
 */
model AvailableContacts {
  /**
   * The reference to the spacecraft resource.
   */
  spacecraft?: ResourceReference;

  /**
   * Name of Azure Ground Station.
   */
  @visibility(Lifecycle.Read)
  groundStationName?: string;

  /**
   * Properties of Contact resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ContactInstanceProperties;
}

/**
 * Contact Instance Properties.
 */
model ContactInstanceProperties {
  /**
   * Maximum elevation of the antenna during the contact in decimal degrees.
   */
  @visibility(Lifecycle.Read)
  maximumElevationDegrees?: float32;

  /**
   * Time at which antenna transmit will be enabled (ISO 8601 UTC standard).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  txStartTime?: utcDateTime;

  /**
   * Time at which antenna transmit will be disabled (ISO 8601 UTC standard).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  txEndTime?: utcDateTime;

  /**
   * Earliest time to receive a signal (ISO 8601 UTC standard).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  rxStartTime?: utcDateTime;

  /**
   * Time to lost receiving a signal (ISO 8601 UTC standard).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  rxEndTime?: utcDateTime;

  /**
   * Azimuth of the antenna at the start of the contact in decimal degrees.
   */
  @visibility(Lifecycle.Read)
  startAzimuthDegrees?: float32;

  /**
   * Azimuth of the antenna at the end of the contact in decimal degrees.
   */
  @visibility(Lifecycle.Read)
  endAzimuthDegrees?: float32;

  /**
   * Spacecraft elevation above the horizon at contact start.
   */
  @visibility(Lifecycle.Read)
  startElevationDegrees?: float32;

  /**
   * Spacecraft elevation above the horizon at contact end.
   */
  @visibility(Lifecycle.Read)
  endElevationDegrees?: float32;
}

/**
 * List of Contact Profile Resource Properties.
 */
model ContactProfilesProperties {
  /**
   * The current state of the resource's creation, deletion, or modification.
   */
  provisioningState?: ProvisioningState;

  /**
   * Minimum viable contact duration in ISO 8601 format. Used for listing the available contacts with a spacecraft at a given ground station.
   */
  minimumViableContactDuration?: string;

  /**
   * Minimum viable elevation for the contact in decimal degrees. Used for listing the available contacts with a spacecraft at a given ground station.
   */
  minimumElevationDegrees?: float32;

  /**
   * Auto-tracking configuration.
   */
  autoTrackingConfiguration?: AutoTrackingConfiguration;

  /**
   * ARM resource identifier of the Event Hub used for telemetry. Requires granting Orbital Resource Provider the rights to send telemetry into the hub.
   */
  eventHubUri?: string;

  /**
   * Network configuration of customer virtual network.
   */
  networkConfiguration: ContactProfilesPropertiesNetworkConfiguration;

  /**
   * Third-party mission configuration of the Contact Profile. Describes RF links, modem processing, and IP endpoints.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  thirdPartyConfigurations?: ContactProfileThirdPartyConfiguration[];

  /**
   * Links of the Contact Profile. Describes RF links, modem processing, and IP endpoints.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  links: ContactProfileLink[];
}

/**
 * Network configuration of customer virtual network.
 */
model ContactProfilesPropertiesNetworkConfiguration {
  /**
   * ARM resource identifier of the subnet delegated to the Microsoft.Orbital/orbitalGateways. Needs to be at least a class C subnet, and should not have any IP created in it.
   */
  subnetId: string;
}

/**
 * Contact Profile third-party partner configuration.
 */
model ContactProfileThirdPartyConfiguration {
  /**
   * Name of the third-party provider.
   */
  providerName: string;

  /**
   * Name of string referencing the configuration describing contact set-up for a particular mission. Expected values are those which have been created in collaboration with the partner network.
   */
  missionConfiguration: string;
}

/**
 * Contact Profile Link.
 */
model ContactProfileLink {
  /**
   * Link name.
   */
  name: string;

  /**
   * Polarization. e.g. (RHCP, LHCP).
   */
  polarization: Polarization;

  /**
   * Direction (Uplink or Downlink).
   */
  direction: Direction;

  /**
   * Gain to noise temperature in db/K. It is the required G/T by the customer. Not used yet.
   */
  gainOverTemperature?: float32;

  /**
   * Effective Isotropic Radiated Power (EIRP) in dBW. It is the required EIRP by the customer. Not used yet.
   */
  eirpdBW?: float32;

  /**
   * Contact Profile Link Channel.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  channels: ContactProfileLinkChannel[];
}

/**
 * Contact Profile Link Channel.
 */
model ContactProfileLinkChannel {
  /**
   * Channel name.
   */
  name: string;

  /**
   * Center Frequency in MHz.
   */
  centerFrequencyMHz: float32;

  /**
   * Bandwidth in MHz.
   */
  bandwidthMHz: float32;

  /**
   * Customer end point to store and retrieve data during a contact with the spacecraft.
   */
  endPoint: EndPoint;

  /**
   * Copy of the modem configuration file such as Kratos QRadio. Only valid for uplink directions. If provided, the modem connects to the customer endpoint and accepts commands from the customer instead of a VITA.49 stream.
   */
  modulationConfiguration?: string;

  /**
   * Copy of the modem configuration file such as Kratos QRadio or Kratos QuantumRx. Only valid for downlink directions. If provided, the modem connects to the customer endpoint and sends demodulated data instead of a VITA.49 stream.
   */
  demodulationConfiguration?: string;

  /**
   * Currently unused.
   */
  encodingConfiguration?: string;

  /**
   * Currently unused.
   */
  decodingConfiguration?: string;
}

/**
 * Customer end point to store and retrieve data during a contact with the spacecraft.
 */
model EndPoint {
  /**
   * IP Address (IPv4).
   */
  ipAddress: string;

  /**
   * Name of an end point.
   */
  endPointName: string;

  /**
   * TCP port to listen on to receive data.
   */
  port: string;

  /**
   * Protocol either UDP or TCP.
   */
  protocol: Protocol;
}

/**
 * Ground Stations available to schedule Contacts.
 */
model AvailableGroundStationListResult
  is Azure.Core.Page<AvailableGroundStation>;

model AvailableGroundStation {
  /**
   * ID of groundStation.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of the ground station.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Azure region.
   */
  location?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The properties bag for this resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: AvailableGroundStationProperties;
}

/**
 * Properties object for Available groundstation.
 */
model AvailableGroundStationProperties {
  /**
   * City of ground station.
   */
  city?: string;

  /**
   * Ground station provider name.
   */
  providerName?: string;

  /**
   * Longitude of the ground station in decimal degrees.
   */
  longitudeDegrees?: float32;

  /**
   * Latitude of the ground station in decimal degrees.
   */
  latitudeDegrees?: float32;

  /**
   * Altitude of the ground station.
   */
  altitudeMeters?: float32;

  /**
   * Release Status of a ground station.
   */
  releaseMode?: ReleaseMode;
}

/**
 * Operation Result Entity.
 */
model OperationResult {
  /**
   * ID of the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The status of operation.
   */
  @visibility(Lifecycle.Read)
  status?: Status;

  /**
   * The operation start time (ISO 8601 UTC standard).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The operation end time (ISO 8601 UTC standard).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Percentage completed.
   */
  @visibility(Lifecycle.Read)
  @maxValue(100)
  @minValue(0)
  percentComplete?: float64;

  /**
   * A list of results when the operation returns multiple results.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  value?: Record<unknown>[];

  /**
   * The URL to get the next set of results.
   */
  @visibility(Lifecycle.Read)
  nextLink?: string;

  /**
   * Operation result properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: Record<unknown>;

  /**
   * Operation result error properties.
   */
  error?: OperationResultErrorProperties;
}

/**
 * Operation result error properties.
 */
model OperationResultErrorProperties {
  /**
   * The code of the error.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Response for an API service call that lists the resource IDs of resources associated with another resource.
 */
model ResourceIdListResult {
  /**
   * A list of Azure Resource IDs.
   */
  value?: ResourceIdListResultValueItem[];

  /**
   * The URL to get the next set of results.
   */
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceIdListResultValueItem {
  /**
   * The Azure Resource ID.
   */
  id?: string;
}
