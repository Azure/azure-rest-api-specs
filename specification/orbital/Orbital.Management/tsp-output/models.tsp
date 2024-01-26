import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Orbital;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The current state of the resource's creation, deletion, or modification.
 */
enum ProvisioningState {
  Creating,
  Succeeded,
  Failed,
  Canceled,
  Updating,
  Deleting,
}

/**
 * The current state of the resource's creation, deletion, or modification.
 */
enum SpacecraftsPropertiesProvisioningState {
  Creating,
  Succeeded,
  Failed,
  Canceled,
  Updating,
  Deleting,
}

/**
 * Direction (uplink or downlink).
 */
enum Direction {
  uplink,
  downlink,
}

/**
 * Polarization. e.g. (RHCP, LHCP).
 */
enum Polarization {
  RHCP,
  LHCP,
  linearVertical,
  linearHorizontal,
}

/**
 * The current state of the resource's creation, deletion, or modification.
 */
enum ContactsPropertiesProvisioningState {
  Creating,
  Succeeded,
  Failed,
  Canceled,
  Updating,
  Deleting,
}

/**
 * Status of a contact.
 */
enum ContactsStatus {
  scheduled,
  cancelled,
  succeeded,
  failed,
  providerCancelled,
}

/**
 * The current state of the resource's creation, deletion, or modification.
 */
enum ContactProfilesPropertiesProvisioningState {
  Creating,
  Succeeded,
  Failed,
  Canceled,
  Updating,
  Deleting,
}

/**
 * Protocol either UDP or TCP.
 */
enum Protocol {
  TCP,
  UDP,
}

enum CapabilityParameter {
  EarthObservation,
  Communication,
}

/**
 * Release Status of a ground station.
 */
enum ReleaseMode {
  Preview,
  GA,
}

/**
 * The status of operation.
 */
enum Status {
  Succeeded,
  Canceled,
  Failed,
  Running,
}

/**
 * Capability of the Ground Station.
 */
enum Capability {
  EarthObservation,
  Communication,
}

enum ApiVersionParameter {
  `2020-09-01-preview`,
  `2021-04-04-preview`,
  `2022-03-01`,
}

/**
 * Auto-tracking configuration.
 */
@fixed
enum AutoTrackingConfiguration {
  disabled,
  xBand,
  sBand,
}

/**
 * An error response from the service.
 */
@error
model CloudError {
  /**
   * An error response from the service.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the service.
 */
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message?: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  details?: CloudErrorBody[];
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
  noradId: string;

  /**
   * Title line of the two-line element set (TLE).
   */
  titleLine?: string;

  /**
   * Line 1 of the two-line element set (TLE).
   */
  tleLine1?: string;

  /**
   * Line 2 of the two-line element set (TLE).
   */
  tleLine2?: string;

  /**
   * Immutable list of Spacecraft links.
   */
  @visibility("read", "create")
  links?: SpacecraftLink[];
}

/**
 * List of authorized spacecraft links per ground station and the expiration date of the authorization.
 */
model SpacecraftLink {
  /**
   * Link name.
   */
  @visibility("read", "create")
  name: string;

  /**
   * Center Frequency in MHz.
   */
  @visibility("read", "create")
  centerFrequencyMHz: float32;

  /**
   * Bandwidth in MHz.
   */
  @visibility("read", "create")
  bandwidthMHz: float32;

  /**
   * Direction (uplink or downlink).
   */
  @visibility("read", "create")
  direction: Direction;

  /**
   * Polarization. e.g. (RHCP, LHCP).
   */
  @visibility("read", "create")
  polarization: Polarization;

  /**
   * Authorized Ground Stations
   */
  @visibility("read")
  authorizations?: AuthorizedGroundstation[];
}

/**
 * Authorized groundstation.
 */
