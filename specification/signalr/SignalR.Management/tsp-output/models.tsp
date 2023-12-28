import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Azure.ResourceManager.SignalR;

interface Operations extends Azure.ResourceManager.Operations {}

enum SignalRSkuTier {
  Free,
  Basic,
  Standard,
  Premium,
}

enum ProvisioningState {
  Unknown,
  Succeeded,
  Failed,
  Canceled,
  Running,
  Creating,
  Updating,
  Deleting,
  Moving,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum PrivateLinkServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

enum SharedPrivateLinkResourceStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
  Timeout,
}

enum FeatureFlags {
  ServiceMode,
  EnableConnectivityLogs,
  EnableMessagingLogs,
  EnableLiveTrace,
}

enum UpstreamAuthType {
  None,
  ManagedIdentity,
}

enum ACLAction {
  Allow,
  Deny,
}

enum SignalRRequestType {
  ClientConnection,
  ServerConnection,
  RESTAPI,
  Trace,
}

enum ServiceKind {
  SignalR,
  RawWebSockets,
}

enum ManagedIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
}

enum KeyType {
  Primary,
  Secondary,
  Salt,
}

enum ScaleType {
  None,
  Manual,
  Automatic,
}

@doc("Extra Operation properties.")
model OperationProperties {
  @doc("An object that describes a specification.")
  serviceSpecification?: ServiceSpecification;
}

@doc("An object that describes a specification.")
model ServiceSpecification {
  @doc("Specifications of the Metrics for Azure Monitoring.")
  metricSpecifications?: MetricSpecification[];

  @doc("Specifications of the Logs for Azure Monitoring.")
  logSpecifications?: LogSpecification[];
}

@doc("Specifications of the Metrics for Azure Monitoring.")
model MetricSpecification {
  @doc("Name of the metric.")
  name?: string;

  @doc("Localized friendly display name of the metric.")
  displayName?: string;

  @doc("Localized friendly description of the metric.")
  displayDescription?: string;

  @doc("The unit that makes sense for the metric.")
  unit?: string;

  @doc("Only provide one value for this field. Valid values: Average, Minimum, Maximum, Total, Count.")
  aggregationType?: string;

  @doc("""
Optional. If set to true, then zero will be returned for time duration where no metric is emitted/published. 
Ex. a metric that returns the number of times a particular error code was emitted. The error code may not appear 
often, instead of the RP publishing 0, Shoebox can auto fill in 0s for time periods where nothing was emitted.
""")
  fillGapWithZero?: string;

  @doc("The name of the metric category that the metric belongs to. A metric can only belong to a single category.")
  category?: string;

  @doc("The dimensions of the metrics.")
  dimensions?: Dimension[];
}

@doc("Specifications of the Dimension of metrics.")
model Dimension {
  @doc("The public facing name of the dimension.")
  name?: string;

  @doc("Localized friendly display name of the dimension.")
  displayName?: string;

  @doc("Name of the dimension as it appears in MDM.")
  internalName?: string;

  @doc("A Boolean flag indicating whether this dimension should be included for the shoebox export scenario.")
  toBeExportedForShoebox?: boolean;
}

@doc("Specifications of the Logs for Azure Monitoring.")
model LogSpecification {
  @doc("Name of the log.")
  name?: string;

  @doc("Localized friendly display name of the log.")
  displayName?: string;
}

@doc("Data POST-ed to the nameAvailability action")
model NameAvailabilityParameters {
  @doc("The resource type. Can be \"Microsoft.SignalRService/SignalR\" or \"Microsoft.SignalRService/webPubSub\"")
  type: string;

  @doc("The resource name to validate. e.g.\"my-resource-name\"")
  name: string;
}

@doc("Result of the request to check name availability. It contains a flag and possible reason of failure.")
model NameAvailability {
  @doc("Indicates whether the name is available or not.")
  nameAvailable?: boolean;

  @doc("The reason of the availability. Required if name is not available.")
  reason?: string;

  @doc("The message of the operation.")
  message?: string;
}

@doc("Object that includes an array of the resource usages and a possible link for next set.")
model SignalRUsageList is Azure.Core.Page<SignalRUsage>;

