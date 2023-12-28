import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Azure.ResourceManager.Orbital;

interface Operations extends Azure.ResourceManager.Operations {}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum ProvisioningState {
  Creating,
  Succeeded,
  Failed,
  Canceled,
  Updating,
  Deleting,
}

enum SpacecraftsPropertiesProvisioningState {
  Creating,
  Succeeded,
  Failed,
  Canceled,
  Updating,
  Deleting,
}

enum Direction {
  uplink,
  downlink,
}

enum Polarization {
  RHCP,
  LHCP,
  linearVertical,
  linearHorizontal,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum ContactsPropertiesProvisioningState {
  Creating,
  Succeeded,
  Failed,
  Canceled,
  Updating,
  Deleting,
}

enum ContactsStatus {
  scheduled,
  cancelled,
  succeeded,
  failed,
  providerCancelled,
}

enum ContactProfilesPropertiesProvisioningState {
  Creating,
  Succeeded,
  Failed,
  Canceled,
  Updating,
  Deleting,
}

enum Protocol {
  TCP,
  UDP,
}

enum CapabilityParameter {
  EarthObservation,
  Communication,
}

enum ReleaseMode {
  Preview,
  GA,
}

enum Status {
  Succeeded,
  Canceled,
  Failed,
  Running,
}

enum Capability {
  EarthObservation,
  Communication,
}

enum ApiVersionParameter {
  `2020-09-01-preview`,
  `2021-04-04-preview`,
  `2022-03-01`,
}
@Azure.Core.fixed
enum AutoTrackingConfiguration {
  disabled,
  xBand,
  sBand,
}

@doc("An error response from the service.")
@error
model CloudError {
  @doc("An error response from the service.")
  error?: CloudErrorBody;
}

@doc("An error response from the service.")
model CloudErrorBody {
  @doc("An identifier for the error. Codes are invariant and are intended to be consumed programmatically.")
  code?: string;

  @doc("A message describing the error, intended to be suitable for display in a user interface.")
  message?: string;

  @doc("The target of the particular error. For example, the name of the property in error.")
  target?: string;

  @doc("A list of additional details about the error.")
  details?: CloudErrorBody[];
}

@doc("List of Spacecraft Resource Properties.")
model SpacecraftsProperties {
  @doc("The current state of the resource's creation, deletion, or modification.")
  provisioningState?: SpacecraftsPropertiesProvisioningState;

  @doc("NORAD ID of the spacecraft.")
  noradId: string;

  @doc("Title line of the two-line element set (TLE).")
  titleLine?: string;

  @doc("Line 1 of the two-line element set (TLE).")
  tleLine1?: string;

  @doc("Line 2 of the two-line element set (TLE).")
  tleLine2?: string;

  @doc("Immutable list of Spacecraft links.")
  @visibility("read", "create")
  links?: SpacecraftLink[];
}

@doc("List of authorized spacecraft links per ground station and the expiration date of the authorization.")
model SpacecraftLink {
  @doc("Link name.")
  @visibility("read", "create")
  name: string;

  @doc("Center Frequency in MHz.")
  @visibility("read", "create")
  centerFrequencyMHz: float32;

  @doc("Bandwidth in MHz.")
  @visibility("read", "create")
  bandwidthMHz: float32;

  @doc("Direction (uplink or downlink).")
  @visibility("read", "create")
  direction: Direction;

  @doc("Polarization. e.g. (RHCP, LHCP).")
  @visibility("read", "create")
  polarization: Polarization;

  @doc("Authorized Ground Stations")
  @visibility("read")
  authorizations?: AuthorizedGroundstation[];
}

@doc("Authorized groundstation.")
model AuthorizedGroundstation {
  @doc("Groundstation name.")
  groundStation?: string;

  @doc("Date of authorization expiration.")
  expirationDate?: plainDate;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Tags object for patch operations.")
model TagsObject {
  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Properties of the Contact Resource.")
model ContactsProperties {
  @doc("The current state of the resource's creation, deletion, or modification.")
  provisioningState?: ContactsPropertiesProvisioningState;

  @doc("Status of a contact.")
  @visibility("read")
  status?: ContactsStatus;

  @doc("Reservation start time of a contact (ISO 8601 UTC standard).")
  @visibility("read", "create")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reservationStartTime: utcDateTime;

  @doc("Reservation end time of a contact (ISO 8601 UTC standard).")
  @visibility("read", "create")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reservationEndTime: utcDateTime;

  @doc("Receive start time of a contact (ISO 8601 UTC standard).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  rxStartTime?: utcDateTime;

  @doc("Receive end time of a contact (ISO 8601 UTC standard).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  rxEndTime?: utcDateTime;

  @doc("Transmit start time of a contact (ISO 8601 UTC standard).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  txStartTime?: utcDateTime;

  @doc("Transmit end time of a contact (ISO 8601 UTC standard).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  txEndTime?: utcDateTime;

  @doc("Any error message while scheduling a contact.")
  @visibility("read")
  errorMessage?: string;

  @doc("Maximum elevation of the antenna during the contact in decimal degrees.")
  @visibility("read")
  maximumElevationDegrees?: float32;

  @doc("Azimuth of the antenna at the start of the contact in decimal degrees.")
  @visibility("read")
  startAzimuthDegrees?: float32;

  @doc("Azimuth of the antenna at the end of the contact in decimal degrees.")
  @visibility("read")
  endAzimuthDegrees?: float32;

  @doc("Azure Ground Station name.")
  @visibility("read", "create")
  groundStationName: string;

  @doc("Spacecraft elevation above the horizon at contact start.")
  @visibility("read")
  startElevationDegrees?: float32;

  @doc("Spacecraft elevation above the horizon at contact end.")
  @visibility("read")
  endElevationDegrees?: float32;

  @doc("The configuration associated with the allocated antenna.")
  @visibility("read")
  antennaConfiguration?: ContactsPropertiesAntennaConfiguration;

  @doc("The reference to the contact profile resource.")
  contactProfile: ContactsPropertiesContactProfile;
}

@doc("The configuration associated with the allocated antenna.")
model ContactsPropertiesAntennaConfiguration {
  @doc("The destination IP a packet can be sent to. This would for example be the TCP endpoint you would send data to.")
  destinationIp?: string;

  @doc("List of Source IP")
  sourceIps?: string[];
}

@doc("The reference to the contact profile resource.")
model ContactsPropertiesContactProfile extends ResourceReference {}

@doc("Resource Reference.")
model ResourceReference {
  @doc("Resource ID.")
  id?: string;
}

@doc("Parameters that define the contact resource.")
model ContactParameters {
  @doc("The reference to the contact profile resource.")
  contactProfile: ContactParametersContactProfile;

  @doc("Name of Azure Ground Station.")
  groundStationName: string;

  @doc("Start time of a contact (ISO 8601 UTC standard).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  @doc("End time of a contact (ISO 8601 UTC standard).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime: utcDateTime;
}

@doc("The reference to the contact profile resource.")
model ContactParametersContactProfile extends ResourceReference {}

@doc("Response for the ListAvailableContacts API service call.")
model AvailableContactsListResult {
  @doc("A list of available contacts.")
  @projectedName("json", "value")
  values?: AvailableContacts[];
}

@doc("Customer retrieves list of Available Contacts for a spacecraft resource. Later, one of the available contact can be selected to create a contact.")
model AvailableContacts {
  @doc("The reference to the spacecraft resource.")
  spacecraft?: AvailableContactsSpacecraft;

  @doc("Name of Azure Ground Station.")
  @visibility("read")
  groundStationName?: string;

  @doc("Properties of Contact resource.")
  properties?: AvailableContactsProperties;
}

@doc("The reference to the spacecraft resource.")
model AvailableContactsSpacecraft extends ResourceReference {}

@doc("Properties of Contact resource.")
model AvailableContactsProperties extends ContactInstanceProperties {}

@doc("Contact Instance Properties.")
model ContactInstanceProperties {
  @doc("Maximum elevation of the antenna during the contact in decimal degrees.")
  @visibility("read")
  maximumElevationDegrees?: float32;

  @doc("Time at which antenna transmit will be enabled (ISO 8601 UTC standard).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  txStartTime?: utcDateTime;

  @doc("Time at which antenna transmit will be disabled (ISO 8601 UTC standard).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  txEndTime?: utcDateTime;

  @doc("Earliest time to receive a signal (ISO 8601 UTC standard).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  rxStartTime?: utcDateTime;

  @doc("Time to lost receiving a signal (ISO 8601 UTC standard).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  rxEndTime?: utcDateTime;

  @doc("Azimuth of the antenna at the start of the contact in decimal degrees.")
  @visibility("read")
  startAzimuthDegrees?: float32;

  @doc("Azimuth of the antenna at the end of the contact in decimal degrees.")
  @visibility("read")
  endAzimuthDegrees?: float32;

  @doc("Spacecraft elevation above the horizon at contact start.")
  @visibility("read")
  startElevationDegrees?: float32;

  @doc("Spacecraft elevation above the horizon at contact end.")
  @visibility("read")
  endElevationDegrees?: float32;
}

@doc("Properties of the contact profile resource.")
model ContactProfileProperties extends ContactProfilesProperties {}

@doc("List of Contact Profile Resource Properties.")
model ContactProfilesProperties {
  @doc("The current state of the resource's creation, deletion, or modification.")
  provisioningState?: ContactProfilesPropertiesProvisioningState;

  @doc("Minimum viable contact duration in ISO 8601 format. Used for listing the available contacts with a spacecraft at a given ground station.")
  minimumViableContactDuration?: duration;

  @doc("Minimum viable elevation for the contact in decimal degrees. Used for listing the available contacts with a spacecraft at a given ground station.")
  minimumElevationDegrees?: float32;

  @doc("Auto-tracking configuration.")
  autoTrackingConfiguration?: AutoTrackingConfiguration;

  @doc("ARM resource identifier of the Event Hub used for telemetry. Requires granting Orbital Resource Provider the rights to send telemetry into the hub.")
  eventHubUri?: string;

  @doc("Network configuration of customer virtual network.")
  networkConfiguration: ContactProfilesPropertiesNetworkConfiguration;

  @doc("Links of the Contact Profile. Describes RF links, modem processing, and IP endpoints.")
  links: ContactProfileLink[];
}

@doc("Network configuration of customer virtual network.")
model ContactProfilesPropertiesNetworkConfiguration {
  @doc("ARM resource identifier of the subnet delegated to the Microsoft.Orbital/orbitalGateways. Needs to be at least a class C subnet, and should not have any IP created in it.")
  subnetId: string;
}

@doc("Contact Profile Link.")
model ContactProfileLink {
  @doc("Link name.")
  name: string;

  @doc("Polarization. e.g. (RHCP, LHCP).")
  polarization: Polarization;

  @doc("Direction (uplink or downlink).")
  direction: Direction;

  @doc("Gain To Noise Temperature in db/K. It is the required G/T by the customer. Not used yet.")
  gainOverTemperature?: float32;

  @doc("Effective Isotropic Radiated Power (EIRP) in dBW. It is the required EIRP by the customer. Not used yet.")
  eirpdBW?: float32;

  @doc("Contact Profile Link Channel.")
  channels: ContactProfileLinkChannel[];
}

@doc("Contact Profile Link Channel.")
model ContactProfileLinkChannel {
  @doc("Channel name.")
  name: string;

  @doc("Center Frequency in MHz.")
  centerFrequencyMHz: float32;

  @doc("Bandwidth in MHz.")
  bandwidthMHz: float32;

  @doc("Customer End point to store/retrieve data during a contact.")
  endPoint: EndPoint;

  @doc("Copy of the modem configuration file such as Kratos QRadio. Only valid for uplink directions. If provided, the modem connects to the customer endpoint and accepts commands from the customer instead of a VITA.49 stream.")
  modulationConfiguration?: string;

  @doc("Copy of the modem configuration file such as Kratos QRadio or Kratos QuantumRx. Only valid for downlink directions. If provided, the modem connects to the customer endpoint and sends demodulated data instead of a VITA.49 stream.")
  demodulationConfiguration?: string;

  @doc("Currently unused.")
  encodingConfiguration?: string;

  @doc("Currently unused.")
  decodingConfiguration?: string;
}

@doc("Customer End point to store/retrieve data during a contact.")
model EndPoint {
  @doc("IP Address.")
  ipAddress: string;

  @doc("Name of an end point.")
  endPointName: string;

  @doc("TCP port to listen on to receive data.")
  port: string;

  @doc("Protocol either UDP or TCP.")
  protocol: Protocol;
}

@doc("The properties bag for this resource.")
model AvailableGroundStationProperties extends GroundStationProperties {}

@doc("Properties object for Available groundstation.")
model GroundStationProperties {
  @doc("City of ground station.")
  city?: string;

  @doc("Ground station provider name.")
  providerName?: string;

  @doc("Longitude of the ground station in decimal degrees.")
  longitudeDegrees?: float32;

  @doc("Latitude of the ground station in decimal degrees.")
  latitudeDegrees?: float32;

  @doc("Altitude of the ground station.")
  altitudeMeters?: float32;

  @doc("Release Status of a ground station.")
  releaseMode?: ReleaseMode;
}

@doc("Response for an API service call that lists the resource IDs of resources associated with another resource.")
model ResourceIdListResult {
  @doc("A list of Azure Resource IDs.")
  value?: ResourceIdListResultValueItem[];

  @doc("The URL to get the next set of results.")
  @visibility("read")
  nextLink?: string;
}

model ResourceIdListResultValueItem {
  @doc("The Azure Resource ID.")
  id?: string;
}

@doc("Operation Result Entity.")
model OperationResult {
  @doc("ID of the resource.")
  @visibility("read")
  id?: string;

  @doc("Name of the resource.")
  @visibility("read")
  name?: string;

  @doc("The status of operation.")
  @visibility("read")
  status?: Status;

  @doc("The operation start time (ISO 8601 UTC standard).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The operation end time (ISO 8601 UTC standard).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Percentage completed.")
  @visibility("read")
  @maxValue(100)
  percentComplete?: float32;

  @doc("Operation result properties.")
  properties?: Record<unknown>;

  @doc("Operation result error properties.")
  error?: OperationResultErrorProperties;
}

@doc("Operation result error properties.")
model OperationResultErrorProperties {
  @doc("The code of the error.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;
}
