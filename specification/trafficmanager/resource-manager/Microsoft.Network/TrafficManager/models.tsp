import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Network;

/**
 * The status of the endpoint. If the endpoint is Enabled, it is probed for endpoint health and is included in the traffic routing method.
 */
union EndpointStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The monitoring status of the endpoint.
 */
union EndpointMonitorStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CheckingEndpoint: "CheckingEndpoint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Online: "Online",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Degraded: "Degraded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Inactive: "Inactive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Stopped: "Stopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unmonitored: "Unmonitored",
}

/**
 * If Always Serve is enabled, probing for endpoint health will be disabled and endpoints will be included in the traffic routing method.
 */
union AlwaysServe {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The status of the Traffic Manager profile.
 */
union ProfileStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The traffic routing method of the Traffic Manager profile.
 */
union TrafficRoutingMethod {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Performance: "Performance",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Priority: "Priority",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Weighted: "Weighted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Geographic: "Geographic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MultiValue: "MultiValue",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Subnet: "Subnet",
}

/**
 * The profile-level monitoring status of the Traffic Manager profile.
 */
union ProfileMonitorStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CheckingEndpoints: "CheckingEndpoints",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Online: "Online",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Degraded: "Degraded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Inactive: "Inactive",
}

/**
 * The protocol (HTTP, HTTPS or TCP) used to probe for endpoint health.
 */
union MonitorProtocol {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  HTTP: "HTTP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  HTTPS: "HTTPS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TCP: "TCP",
}

/**
 * Indicates whether Traffic View is 'Enabled' or 'Disabled' for the Traffic Manager profile. Null, indicates 'Disabled'. Enabling this feature will increase the cost of the Traffic Manage profile.
 */
union TrafficViewEnrollmentStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The allowed type DNS record types for this profile.
 */
union AllowedEndpointRecordType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DomainName: "DomainName",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IPv4Address: "IPv4Address",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IPv6Address: "IPv6Address",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Any: "Any",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum EndpointType {
  AzureEndpoints,
  ExternalEndpoints,
  NestedEndpoints,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum HeatMapType {
  default,
}

/**
 * Class representing a Traffic Manager endpoint properties.
 */
model EndpointProperties {
  /**
   * The Azure Resource URI of the of the endpoint. Not applicable to endpoints of type 'ExternalEndpoints'.
   */
  targetResourceId?: string;

  /**
   * The fully-qualified DNS name or IP address of the endpoint. Traffic Manager returns this value in DNS responses to direct traffic to this endpoint.
   */
  target?: string;

  /**
   * The status of the endpoint. If the endpoint is Enabled, it is probed for endpoint health and is included in the traffic routing method.
   */
  endpointStatus?: EndpointStatus;

  /**
   * The weight of this endpoint when using the 'Weighted' traffic routing method. Possible values are from 1 to 1000.
   */
  weight?: int64;

  /**
   * The priority of this endpoint when using the 'Priority' traffic routing method. Possible values are from 1 to 1000, lower values represent higher priority. This is an optional parameter.  If specified, it must be specified on all endpoints, and no two endpoints can share the same priority value.
   */
  priority?: int64;

  /**
   * Specifies the location of the external or nested endpoints when using the 'Performance' traffic routing method.
   */
  endpointLocation?: string;

  /**
   * The monitoring status of the endpoint.
   */
  endpointMonitorStatus?: EndpointMonitorStatus;

  /**
   * The minimum number of endpoints that must be available in the child profile in order for the parent profile to be considered available. Only applicable to endpoint of type 'NestedEndpoints'.
   */
  minChildEndpoints?: int64;

  /**
   * The minimum number of IPv4 (DNS record type A) endpoints that must be available in the child profile in order for the parent profile to be considered available. Only applicable to endpoint of type 'NestedEndpoints'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  minChildEndpointsIPv4?: int64;

  /**
   * The minimum number of IPv6 (DNS record type AAAA) endpoints that must be available in the child profile in order for the parent profile to be considered available. Only applicable to endpoint of type 'NestedEndpoints'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  minChildEndpointsIPv6?: int64;

  /**
   * The list of countries/regions mapped to this endpoint when using the 'Geographic' traffic routing method. Please consult Traffic Manager Geographic documentation for a full list of accepted values.
   */
  geoMapping?: string[];

  /**
   * The list of subnets, IP addresses, and/or address ranges mapped to this endpoint when using the 'Subnet' traffic routing method. An empty list will match all ranges not covered by other endpoints.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subnets?: EndpointPropertiesSubnetsItem[];

  /**
   * List of custom headers.
   */
  customHeaders?: EndpointPropertiesCustomHeadersItem[];

  /**
   * If Always Serve is enabled, probing for endpoint health will be disabled and endpoints will be included in the traffic routing method.
   */
  alwaysServe?: AlwaysServe;
}

/**
 * Subnet first address, scope, and/or last address.
 */
model EndpointPropertiesSubnetsItem {
  /**
   * First address in the subnet.
   */
  first?: string;

  /**
   * Last address in the subnet.
   */
  last?: string;

  /**
   * Block size (number of leading bits in the subnet mask).
   */
  scope?: int32;
}

/**
 * Custom header name and value.
 */
model EndpointPropertiesCustomHeadersItem {
  /**
   * Header name.
   */
  name?: string;

  /**
   * Header value.
   */
  value?: string;
}

/**
 * The resource model definition for a ARM proxy resource. It will have everything other than required location and tags
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProxyResource extends Resource {}

/**
 * The core properties of ARM resources
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource
model Resource {
  /**
   * Fully qualified resource Id for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/trafficManagerProfiles/{resourceName}
   */
  id?: armResourceIdentifier;

