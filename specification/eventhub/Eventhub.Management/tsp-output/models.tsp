import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";


using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;


namespace Microsoft.EventHub;

interface Operations extends Azure.ResourceManager.Operations {} 

/**
* Name of this SKU.
*/
    enum EventHubsClusterSkuName {
        "Dedicated"
    }

/**
* Name of this SKU.
*/
    enum SkuName {
        "Basic", "Standard", "Premium"
    }

/**
* The minimum TLS version for the cluster to support, e.g. '1.2'
*/
    enum TlsVersion {
        "1.0", "1.1", "1.2"
    }

/**
* This determines if traffic is allowed over public network. By default it is enabled.
*/
    enum PublicNetworkAccess {
        "Enabled", "Disabled", "SecuredByPerimeter"
    }

/**
* Status of the connection.
*/
    enum EventHubsPrivateLinkConnectionStatus {
        "Pending", "Approved", "Rejected", "Disconnected"
    }

/**
* Provisioning state of the Private Endpoint Connection.
*/
    enum EventHubsPrivateEndpointConnectionProvisioningState {
        "Creating", "Updating", "Deleting", "Succeeded", "Canceled", "Failed"
    }

/**
* Provisioning state of NetworkSecurityPerimeter configuration propagation
*/
    enum NetworkSecurityPerimeterConfigurationProvisioningState {
        "Unknown", "Creating", "Updating", "Accepted", "InvalidResponse", "Succeeded", "SucceededWithIssues", "Failed", "Deleting", "Deleted", "Canceled"
    }

/**
* Access Mode of the resource association
*/
    enum ResourceAssociationAccessMode {
        "NoAssociationMode", "EnforcedMode", "LearningMode", "AuditMode", "UnspecifiedMode"
    }

/**
* Direction of Access Rule
*/
    enum NspAccessRuleDirection {
        "Inbound", "Outbound"
    }

/**
* Default Action for Network Rule Set
*/
    enum EventHubsNetworkRuleSetDefaultAction {
        "Allow", "Deny"
    }

/**
* The IP Filter Action
*/
    enum EventHubsNetworkRuleIPAction {
        "Allow"
    }

/**
* This determines if traffic is allowed over public network. By default it is enabled. If value is SecuredByPerimeter then Inbound and Outbound communication is controlled by the network security perimeter and profile's access rules. 
*/
    enum EventHubsPublicNetworkAccessFlag {
        "Enabled", "Disabled", "SecuredByPerimeter"
    }


    enum EventHubsAccessRight {
        "Manage", "Send", "Listen"
    }

/**
* The access key to regenerate.
*/
    enum EventHubsAccessKeyType {
        "PrimaryKey", "SecondaryKey"
    }

/**
* Enumerates the possible values for cleanup policy
*/
    enum CleanupPolicyRetentionDescription {
        "Delete", "Compaction"
    }


    enum SchemaCompatibility {
        "None", "Backward", "Forward"
    }


    enum SchemaType {
        "Unknown", "Avro"
    }

/**
* Application Group Policy types
*/
    enum ApplicationGroupPolicyType {
        "ThrottlingPolicy"
    }

/**
* Metric Id on which the throttle limit should be set, MetricId can be discovered by hovering over Metric in the Metrics section of Event Hub Namespace inside Azure Portal
*/
    enum MetricId {
        "IncomingBytes", "OutgoingBytes", "IncomingMessages", "OutgoingMessages"
    }

/**
* Type of managed service identity.
*/@fixed
    enum ManagedServiceIdentityType {
        "SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned", "None"
    }

/**
* Specifies the reason for the unavailability of the service.
*/@fixed
    enum UnavailableReason {
        "None", "InvalidName", "SubscriptionIsDisabled", "NameInUse", "NameInLockdown", "TooManyNamespaceInCurrentSubscription"
    }

/**
* Provisioning state of the Alias(Disaster Recovery configuration) - possible values 'Accepted' or 'Succeeded' or 'Failed'
*/@fixed
    enum EventHubsDisasterRecoveryProvisioningState {
        "Accepted", "Succeeded", "Failed"
    }