@doc("Object that describes a specific usage of the resources.")
model SignalRUsage {
  @doc("Fully qualified ARM resource id")
  id?: string;

  @doc("Current value for the usage quota.")
  currentValue?: int32;

  @doc("The maximum permitted value for the usage quota. If there is no limit, this value will be -1.")
  limit?: int32;

  @doc("Localizable String object containing the name and a localized value.")
  name?: SignalRUsageName;

  @doc("Representing the units of the usage quota. Possible values are: Count, Bytes, Seconds, Percent, CountPerSecond, BytesPerSecond.")
  unit?: string;
}

@doc("Localizable String object containing the name and a localized value.")
model SignalRUsageName {
  @doc("The identifier of the usage.")
  value?: string;

  @doc("Localized name of the usage.")
  localizedValue?: string;
}

@doc("A class that describes the properties of the resource")
model SignalRProperties {
  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The publicly accessible IP of the resource.")
  @visibility("read")
  externalIP?: string;

  @doc("FQDN of the service instance.")
  @visibility("read")
  hostName?: string;

  @doc("The publicly accessible port of the resource which is designed for browser/client side usage.")
  @visibility("read")
  publicPort?: int32;

  @doc("The publicly accessible port of the resource which is designed for customer server side usage.")
  @visibility("read")
  serverPort?: int32;

  @doc("Version of the resource. Probably you need the same or higher version of client SDKs.")
  @visibility("read")
  version?: string;

  @doc("Private endpoint connections to the resource.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("The list of shared private link resources.")
  @visibility("read")
  sharedPrivateLinkResources?: SharedPrivateLinkResource[];

  @doc("TLS settings for the resource")
  tls?: SignalRTlsSettings;

  @doc("Deprecated.")
  @visibility("read")
  hostNamePrefix?: string;

  @doc("""
List of the featureFlags.

FeatureFlags that are not included in the parameters for the update operation will not be modified.
And the response will only include featureFlags that are explicitly set. 
When a featureFlag is not explicitly set, its globally default value will be used
But keep in mind, the default value doesn't mean \"false\". It varies in terms of different FeatureFlags.
""")
  features?: SignalRFeature[];

  @doc("Live trace configuration of a Microsoft.SignalRService resource.")
  liveTraceConfiguration?: LiveTraceConfiguration;

  @doc("Resource log configuration of a Microsoft.SignalRService resource.")
  resourceLogConfiguration?: ResourceLogConfiguration;

  @doc("Cross-Origin Resource Sharing (CORS) settings.")
  cors?: SignalRCorsSettings;

  @doc("The settings for the Upstream when the service is in server-less mode.")
  upstream?: ServerlessUpstreamSettings;

  @doc("Network ACLs for the resource")
  networkACLs?: SignalRNetworkACLs;

  @doc("""
Enable or disable public network access. Default to \"Enabled\".
When it's Enabled, network ACLs still apply.
When it's Disabled, public network access is always disabled no matter what you set in network ACLs.
""")
  publicNetworkAccess?: string;

  @doc("""
DisableLocalAuth
Enable or disable local auth with AccessKey
When set as true, connection with AccessKey=xxx won't work.
""")
  disableLocalAuth?: boolean;

  @doc("""
DisableLocalAuth
Enable or disable aad auth
When set as true, connection with AuthType=aad won't work.
""")
  disableAadAuth?: boolean;
}

@doc("Private endpoint connection properties")
model PrivateEndpointConnectionProperties {
  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Private endpoint")
  privateEndpoint?: PrivateEndpoint;

  @doc("Group IDs")
  @visibility("read")
  groupIds?: string[];

  @doc("Connection state of the private endpoint connection")
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
}

@doc("Private endpoint")
model PrivateEndpoint {
  @doc("Full qualified Id of the private endpoint")
  id?: string;
}

@doc("Connection state of the private endpoint connection")
model PrivateLinkServiceConnectionState {
  @doc("Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.")
  status?: PrivateLinkServiceConnectionStatus;

  @doc("The reason for approval/rejection of the connection.")
  description?: string;

  @doc("A message indicating if changes on the service provider require any updates on the consumer.")
  actionsRequired?: string;
}

@doc("The core properties of ARM resources.")
model Resource {
  @doc("Fully qualified resource Id for the resource.")
  @visibility("read")
  id?: string;

  @doc("The name of the resource.")
  @visibility("read")
  name?: string;

  @doc("The type of the resource - e.g. \"Microsoft.SignalRService/SignalR\"")
  @visibility("read")
  type?: string;
}

@doc("Describes the properties of an existing Shared Private Link Resource")
model SharedPrivateLinkResourceProperties {
  @doc("The group id from the provider of resource the shared private link resource is for")
  groupId: string;

  @doc("The resource id of the resource the shared private link resource is for")
  privateLinkResourceId: string;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The request message for requesting approval of the shared private link resource")
  requestMessage?: string;

  @doc("Status of the shared private link resource")
  @visibility("read")
  status?: SharedPrivateLinkResourceStatus;
}

@doc("TLS settings for the resource")
model SignalRTlsSettings {
  @doc("Request client certificate during TLS handshake if enabled")
  clientCertEnabled?: boolean;
}

@doc("Feature of a resource, which controls the runtime behavior.")
model SignalRFeature {
  @doc("""
FeatureFlags is the supported features of Azure SignalR service.
- ServiceMode: Flag for backend server for SignalR service. Values allowed: \"Default\": have your own backend server; \"Serverless\": your application doesn't have a backend server; \"Classic\": for backward compatibility. Support both Default and Serverless mode but not recommended; \"PredefinedOnly\": for future use.
- EnableConnectivityLogs: \"true\"/\"false\", to enable/disable the connectivity log category respectively.
- EnableMessagingLogs: \"true\"/\"false\", to enable/disable the connectivity log category respectively.
- EnableLiveTrace: Live Trace allows you to know what's happening inside Azure SignalR service, it will give you live traces in real time, it will be helpful when you developing your own Azure SignalR based web application or self-troubleshooting some issues. Please note that live traces are counted as outbound messages that will be charged. Values allowed: \"true\"/\"false\", to enable/disable live trace feature.
""")
  flag: FeatureFlags;

  @doc("Value of the feature flag. See Azure SignalR service document https://docs.microsoft.com/azure/azure-signalr/ for allowed values.")
  @maxLength(128)
  @minLength(1)
  value: string;

  @doc("Optional properties related to this feature.")
  properties?: Record<string>;
}

@doc("Live trace configuration of a Microsoft.SignalRService resource.")
model LiveTraceConfiguration {
  @doc("""
Indicates whether or not enable live trace.
When it's set to true, live trace client can connect to the service.
Otherwise, live trace client can't connect to the service, so that you are unable to receive any log, no matter what you configure in \"categories\".
Available values: true, false.
Case insensitive.
""")
  enabled?: string;

  @doc("Gets or sets the list of category configurations.")
  categories?: LiveTraceCategory[];
}

@doc("Live trace category configuration of a Microsoft.SignalRService resource.")
model LiveTraceCategory {
  @doc("""
Gets or sets the live trace category's name.
Available values: ConnectivityLogs, MessagingLogs.
Case insensitive.
""")
  name?: string;

  @doc("""
Indicates whether or the live trace category is enabled.
Available values: true, false.
Case insensitive.
""")
  enabled?: string;
}

@doc("Resource log configuration of a Microsoft.SignalRService resource.")
model ResourceLogConfiguration {
  @doc("Gets or sets the list of category configurations.")
  categories?: ResourceLogCategory[];
}

@doc("Resource log category configuration of a Microsoft.SignalRService resource.")
model ResourceLogCategory {
  @doc("""
Gets or sets the resource log category's name.
Available values: ConnectivityLogs, MessagingLogs.
Case insensitive.
""")
  name?: string;

  @doc("""
Indicates whether or the resource log category is enabled.
Available values: true, false.
Case insensitive.
""")
  enabled?: string;
}

@doc("Cross-Origin Resource Sharing (CORS) settings.")
model SignalRCorsSettings {
  @doc("Gets or sets the list of origins that should be allowed to make cross-origin calls (for example: http://example.com:12345). Use \"*\" to allow all. If omitted, allow all by default.")
  allowedOrigins?: string[];
}

@doc("The settings for the Upstream when the service is in server-less mode.")
model ServerlessUpstreamSettings {
  @doc("Gets or sets the list of Upstream URL templates. Order matters, and the first matching template takes effects.")
  templates?: UpstreamTemplate[];
}

@doc("""
Upstream template item settings. It defines the Upstream URL of the incoming requests.
The template defines the pattern of the event, the hub or the category of the incoming request that matches current URL template.
""")
model UpstreamTemplate {
  @doc("""
Gets or sets the matching pattern for hub names. If not set, it matches any hub.
There are 3 kind of patterns supported:
    1. \"*\", it to matches any hub name.
    2. Combine multiple hubs with \",\", for example \"hub1,hub2\", it matches \"hub1\" and \"hub2\".
    3. The single hub name, for example, \"hub1\", it matches \"hub1\".
""")
  hubPattern?: string;

  @doc("""
Gets or sets the matching pattern for event names. If not set, it matches any event.
There are 3 kind of patterns supported:
    1. \"*\", it to matches any event name.
    2. Combine multiple events with \",\", for example \"connect,disconnect\", it matches event \"connect\" and \"disconnect\".
    3. The single event name, for example, \"connect\", it matches \"connect\".
""")
  eventPattern?: string;

  @doc("""
Gets or sets the matching pattern for category names. If not set, it matches any category.
There are 3 kind of patterns supported:
    1. \"*\", it to matches any category name.
    2. Combine multiple categories with \",\", for example \"connections,messages\", it matches category \"connections\" and \"messages\".
    3. The single category name, for example, \"connections\", it matches the category \"connections\".
""")
  categoryPattern?: string;

  @doc("""
Gets or sets the Upstream URL template. You can use 3 predefined parameters {hub}, {category} {event} inside the template, the value of the Upstream URL is dynamically calculated when the client request comes in.
For example, if the urlTemplate is `http://example.com/{hub}/api/{event}`, with a client request from hub `chat` connects, it will first POST to this URL: `http://example.com/chat/api/connect`.
""")
  urlTemplate: string;

  @doc("Upstream auth settings. If not set, no auth is used for upstream messages.")
  auth?: UpstreamAuthSettings;
}

@doc("Upstream auth settings. If not set, no auth is used for upstream messages.")
model UpstreamAuthSettings {
  @doc("Upstream auth type enum.")
  type?: UpstreamAuthType;

  @doc("Managed identity settings for upstream.")
  managedIdentity?: ManagedIdentitySettings;
}

@doc("Managed identity settings for upstream.")
model ManagedIdentitySettings {
  @doc("""
The Resource indicating the App ID URI of the target resource.
It also appears in the aud (audience) claim of the issued token.
""")
  resource?: string;
}

@doc("Network ACLs for the resource")
model SignalRNetworkACLs {
  @doc("Azure Networking ACL Action.")
  defaultAction?: ACLAction;

  @doc("Network ACL")
  publicNetwork?: NetworkACL;

  @doc("ACLs for requests from private endpoints")
  privateEndpoints?: PrivateEndpointACL[];
}

@doc("Network ACL")
model NetworkACL {
  @doc("Allowed request types. The value can be one or more of: ClientConnection, ServerConnection, RESTAPI.")
  allow?: SignalRRequestType[];

  @doc("Denied request types. The value can be one or more of: ClientConnection, ServerConnection, RESTAPI.")
  deny?: SignalRRequestType[];
}

@doc("ACL for a private endpoint")
model PrivateEndpointACL extends NetworkACL {
  @doc("Name of the private endpoint connection")
  name: string;
}

@doc("A class represent managed identities used for request and response")
model ManagedIdentity {
  @doc("Represents the identity type: systemAssigned, userAssigned, None")
  type?: ManagedIdentityType;

  @doc("Get or set the user assigned identities")
  userAssignedIdentities?: Record<UserAssignedIdentityProperty>;

  @doc("""
Get the principal id for the system assigned identity.
Only be used in response.
""")
  @visibility("read")
  principalId?: string;

  @doc("""
Get the tenant id for the system assigned identity.
Only be used in response
""")
  @visibility("read")
  tenantId?: string;
}

@doc("Properties of user assigned identity.")
model UserAssignedIdentityProperty {
  @doc("Get the principal id for the user assigned identity")
  @visibility("read")
  principalId?: string;

  @doc("Get the client id for the user assigned identity")
  @visibility("read")
  clientId?: string;
}

@doc("Custom certificate properties.")
model CustomCertificateProperties {
  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Base uri of the KeyVault that stores certificate.")
  @visibility("read", "create")
  keyVaultBaseUri: string;

  @doc("Certificate secret name.")
  @visibility("read", "create")
  keyVaultSecretName: string;

  @doc("Certificate secret version.")
  @visibility("read", "create")
  keyVaultSecretVersion?: string;
}

@doc("Properties of a custom domain.")
model CustomDomainProperties {
  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The custom domain name.")
  domainName: string;

  @doc("Reference to a resource.")
  customCertificate: ResourceReference;
}

@doc("Reference to a resource.")
model ResourceReference {
  @doc("Resource ID.")
  id?: string;
}

@doc("A class represents the access keys of the resource.")
model SignalRKeys {
  @doc("The primary access key.")
  primaryKey?: string;

  @doc("The secondary access key.")
  secondaryKey?: string;

  @doc("Connection string constructed via the primaryKey")
  primaryConnectionString?: string;

  @doc("Connection string constructed via the secondaryKey")
  secondaryConnectionString?: string;
}

@doc("Contains a list of PrivateLinkResource and a possible link to query more results")
model PrivateLinkResourceList is Azure.Core.Page<PrivateLinkResource>;

@doc("Private link resource")
model PrivateLinkResource extends ProxyResource {
  @doc("Private link resource properties")
  properties?: PrivateLinkResourceProperties;
}

@doc("Private link resource properties")
model PrivateLinkResourceProperties {
  @doc("Group Id of the private link resource")
  groupId?: string;

  @doc("Required members of the private link resource")
  requiredMembers?: string[];

  @doc("Required private DNS zone names")
  requiredZoneNames?: string[];

  @doc("The list of resources that are onboarded to private link service")
  shareablePrivateLinkResourceTypes?: ShareablePrivateLinkResourceType[];
}

@doc("Describes a  resource type that has been onboarded to private link service")
model ShareablePrivateLinkResourceType {
  @doc("The name of the resource type that has been onboarded to private link service")
  name?: string;

  @doc("Describes the properties of a resource type that has been onboarded to private link service")
  properties?: ShareablePrivateLinkResourceProperties;
}

@doc("Describes the properties of a resource type that has been onboarded to private link service")
model ShareablePrivateLinkResourceProperties {
  @doc("The description of the resource type that has been onboarded to private link service")
  description?: string;

  @doc("The resource provider group id for the resource that has been onboarded to private link service")
  groupId?: string;

  @doc("The resource provider type for the resource that has been onboarded to private link service")
  type?: string;
}

@doc("Parameters describes the request to regenerate access keys")
model RegenerateKeyParameters {
  @doc("The type of access key.")
  keyType?: KeyType;
}

@doc("The list skus operation response")
model SkuList {
  @doc("The list of skus available for the resource.")
  @visibility("read")
  value?: Sku[];

  @doc("""
The URL the client should use to fetch the next page (per server side paging).
It's null for now, added for future use.
""")
  @visibility("read")
  nextLink?: string;
}

@doc("Describes an available sku.\"")
model Sku {
  @doc("The resource type that this object applies to")
  @visibility("read")
  resourceType?: string;

  @doc("The billing information of the resource.")
  @visibility("read")
  sku?: ResourceSku;

  @doc("Describes scaling information of a sku.")
  @visibility("read")
  capacity?: SkuCapacity;
}

@doc("Describes scaling information of a sku.")
model SkuCapacity {
  @doc("The lowest permitted capacity for this resource")
  @visibility("read")
  minimum?: int32;

  @doc("The highest permitted capacity for this resource")
  @visibility("read")
  maximum?: int32;

  @doc("The default capacity.")
  @visibility("read")
  default?: int32;

  @doc("Allows capacity value list.")
  @visibility("read")
  allowedValues?: int32[];

  @doc("The scale type applicable to the sku.")
  @visibility("read")
  scaleType?: ScaleType;
}