  /**
   * The name of the resource
   */
  name?: string;

  /**
   * The type of the resource. Ex- Microsoft.Network/trafficManagerProfiles.
   */
  type?: string;
}

/**
 * An error returned by the Azure Resource Manager
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * The content of the error.
   */
  error?: CloudErrorBody;
}

/**
 * The content of an error returned by the Azure Resource Manager
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model CloudErrorBody {
  /**
   * Error code
   */
  code?: string;

  /**
   * Error message
   */
  message?: string;

  /**
   * Error target
   */
  target?: string;

  /**
   * Error details
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  details?: CloudErrorBody[];
}

/**
 * The result of the request or operation.
 */
model DeleteOperationResult {
  /**
   * The result of the operation or request.
   */
  @visibility(Lifecycle.Read)
  boolean?: boolean;
}

/**
 * Parameters supplied to check Traffic Manager name operation.
 */
model CheckTrafficManagerRelativeDnsNameAvailabilityParameters {
  /**
   * The name of the resource.
   */
  name?: string;

  /**
   * The type of the resource.
   */
  type?: string;
}

/**
 * Class representing a Traffic Manager Name Availability response.
 */
model TrafficManagerNameAvailability {
  /**
   * The relative name.
   */
  name?: string;

  /**
   * Traffic Manager profile resource type.
   */
  type?: string;

  /**
   * Describes whether the relative name is available or not.
   */
  nameAvailable?: boolean;

  /**
   * The reason why the name is not available, when applicable.
   */
  reason?: string;

  /**
   * Descriptive message that explains why the name is not available, when applicable.
   */
  message?: string;
}

/**
 * The list Traffic Manager profiles operation response.
 */