/**
* role of namespace in GEO DR - possible values 'Primary' or 'PrimaryNotReplicating' or 'Secondary'
*/@fixed
    enum EventHubsDisasterRecoveryRole {
        "Primary", "PrimaryNotReplicating", "Secondary"
    }

/**
* Enumerates the possible values for the status of the Event Hub.
*/@fixed
    enum EventHubEntityStatus {
        "Active", "Disabled", "Restoring", "SendDisabled", "ReceiveDisabled", "Creating", "Deleting", "Renaming", "Unknown"
    }

/**
* Enumerates the possible values for the encoding format of capture description. Note: 'AvroDeflate' will be deprecated in New API Version
*/@fixed
    enum EncodingCaptureDescription {
        "Avro", "AvroDeflate"
    }




/**
* Pre-provisioned and readily available Event Hubs Cluster count per region.
*/
model AvailableCluster {
/**
* Location fo the Available Cluster
*/
"location"?: string;
}

/**
* SKU parameters particular to a cluster instance.
*/
model EventHubsClusterSku {
/**
* Name of this SKU.
*/
"name": EventHubsClusterSkuName;
/**
* The quantity of Event Hubs Cluster Capacity Units contained in this cluster.
*/
@minValue(1)
"capacity"?: int32;
}

/**
* Event Hubs Cluster properties supplied in responses in List or Get operations.
*/
model ClusterProperties {
/**
* The UTC time when the Event Hubs Cluster was created.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"createdAt"?: utcDateTime;
/**
* The UTC time when the Event Hubs Cluster was last updated.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"updatedAt"?: utcDateTime;
/**
* The metric ID of the cluster resource. Provided by the service and not modifiable by the user.
*/
@visibility("read")
"metricId"?: string;
/**
* Status of the Cluster resource
*/
@visibility("read")
"status"?: string;
/**
* A value that indicates whether Scaling is Supported.
*/
"supportsScaling"?: boolean;
}

/**
* Common fields that are returned in the response for all Azure Resource Manager resources
*/
model Resource {
/**
* Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
*/
@visibility("read")
"id"?: string;
/**
* The name of the resource
*/
@visibility("read")
"name"?: string;
/**
* The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
*/
@visibility("read")
"type"?: string;
}

/**
* The response of the List Namespace IDs operation
*/
model EHNamespaceIdListResult {
/**
* Result of the List Namespace IDs operation
*/
"value"?: EHNamespaceIdContainer[];
}

/**
* The full ARM ID of an Event Hubs Namespace
*/
model EHNamespaceIdContainer {
/**
* id parameter
*/
"id"?: string;
}

/**
* SKU parameters supplied to the create namespace operation
*/
model Sku {
/**
* Name of this SKU.
*/
"name": SkuName;
/**
* The billing tier of this particular SKU.
*/
"tier"?: SkuTier;
/**
* The Event Hubs throughput units for Basic or Standard tiers, where value should be 0 to 20 throughput units. The Event Hubs premium units for Premium tier, where value should be 0 to 10 premium units.
*/
"capacity"?: int32;
}

/**
* Properties to configure Identity for Bring your Own Keys
*/
model Identity {
/**
* ObjectId from the KeyVault
*/
@visibility("read")
"principalId"?: string;
/**
* TenantId from the KeyVault
*/
@visibility("read")
"tenantId"?: string;
/**
* Type of managed service identity.
*/
"type"?: ManagedServiceIdentityType;
/**
* Properties for User Assigned Identities
*/
"userAssignedIdentities"?: Record<UserAssignedIdentity>;
}