model AuthorizedGroundstation {
  /**
   * Groundstation name.
   */
  groundStation?: string;

  /**
   * Date of authorization expiration.
   */
  expirationDate?: plainDate;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Tags object for patch operations.
 */
model TagsObject {
  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Properties of the Contact Resource.
 */
model ContactsProperties {
  /**
   * The current state of the resource's creation, deletion, or modification.
   */
  provisioningState?: ContactsPropertiesProvisioningState;

  /**
   * Status of a contact.
   */
  @visibility("read")
  status?: ContactsStatus;

  /**
   * Reservation start time of a contact (ISO 8601 UTC standard).
   */
  @visibility("read", "create")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reservationStartTime: utcDateTime;

  /**
   * Reservation end time of a contact (ISO 8601 UTC standard).
   */
  @visibility("read", "create")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reservationEndTime: utcDateTime;

  /**
   * Receive start time of a contact (ISO 8601 UTC standard).
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  rxStartTime?: utcDateTime;

  /**
   * Receive end time of a contact (ISO 8601 UTC standard).
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  rxEndTime?: utcDateTime;

  /**
   * Transmit start time of a contact (ISO 8601 UTC standard).
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  txStartTime?: utcDateTime;

  /**
   * Transmit end time of a contact (ISO 8601 UTC standard).
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  txEndTime?: utcDateTime;

  /**
   * Any error message while scheduling a contact.
   */
  @visibility("read")
  errorMessage?: string;

  /**
   * Maximum elevation of the antenna during the contact in decimal degrees.
   */
  @visibility("read")
  maximumElevationDegrees?: float32;

  /**
   * Azimuth of the antenna at the start of the contact in decimal degrees.
   */
  @visibility("read")
  startAzimuthDegrees?: float32;

  /**
   * Azimuth of the antenna at the end of the contact in decimal degrees.
   */
  @visibility("read")
  endAzimuthDegrees?: float32;

  /**
   * Azure Ground Station name.
   */
  @visibility("read", "create")
  groundStationName: string;

  /**
   * Spacecraft elevation above the horizon at contact start.
   */
  @visibility("read")
  startElevationDegrees?: float32;

  /**
   * Spacecraft elevation above the horizon at contact end.
   */
  @visibility("read")
  endElevationDegrees?: float32;

  /**
   * The configuration associated with the allocated antenna.
   */
  @visibility("read")
  antennaConfiguration?: ContactsPropertiesAntennaConfiguration;

  /**
   * The reference to the contact profile resource.
   */
  contactProfile: ContactsPropertiesContactProfile;
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
 * The reference to the contact profile resource.
 */
model ContactsPropertiesContactProfile extends ResourceReference {}

/**
 * Resource Reference.
 */
model ResourceReference {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * Parameters that define the contact resource.
 */
model ContactParameters {
  /**
   * The reference to the contact profile resource.
   */
  contactProfile: ContactParametersContactProfile;

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
 * The reference to the contact profile resource.
 */
model ContactParametersContactProfile extends ResourceReference {}

/**
 * Response for the ListAvailableContacts API service call.
 */
model AvailableContactsListResult {
  /**
   * A list of available contacts.
   */
  @projectedName("json", "value")
  values?: AvailableContacts[];
}

/**
 * Customer retrieves list of Available Contacts for a spacecraft resource. Later, one of the available contact can be selected to create a contact.
 */
model AvailableContacts {
  /**
   * The reference to the spacecraft resource.
   */
  spacecraft?: AvailableContactsSpacecraft;

  /**
   * Name of Azure Ground Station.
   */
  @visibility("read")
  groundStationName?: string;

  /**
   * Properties of Contact resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AvailableContactsProperties;
}

/**
 * The reference to the spacecraft resource.
 */
model AvailableContactsSpacecraft extends ResourceReference {}

/**
 * Properties of Contact resource.
 */
model AvailableContactsProperties extends ContactInstanceProperties {}

/**
 * Contact Instance Properties.
 */
model ContactInstanceProperties {
  /**
   * Maximum elevation of the antenna during the contact in decimal degrees.
   */
  @visibility("read")
  maximumElevationDegrees?: float32;

  /**
   * Time at which antenna transmit will be enabled (ISO 8601 UTC standard).
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  txStartTime?: utcDateTime;

  /**
   * Time at which antenna transmit will be disabled (ISO 8601 UTC standard).
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  txEndTime?: utcDateTime;

  /**
   * Earliest time to receive a signal (ISO 8601 UTC standard).
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  rxStartTime?: utcDateTime;

  /**
   * Time to lost receiving a signal (ISO 8601 UTC standard).
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  rxEndTime?: utcDateTime;

  /**
   * Azimuth of the antenna at the start of the contact in decimal degrees.
   */
  @visibility("read")
  startAzimuthDegrees?: float32;

  /**
   * Azimuth of the antenna at the end of the contact in decimal degrees.
   */
  @visibility("read")
  endAzimuthDegrees?: float32;

  /**
   * Spacecraft elevation above the horizon at contact start.
   */
  @visibility("read")
  startElevationDegrees?: float32;

  /**
   * Spacecraft elevation above the horizon at contact end.
   */
  @visibility("read")
  endElevationDegrees?: float32;
}

/**
 * Properties of the contact profile resource.
 */
model ContactProfileProperties extends ContactProfilesProperties {}

/**
 * List of Contact Profile Resource Properties.
 */
model ContactProfilesProperties {
  /**
   * The current state of the resource's creation, deletion, or modification.
   */
  provisioningState?: ContactProfilesPropertiesProvisioningState;

  /**
   * Minimum viable contact duration in ISO 8601 format. Used for listing the available contacts with a spacecraft at a given ground station.
   */
  minimumViableContactDuration?: duration;

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
   * Links of the Contact Profile. Describes RF links, modem processing, and IP endpoints.
   */
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
   * Direction (uplink or downlink).
   */
  direction: Direction;

  /**
   * Gain To Noise Temperature in db/K. It is the required G/T by the customer. Not used yet.
   */
  gainOverTemperature?: float32;

  /**
   * Effective Isotropic Radiated Power (EIRP) in dBW. It is the required EIRP by the customer. Not used yet.
   */
  eirpdBW?: float32;

  /**
   * Contact Profile Link Channel.
   */
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
   * Customer End point to store/retrieve data during a contact.
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
 * Customer End point to store/retrieve data during a contact.
 */
model EndPoint {
  /**
   * IP Address.
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
 * The properties bag for this resource.
 */
model AvailableGroundStationProperties extends GroundStationProperties {}

/**
 * Properties object for Available groundstation.
 */
model GroundStationProperties {
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
  @visibility("read")
  nextLink?: string;
}

model ResourceIdListResultValueItem {
  /**
   * The Azure Resource ID.
   */
  id?: string;
}

/**
 * Operation Result Entity.
 */
model OperationResult {
  /**
   * ID of the resource.
   */
  @visibility("read")
  id?: string;

  /**
   * Name of the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * The status of operation.
   */
  @visibility("read")
  status?: Status;

  /**
   * The operation start time (ISO 8601 UTC standard).
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The operation end time (ISO 8601 UTC standard).
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Percentage completed.
   */
  @visibility("read")
  @maxValue(100)
  percentComplete?: float64;

  /**
   * Operation result properties.
   */
  @extension("x-ms-client-flatten", true)
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
  @visibility("read")
  code?: string;

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;
}