model ProfileListResult {
  /**
   * Gets the list of Traffic manager profiles.
   */
  @pageItems
  value?: Profile[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: string;
}

/**
 * Class representing the Traffic Manager profile properties.
 */
model ProfileProperties {
  /**
   * The status of the Traffic Manager profile.
   */
  profileStatus?: ProfileStatus;

  /**
   * The traffic routing method of the Traffic Manager profile.
   */
  trafficRoutingMethod?: TrafficRoutingMethod;

  /**
   * The DNS settings of the Traffic Manager profile.
   */
  dnsConfig?: DnsConfig;

  /**
   * The endpoint monitoring settings of the Traffic Manager profile.
   */
  monitorConfig?: MonitorConfig;

  /**
   * The list of endpoints in the Traffic Manager profile.
   */
  endpoints?: Endpoint[];

  /**
   * Indicates whether Traffic View is 'Enabled' or 'Disabled' for the Traffic Manager profile. Null, indicates 'Disabled'. Enabling this feature will increase the cost of the Traffic Manage profile.
   */
  trafficViewEnrollmentStatus?: TrafficViewEnrollmentStatus;

  /**
   * The list of allowed endpoint record types.
   */
  allowedEndpointRecordTypes?: AllowedEndpointRecordType[];

  /**
   * Maximum number of endpoints to be returned for MultiValue routing type.
   */
  maxReturn?: int64;
}

/**
 * Class containing DNS settings in a Traffic Manager profile.
 */
model DnsConfig {
  /**
   * The relative DNS name provided by this Traffic Manager profile. This value is combined with the DNS domain name used by Azure Traffic Manager to form the fully-qualified domain name (FQDN) of the profile.
   */
  relativeName?: string;

  /**
   * The fully-qualified domain name (FQDN) of the Traffic Manager profile. This is formed from the concatenation of the RelativeName with the DNS domain used by Azure Traffic Manager.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * The DNS Time-To-Live (TTL), in seconds. This informs the local DNS resolvers and DNS clients how long to cache DNS responses provided by this Traffic Manager profile.
   */
  ttl?: int64;
}

/**
 * Class containing endpoint monitoring settings in a Traffic Manager profile.
 */
model MonitorConfig {
  /**
   * The profile-level monitoring status of the Traffic Manager profile.
   */
  profileMonitorStatus?: ProfileMonitorStatus;

  /**
   * The protocol (HTTP, HTTPS or TCP) used to probe for endpoint health.
   */
  protocol?: MonitorProtocol;

  /**
   * The TCP port used to probe for endpoint health.
   */
  port?: int64;

  /**
   * The path relative to the endpoint domain name used to probe for endpoint health.
   */
  path?: string;

  /**
   * The monitor interval for endpoints in this profile. This is the interval at which Traffic Manager will check the health of each endpoint in this profile.
   */
  intervalInSeconds?: int64;

  /**
   * The monitor timeout for endpoints in this profile. This is the time that Traffic Manager allows endpoints in this profile to response to the health check.
   */
  timeoutInSeconds?: int64;

  /**
   * The number of consecutive failed health check that Traffic Manager tolerates before declaring an endpoint in this profile Degraded after the next failed health check.
   */
  toleratedNumberOfFailures?: int64;

  /**
   * List of custom headers.
   */
  customHeaders?: MonitorConfigCustomHeadersItem[];

  /**
   * List of expected status code ranges.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  expectedStatusCodeRanges?: MonitorConfigExpectedStatusCodeRangesItem[];
}

/**
 * Custom header name and value.
 */
model MonitorConfigCustomHeadersItem {
  /**
   * Header name.
   */
  name?: string;

  /**
   * Header value.
   */
  value?: string;
}

/**
 * Min and max value of a status code range.
 */
model MonitorConfigExpectedStatusCodeRangesItem {
  /**
   * Min status code.
   */
  min?: int32;

  /**
   * Max status code.
   */
  max?: int32;
}

/**
 * The resource model definition for a ARM tracked top level resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TrackedResource extends Resource {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The Azure Region where the resource lives
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;
}

/**
 * Class representing the properties of the Geographic hierarchy used with the Geographic traffic routing method.
 */
model GeographicHierarchyProperties {
  /**
   * The region at the root of the hierarchy from all the regions in the hierarchy can be retrieved.
   */
  geographicHierarchy?: Region;
}

/**
 * Class representing a region in the Geographic hierarchy used with the Geographic traffic routing method.
 */
model Region {
  /**
   * The code of the region
   */
  code?: string;

  /**
   * The name of the region
   */
  name?: string;

  /**
   * The list of Regions grouped under this Region in the Geographic Hierarchy.
   */
  regions?: Region[];
}

/**
 * Class representing a Traffic Manager HeatMap properties.
 */
model HeatMapProperties {
  /**
   * The beginning of the time window for this HeatMap, inclusive.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The ending of the time window for this HeatMap, exclusive.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The endpoints used in this HeatMap calculation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endpoints?: HeatMapEndpoint[];

  /**
   * The traffic flows produced in this HeatMap calculation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trafficFlows?: TrafficFlow[];
}

/**
 * Class which is a sparse representation of a Traffic Manager endpoint.
 */
model HeatMapEndpoint {
  /**
   * The ARM Resource ID of this Traffic Manager endpoint.
   */
  resourceId?: string;

  /**
   * A number uniquely identifying this endpoint in query experiences.
   */
  endpointId?: int32;
}

/**
 * Class representing a Traffic Manager HeatMap traffic flow properties.
 */
model TrafficFlow {
  /**
   * The IP address that this query experience originated from.
   */
  sourceIp?: string;

  /**
   * The approximate latitude that these queries originated from.
   */
  latitude?: float64;

  /**
   * The approximate longitude that these queries originated from.
   */
  longitude?: float64;

  /**
   * The query experiences produced in this HeatMap calculation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  queryExperiences?: QueryExperience[];
}

/**
 * Class representing a Traffic Manager HeatMap query experience properties.
 */
model QueryExperience {
  /**
   * The id of the endpoint from the 'endpoints' array which these queries were routed to.
   */
  endpointId: int32;

  /**
   * The number of queries originating from this location.
   */
  queryCount: int32;

  /**
   * The latency experienced by queries originating from this location.
   */
  latency?: float64;
}

/**
 * Class representing a Traffic Manager Real User Metrics key response.
 */
model UserMetricsProperties {
  /**
   * The key returned by the User Metrics operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: If this is a value that should be kept private, mark it with the @secret decorator"
  key?: string;
}