/**
* Namespace properties supplied for create namespace operation.
*/
model EHNamespaceProperties {
/**
* The minimum TLS version for the cluster to support, e.g. '1.2'
*/
"minimumTlsVersion"?: TlsVersion;
/**
* Provisioning state of the Namespace.
*/
@visibility("read")
"provisioningState"?: string;
/**
* Status of the Namespace.
*/
@visibility("read")
"status"?: string;
/**
* The time the Namespace was created.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"createdAt"?: utcDateTime;
/**
* The time the Namespace was updated.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"updatedAt"?: utcDateTime;
/**
* Endpoint you can use to perform Service Bus operations.
*/
@visibility("read")
"serviceBusEndpoint"?: string;
/**
* Cluster ARM ID of the Namespace.
*/
"clusterArmId"?: string;
/**
* Identifier for Azure Insights metrics.
*/
@visibility("read")
"metricId"?: string;
/**
* Value that indicates whether AutoInflate is enabled for eventhub namespace.
*/
"isAutoInflateEnabled"?: boolean;
/**
* This determines if traffic is allowed over public network. By default it is enabled.
*/
"publicNetworkAccess"?: PublicNetworkAccess = PublicNetworkAccess.Enabled;
/**
* Upper limit of throughput units when AutoInflate is enabled, value should be within 0 to 20 throughput units. ( '0' if AutoInflateEnabled = true)
*/
"maximumThroughputUnits"?: int32;
/**
* Value that indicates whether Kafka is enabled for eventhub namespace.
*/
"kafkaEnabled"?: boolean;
/**
* Enabling this property creates a Standard Event Hubs Namespace in regions supported availability zones.
*/
"zoneRedundant"?: boolean;
/**
* Properties of BYOK Encryption description
*/
"encryption"?: EventHubsEncryption;
/**
* List of private endpoint connections.
*/
"privateEndpointConnections"?: PrivateEndpointConnection[];
/**
* This property disables SAS authentication for the Event Hubs namespace.
*/
"disableLocalAuth"?: boolean;
/**
* Alternate name specified when alias and namespace names are same.
*/
"alternateName"?: string;
}

/**
 * The encryption keySource (provider). Possible values (case-insensitive):  Microsoft.Storage, Microsoft.Keyvault
 */
enum KeySource {
    `Microsoft.Storage`,
    `Microsoft.KeyVault`,
  }

/**
* Properties to configure Encryption
*/
model EventHubsEncryption {
/**
* Properties of KeyVault
*/
"keyVaultProperties"?: EventHubsKeyVaultProperties[];
/**
* Enumerates the possible value of keySource for Encryption
*/
"keySource"?: KeySource = KeySource.`Microsoft.KeyVault`;
/**
* Enable Infrastructure Encryption (Double Encryption)
*/
"requireInfrastructureEncryption"?: boolean;
}

/**
* Properties to configure keyVault Properties
*/
model EventHubsKeyVaultProperties {
/**
* Name of the Key from KeyVault
*/
"keyName"?: string;
/**
* Uri of KeyVault
*/
"keyVaultUri"?: string;
/**
* Key Version
*/
"keyVersion"?: string;
"identity"?: UserAssignedIdentityProperties;
}


model UserAssignedIdentityProperties {
/**
* ARM ID of user Identity selected for encryption
*/
"userAssignedIdentity"?: string;
}

/**
* Properties of the private endpoint connection resource.
*/
model PrivateEndpointConnectionProperties {
/**
* The Private Endpoint resource for this Connection.
*/
"privateEndpoint"?: PrivateEndpoint;
/**
* Details about the state of the connection.
*/
"privateLinkServiceConnectionState"?: EventHubsPrivateLinkServiceConnectionState;
/**
* Provisioning state of the Private Endpoint Connection.
*/
"provisioningState"?: EventHubsPrivateEndpointConnectionProvisioningState;
}

/**
* PrivateEndpoint information.
*/
model PrivateEndpoint {
/**
* The ARM identifier for Private Endpoint.
*/
"id"?: string;
}

/**
* ConnectionState information.
*/
model EventHubsPrivateLinkServiceConnectionState {
/**
* Status of the connection.
*/
"status"?: EventHubsPrivateLinkConnectionStatus;
/**
* Description of the connection state.
*/
"description"?: string;
}

/**
* Result of the List private link resources operation.
*/
model PrivateLinkResourcesListResult {
/**
* A collection of private link resources
*/
"value"?: EventHubsPrivateLinkResourceData[];
/**
* A link for the next page of private link resources.
*/
"nextLink"?: string;
}

