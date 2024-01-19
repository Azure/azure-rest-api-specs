import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Communication;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning state of the resource.")
enum CommunicationServicesProvisioningState {
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

@doc("Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).")
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

@doc("Provisioning state of the resource.")
enum DomainsProvisioningState {
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

@doc("Describes how a Domains resource is being managed.")
enum DomainManagement {
  AzureManaged,
  CustomerManaged,
  CustomerManagedInExchangeOnline,
}

@doc("Status of the verification operation.")
enum VerificationStatus {
  NotStarted,
  VerificationRequested,
  VerificationInProgress,
  VerificationFailed,
  Verified,
  CancellationRequested,
}

@doc("Describes whether user engagement tracking is enabled or disabled.")
enum UserEngagementTracking {
  Disabled,
  Enabled,
}

@doc("Type of verification.")
enum VerificationType {
  Domain,
  SPF,
  DKIM,
  DKIM2,
  DMARC,
}

@doc("Provisioning state of the resource.")
enum EmailServicesProvisioningState {
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

@doc("Provisioning state of the resource. Unknown is the default state for Communication Services.")
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

@doc("The keyType to regenerate. Must be either 'primary' or 'secondary'(case-insensitive).")
@fixed
enum KeyType {
  Primary,
  Secondary,
}

@doc("Data POST-ed to the nameAvailability action")
model NameAvailabilityParameters extends CheckNameAvailabilityRequest {}

@doc("The check availability request body.")
model CheckNameAvailabilityRequest {
  @doc("The name of the resource for which availability needs to be checked.")
  name?: string;

  @doc("The resource type.")
  type?: string;
}

@doc("The check availability result.")
model CheckNameAvailabilityResponse {
  @doc("Indicates if the resource name is available.")
  nameAvailable?: boolean;

  @doc("The reason why the given name is not available.")
  reason?: CheckNameAvailabilityReason;

  @doc("Detailed reason why the given name is available.")
  message?: string;
}

@doc("Description of an Azure Notification Hub to link to the communication service")
model LinkNotificationHubParameters {
  @doc("The resource ID of the notification hub")
  resourceId: string;

  @doc("Connection string for the notification hub")
  connectionString: string;
}

@doc("A notification hub that has been linked to the communication service")
model LinkedNotificationHub {
  @doc("The resource ID of the notification hub")
  resourceId?: string;
}

@doc("A class that describes the properties of the CommunicationService.")
model CommunicationServiceProperties {
  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: CommunicationServicesProvisioningState;

  @doc("FQDN of the CommunicationService instance.")
  @visibility("read")
  hostName?: string;

  @doc("The location where the communication service stores its data at rest.")
  @visibility("read", "create")
  dataLocation: string;

  @doc("Resource ID of an Azure Notification Hub linked to this resource.")
  @visibility("read")
  notificationHubId?: string;

  @doc("Version of the CommunicationService resource. Probably you need the same or higher version of client SDKs.")
  @visibility("read")
  version?: string;

  @doc("The immutable resource Id of the communication service.")
  @visibility("read")
  immutableResourceId?: string;

  @doc("List of email Domain resource Ids.")
  linkedDomains?: string[];
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. E.g. \"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}\"")
  @visibility("read")
  id?: ResourceIdentifier;

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

@doc("A class representing update parameters for CommunicationService resource.")
model CommunicationServiceResourceUpdate extends TaggedResource {
  @doc("The properties of the service.")
  properties?: CommunicationServiceUpdateProperties;

  @doc("Managed service identity (system assigned and/or user assigned identities)")
  identity?: ManagedServiceIdentity;
}

@doc("A class that describes the properties that can be updated for CommunicationService resource.")
model CommunicationServiceUpdateProperties {
  @doc("List of email Domain resource Ids.")
  linkedDomains?: string[];
}

@doc("An ARM resource with that can accept tags")
model TaggedResource {
  @doc("Tags of the service which is a list of key value pairs that describe the resource.")
  @visibility("read", "create", "update")
  tags?: Record<string>;
}

@doc("A class representing the access keys of a CommunicationService.")
model CommunicationServiceKeys {
  @doc("The primary access key.")
  primaryKey?: string;

  @doc("The secondary access key.")
  secondaryKey?: string;

  @doc("CommunicationService connection string constructed via the primaryKey")
  primaryConnectionString?: string;

  @doc("CommunicationService connection string constructed via the secondaryKey")
  secondaryConnectionString?: string;
}

@doc("Parameters describes the request to regenerate access keys")
model RegenerateKeyParameters {
  @doc("The keyType to regenerate. Must be either 'primary' or 'secondary'(case-insensitive).")
  keyType?: KeyType;
}

@doc("A class that describes the properties of a Domains resource.")
model DomainProperties {
  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: DomainsProvisioningState;

  @doc("The location where the Domains resource data is stored at rest.")
  @visibility("read")
  dataLocation?: string;

  @doc("P2 sender domain that is displayed to the email recipients [RFC 5322].")
  @visibility("read")
  fromSenderDomain?: string;

  @doc("P1 sender domain that is present on the email envelope [RFC 5321].")
  @visibility("read")
  mailFromSenderDomain?: string;

  @doc("Describes how a Domains resource is being managed.")
  domainManagement: DomainManagement;

  @doc("List of VerificationStatusRecord")
  @visibility("read")
  verificationStates?: DomainPropertiesVerificationStates;

  @doc("List of DnsRecord")
  @visibility("read")
  verificationRecords?: DomainPropertiesVerificationRecords;

  @doc("Describes whether user engagement tracking is enabled or disabled.")
  userEngagementTracking?: UserEngagementTracking;
}

@doc("List of VerificationStatusRecord")
model DomainPropertiesVerificationStates {
  @doc("A class that represents a VerificationStatus record.")
  @projectedName("json", "Domain")
  domain?: VerificationStatusRecord;

  @doc("A class that represents a VerificationStatus record.")
  SPF?: VerificationStatusRecord;

  @doc("A class that represents a VerificationStatus record.")
  @projectedName("json", "DKIM")
  dkim?: VerificationStatusRecord;

  @doc("A class that represents a VerificationStatus record.")
  @projectedName("json", "DKIM2")
  dkim2?: VerificationStatusRecord;

  @doc("A class that represents a VerificationStatus record.")
  @projectedName("json", "DMARC")
  dmarc?: VerificationStatusRecord;
}

@doc("A class that represents a VerificationStatus record.")
model VerificationStatusRecord {
  @doc("Status of the verification operation.")
  @visibility("read")
  status?: VerificationStatus;

  @doc("Error code. This property will only be present if the status is UnableToVerify.")
  @visibility("read")
  errorCode?: string;
}

@doc("List of DnsRecord")
model DomainPropertiesVerificationRecords {
  @doc("A class that represents a VerificationStatus record.")
  @projectedName("json", "Domain")
  domain?: DnsRecord;

  @doc("A class that represents a VerificationStatus record.")
  SPF?: DnsRecord;

  @doc("A class that represents a VerificationStatus record.")
  @projectedName("json", "DKIM")
  dkim?: DnsRecord;

  @doc("A class that represents a VerificationStatus record.")
  @projectedName("json", "DKIM2")
  dkim2?: DnsRecord;

  @doc("A class that represents a VerificationStatus record.")
  @projectedName("json", "DMARC")
  dmarc?: DnsRecord;
}

@doc("A class that represents a VerificationStatus record.")
model DnsRecord {
  @doc("Type of the DNS record. Example: TXT")
  @visibility("read")
  type?: string;

  @doc("Name of the DNS record.")
  @visibility("read")
  name?: string;

  @doc("Value of the DNS record.")
  @visibility("read")
  value?: string;

  @doc("Represents an expiry time in seconds to represent how long this entry can be cached by the resolver, default = 3600sec.")
  @visibility("read")
  ttl?: int32;
}

@doc("A class that describes the PATCH request parameters of a Domains resource.")
model UpdateDomainRequestParameters extends TaggedResource {
  @doc("A class that describes the updatable properties of a Domains resource.")
  properties?: UpdateDomainProperties;
}

@doc("A class that describes the updatable properties of a Domains resource.")
model UpdateDomainProperties {
  @doc("Describes whether user engagement tracking is enabled or disabled.")
  userEngagementTracking?: UserEngagementTracking;
}

@doc("Input parameter for verification APIs")
model VerificationParameter {
  @doc("Type of verification.")
  verificationType: VerificationType;
}

@doc("A class that describes the properties of the EmailService.")
model EmailServiceProperties {
  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: EmailServicesProvisioningState;

  @doc("The location where the email service stores its data at rest.")
  @visibility("read", "create")
  dataLocation: string;
}

@doc("A class representing update parameters for EmailService resource.")
model EmailServiceResourceUpdate extends TaggedResource {}

@doc("A class that describes the properties of a SenderUsername resource.")
model SenderUsernameProperties {
  @doc("The location where the SenderUsername resource data is stored at rest.")
  @visibility("read")
  dataLocation?: string;

  @doc("A sender senderUsername to be used when sending emails.")
  username: string;

  @doc("The display name for the senderUsername.")
  displayName?: string;

  @doc("Provisioning state of the resource. Unknown is the default state for Communication Services.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("A class that describes the properties of a SuppressionList resource.")
model SuppressionListProperties {
  @doc("The the name of the suppression list. This value must match one of the valid sender usernames of the sending domain.")
  listName?: string;

  @doc("The date the resource was last updated.")
  @visibility("read")
  lastUpdatedTimeStamp?: string;

  @doc("The date the resource was created.")
  @visibility("read")
  createdTimeStamp?: string;

  @doc("The location where the SuppressionListAddress data is stored at rest. This value is inherited from the parent Domains resource.")
  @visibility("read")
  dataLocation?: string;
}

@doc("A class that describes the properties of a SuppressionListAddress resource.")
model SuppressionListAddressProperties {
  @doc("Email address of the recipient.")
  email: string;

  @doc("The first name of the email recipient.")
  firstName?: string;

  @doc("The last name of the email recipient.")
  lastName?: string;

  @doc("An optional property to provide contextual notes or a description for an address.")
  notes?: string;

  @doc("The date the address was last updated in a suppression list.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  @doc("The location where the SuppressionListAddress data is stored at rest. This value is inherited from the parent Domains resource.")
  @visibility("read")
  dataLocation?: string;
}