/**
* Information of the private link resource.
*/
model EventHubsPrivateLinkResourceData {
/**
* Properties of the private link resource.
*/
"properties"?: PrivateLinkResourceProperties;
/**
* Fully qualified identifier of the resource.
*/
"id"?: string;
/**
* Name of the resource
*/
"name"?: string;
/**
* Type of the resource
*/
"type"?: string;
}

/**
* Properties of PrivateLinkResource
*/
model PrivateLinkResourceProperties {
/**
* The private link resource group id.
*/
"groupId"?: string;
/**
* The private link resource required member names.
*/
"requiredMembers"?: string[];
/**
* The private link resource Private link DNS zone name.
*/
"requiredZoneNames"?: string[];
}

/**
* Result of the List NetworkSecurityPerimeterConfiguration operation.
*/
model NetworkSecurityPerimeterConfigurationList {
/**
* A collection of NetworkSecurityPerimeterConfigurations
*/
@visibility("read")
"value"?: NetworkSecurityPerimeterConfiguration[];
}

/**
* Network Security Perimeter related configurations of a given namespace
*/
model NetworkSecurityPerimeterConfiguration {
/**
* Properties of the Network Security Perimeter Configuration
*/
@visibility("read")
"properties"?: NetworkSecurityPerimeterConfigurationProperties;
}

/**
* Properties of NetworkSecurityPerimeterConfiguration
*/
model NetworkSecurityPerimeterConfigurationProperties {
/**
* Provisioning state of NetworkSecurityPerimeter configuration propagation
*/
"provisioningState"?: NetworkSecurityPerimeterConfigurationProvisioningState;
/**
* List of Provisioning Issues if any
*/
"provisioningIssues"?: ProvisioningIssue[];
/**
* NetworkSecurityPerimeter related information
*/
@visibility("read")
"networkSecurityPerimeter"?: NetworkSecurityPerimeter;
/**
* Information about resource association
*/
@visibility("read")
"resourceAssociation"?: NetworkSecurityPerimeterConfigurationPropertiesResourceAssociation;
/**
* Information about current network profile
*/
@visibility("read")
"profile"?: NetworkSecurityPerimeterConfigurationPropertiesProfile;
}

/**
* Describes Provisioning issue for given NetworkSecurityPerimeterConfiguration
*/
model ProvisioningIssue {
/**
* Name of the issue
*/
"name"?: string;
/**
* Properties of Provisioning Issue
*/
@visibility("read")
"properties"?: ProvisioningIssueProperties;
}

/**
* Properties of Provisioning Issue
*/
model ProvisioningIssueProperties {
/**
* Type of Issue
*/
"issueType"?: string;
/**
* Description of the issue
*/
"description"?: string;
}

/**
* NetworkSecurityPerimeter related information
*/
model NetworkSecurityPerimeter {
/**
* Fully qualified identifier of the resource
*/
"id"?: string;
/**
* Guid of the resource
*/
"perimeterGuid"?: string;
/**
* Location of the resource
*/
"location"?: string;
}

/**
* Information about resource association
*/
model NetworkSecurityPerimeterConfigurationPropertiesResourceAssociation {
/**
* Name of the resource association
*/
"name"?: string;
/**
* Access Mode of the resource association
*/
"accessMode"?: ResourceAssociationAccessMode;
}

/**
* Information about current network profile
*/
model NetworkSecurityPerimeterConfigurationPropertiesProfile {
/**
* Name of the resource
*/
"name"?: string;
/**
* Current access rules version
*/
"accessRulesVersion"?: string;
/**
* List of Access Rules
*/
"accessRules"?: NspAccessRule[];
}

/**
* Information of Access Rule in Network Profile
*/
model NspAccessRule {
/**
* Fully qualified identifier of the resource
*/
"id"?: string;
/**
* Name of the resource
*/
"name"?: string;
/**
* Type of the resource
*/
"type"?: string;
/**
* Properties of Access Rule
*/
@visibility("read")
"properties"?: NspAccessRuleProperties;
}

/**
* Properties of Access Rule
*/
model NspAccessRuleProperties {
/**
* Direction of Access Rule
*/
"direction"?: NspAccessRuleDirection;
/**
* Address prefixes in the CIDR format for inbound rules
*/
"addressPrefixes"?: string[];
/**
* Subscriptions for inbound rules
*/
"subscriptions"?: NspAccessRulePropertiesSubscriptionsItem[];
/**
* NetworkSecurityPerimeters for inbound rules
*/
@visibility("read")
"networkSecurityPerimeters"?: NetworkSecurityPerimeter[];
/**
* FQDN for outbound rules
*/
@visibility("read")
"fullyQualifiedDomainNames"?: string[];
}

/**
* Subscription for inbound rule
*/
model NspAccessRulePropertiesSubscriptionsItem {
/**
* Fully qualified identifier of subscription
*/
"id"?: string;
}

/**
* Contains all settings for the cluster.
*/
model ClusterQuotaConfigurationProperties {
/**
* All possible Cluster settings - a collection of key/value paired settings which apply to quotas and configurations imposed on the cluster.
*/
"settings"?: Record<string>;
}

/**
* NetworkRuleSet properties
*/
model NetworkRuleSetProperties {
/**
* Value that indicates whether Trusted Service Access is Enabled or not.
*/
"trustedServiceAccessEnabled"?: boolean;
/**
* Default Action for Network Rule Set
*/
"defaultAction"?: EventHubsNetworkRuleSetDefaultAction;
/**
* List VirtualNetwork Rules
*/
"virtualNetworkRules"?: EventHubsNetworkRuleSetVirtualNetworkRules[];
/**
* List of IpRules
*/
"ipRules"?: EventHubsNetworkRuleSetIPRules[];
/**
* This determines if traffic is allowed over public network. By default it is enabled. If value is SecuredByPerimeter then Inbound and Outbound communication is controlled by the network security perimeter and profile's access rules. 
*/
"publicNetworkAccess"?: EventHubsPublicNetworkAccessFlag = EventHubsPublicNetworkAccessFlag.Enabled;
}

/**
* The response from the List namespace operation.
*/
model EventHubsNetworkRuleSetVirtualNetworkRules {
/**
* Subnet properties
*/
"subnet"?: Subnet;
/**
* Value that indicates whether to ignore missing Vnet Service Endpoint
*/
"ignoreMissingVnetServiceEndpoint"?: boolean;
}

/**
* Properties supplied for Subnet
*/
model Subnet {
/**
* Resource ID of Virtual Network Subnet
*/
"id"?: string;
}

/**
* The response from the List namespace operation.
*/
model EventHubsNetworkRuleSetIPRules {
/**
* IP Mask
*/
"ipMask"?: string;
/**
* The IP Filter Action
*/
"action"?: EventHubsNetworkRuleIPAction;
}

/**
* Properties supplied to create or update AuthorizationRule
*/
model AuthorizationRuleProperties {
/**
* The rights associated with the rule.
*/
"rights": EventHubsAccessRight[];
}

/**
* Namespace/EventHub Connection String
*/
model EventHubsAccessKeys {
/**
* Primary connection string of the created namespace AuthorizationRule.
*/
@visibility("read")
"primaryConnectionString"?: string;
/**
* Secondary connection string of the created namespace AuthorizationRule.
*/
@visibility("read")
"secondaryConnectionString"?: string;
/**
* Primary connection string of the alias if GEO DR is enabled
*/
@visibility("read")
"aliasPrimaryConnectionString"?: string;
/**
* Secondary  connection string of the alias if GEO DR is enabled
*/
@visibility("read")
"aliasSecondaryConnectionString"?: string;
/**
* A base64-encoded 256-bit primary key for signing and validating the SAS token.
*/
@visibility("read")
"primaryKey"?: string;
/**
* A base64-encoded 256-bit primary key for signing and validating the SAS token.
*/
@visibility("read")
"secondaryKey"?: string;
/**
* A string that describes the AuthorizationRule.
*/
@visibility("read")
"keyName"?: string;
}

/**
* Parameters supplied to the Regenerate Authorization Rule operation, specifies which key needs to be reset.
*/
model EventHubsRegenerateAccessKeyContent {
/**
* The access key to regenerate.
*/
"keyType": EventHubsAccessKeyType;
/**
* Optional, if the key value provided, is set for KeyType or autogenerated Key value set for keyType
*/
"key"?: string;
}

/**
* Parameter supplied to check Namespace name availability operation 
*/
model EventHubsNameAvailabilityContent {
/**
* Name to check the namespace name availability
*/
"name": string;
}

/**
* The Result of the CheckNameAvailability operation
*/
model EventHubsNameAvailabilityResult {
/**
* The detailed info regarding the reason associated with the Namespace.
*/
@visibility("read")
"message"?: string;
/**
* Value indicating Namespace is availability, true if the Namespace is available; otherwise, false.
*/
"nameAvailable"?: boolean;
/**
* The reason for unavailability of a Namespace.
*/
"reason"?: UnavailableReason;
}

/**
* Single item in List or Get Consumer group operation
*/
model ConsumerGroupProperties {
/**
* Exact time the message was created.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"createdAt"?: utcDateTime;
/**
* The exact time the message was updated.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"updatedAt"?: utcDateTime;
/**
* User Metadata is a placeholder to store user-defined string data with maximum length 1024. e.g. it can be used to store descriptive data, such as list of teams and their contact information also user-defined configuration settings can be stored.
*/
"userMetadata"?: string;
}

/**
* Properties required to the Create Or Update Alias(Disaster Recovery configurations)
*/
model ArmDisasterRecoveryProperties {
/**
* Provisioning state of the Alias(Disaster Recovery configuration) - possible values 'Accepted' or 'Succeeded' or 'Failed'
*/
@visibility("read")
"provisioningState"?: EventHubsDisasterRecoveryProvisioningState;
/**
* ARM Id of the Primary/Secondary eventhub namespace name, which is part of GEO DR pairing
*/
"partnerNamespace"?: string;
/**
* Alternate name specified when alias and namespace names are same.
*/
"alternateName"?: string;
/**
* role of namespace in GEO DR - possible values 'Primary' or 'PrimaryNotReplicating' or 'Secondary'
*/
@visibility("read")
"role"?: EventHubsDisasterRecoveryRole;
/**
* Number of entities pending to be replicated.
*/
@visibility("read")
"pendingReplicationOperationsCount"?: int64;
}

/**
* Properties supplied to the Create Or Update Event Hub operation.
*/
model EventhubProperties {
/**
* Current number of shards on the Event Hub.
*/
@visibility("read")
"partitionIds"?: string[];
/**
* Exact time the Event Hub was created.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"createdAt"?: utcDateTime;
/**
* The exact time the message was updated.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"updatedAt"?: utcDateTime;
/**
* Number of partitions created for the Event Hub, allowed values are from 1 to 32 partitions.
*/
@minValue(1)
"partitionCount"?: int64;
/**
* Enumerates the possible values for the status of the Event Hub.
*/
"status"?: EventHubEntityStatus;
/**
* Properties of capture description
*/
"captureDescription"?: CaptureDescription;
/**
* Event Hub retention settings
*/
"retentionDescription"?: RetentionDescription;
}

/**
* Properties to configure capture description for eventhub
*/
model CaptureDescription {
/**
* A value that indicates whether capture description is enabled. 
*/
"enabled"?: boolean;
/**
* Enumerates the possible values for the encoding format of capture description. Note: 'AvroDeflate' will be deprecated in New API Version
*/
"encoding"?: EncodingCaptureDescription;
/**
* The time window allows you to set the frequency with which the capture to Azure Blobs will happen, value should between 60 to 900 seconds
*/
"intervalInSeconds"?: int32;
/**
* The size window defines the amount of data built up in your Event Hub before an capture operation, value should be between 10485760 to 524288000 bytes
*/
"sizeLimitInBytes"?: int32;
/**
* Properties of Destination where capture will be stored. (Storage Account, Blob Names)
*/
"destination"?: EventHubDestination;
/**
* A value that indicates whether to Skip Empty Archives
*/
"skipEmptyArchives"?: boolean;
}

/**
* Capture storage details for capture description
*/
model EventHubDestination {
/**
* Name for capture destination
*/
"name"?: string;
/**
* Properties describing the storage account, blob container and archive name format for capture destination
*/
"properties"?: DestinationProperties;
}

/**
* Properties describing the storage account, blob container and archive name format for capture destination
*/
model DestinationProperties {
/**
* Resource id of the storage account to be used to create the blobs
*/
"storageAccountResourceId"?: string;
/**
* Blob container Name
*/
"blobContainer"?: string;
/**
* Blob naming convention for archive, e.g. {Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}. Here all the parameters (Namespace,EventHub .. etc) are mandatory irrespective of order
*/
"archiveNameFormat"?: string;
/**
* Subscription Id of Azure Data Lake Store
*/
"dataLakeSubscriptionId"?: string;
/**
* The Azure Data Lake Store name for the captured events
*/
"dataLakeAccountName"?: string;
/**
* The destination folder path for the captured events
*/
"dataLakeFolderPath"?: string;
}

/**
* Properties to configure retention settings for the  eventhub
*/
model RetentionDescription {
/**
* Enumerates the possible values for cleanup policy
*/
"cleanupPolicy"?: CleanupPolicyRetentionDescription;
/**
* Number of hours to retain the events for this Event Hub. This value is only used when cleanupPolicy is Delete. If cleanupPolicy is Compaction the returned value of this property is Long.MaxValue 
*/
"retentionTimeInHours"?: int64;
/**
* Number of hours to retain the tombstone markers of a compacted Event Hub. This value is only used when cleanupPolicy is Compaction. Consumer must complete reading the tombstone marker within this specified amount of time if consumer begins from starting offset to ensure they get a valid snapshot for the specific key described by the tombstone marker within the compacted Event Hub
*/
"tombstoneRetentionTimeInHours"?: int32;
}


model SchemaGroupProperties {
/**
* Exact time the Schema Group was updated
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"updatedAtUtc"?: utcDateTime;
/**
* Exact time the Schema Group was created.
*/
@visibility("read")
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"createdAtUtc"?: utcDateTime;
/**
* The ETag value.
*/
@visibility("read")
"eTag"?: string;
/**
* dictionary object for SchemaGroup group properties
*/
"groupProperties"?: Record<string>;
"schemaCompatibility"?: SchemaCompatibility;
"schemaType"?: SchemaType;
}


model ApplicationGroupProperties {
/**
* Determines if Application Group is allowed to create connection with namespace or not. Once the isEnabled is set to false, all the existing connections of application group gets dropped and no new connections will be allowed
*/
"isEnabled"?: boolean;
/**
* The Unique identifier for application group.Supports SAS(SASKeyName=KeyName) or AAD(AADAppID=Guid)
*/
"clientAppGroupIdentifier": string;
/**
* List of group policies that define the behavior of application group. The policies can support resource governance scenarios such as limiting ingress or egress traffic.
*/
"policies"?: EventHubsApplicationGroupPolicy[];
}

/**
* Properties of the Application Group policy
*/
@discriminator("type")
model EventHubsApplicationGroupPolicy {
/**
* The Name of this policy
*/
"name": string;
}

/**
* Properties of the throttling policy
*/
model EventHubsThrottlingPolicy extends EventHubsApplicationGroupPolicy {
/**
* The Threshold limit above which the application group will be throttled.Rate limit is always per second.
*/
"rateLimitThreshold": int64;
/**
* Metric Id on which the throttle limit should be set, MetricId can be discovered by hovering over Metric in the Metrics section of Event Hub Namespace inside Azure Portal
*/
"metricId": MetricId;
/**
* Application Group Policy types
*/
"type": "ThrottlingPolicy";
}