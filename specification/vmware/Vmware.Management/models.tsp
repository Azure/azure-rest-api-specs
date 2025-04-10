import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";


using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;


namespace Microsoft.AVS;


/**
* quota enabled
*/
    union QuotaEnabled {
        string,

        /**
* is enabled
*/"Enabled": "Enabled", /**
* is disabled
*/"Disabled": "Disabled"
    }

/**
* trial status
*/
    union TrialStatus {
        string,

        /**
* is available
*/"TrialAvailable": "TrialAvailable", /**
* is used
*/"TrialUsed": "TrialUsed", /**
* is disabled
*/"TrialDisabled": "TrialDisabled"
    }

/**
* Cluster provisioning state
*/
    union ClusterProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled", /**
* is cancelled
*/"Cancelled": "Cancelled", /**
* is deleting
*/"Deleting": "Deleting", /**
* is updating
*/"Updating": "Updating"
    }

/**
* Whether internet is enabled or disabled
*/
    union InternetEnum {
        string,

        /**
* is enabled
*/"Enabled": "Enabled", /**
* is disabled
*/"Disabled": "Disabled"
    }

/**
* Whether SSL is enabled or disabled
*/
    union SslEnum {
        string,

        /**
* is enabled
*/"Enabled": "Enabled", /**
* is disabled
*/"Disabled": "Disabled"
    }

/**
* Whether the private clouds is available in a single zone or two zones
*/
    union AvailabilityStrategy {
        string,

        /**
* in single zone
*/"SingleZone": "SingleZone", /**
* in two zones
*/"DualZone": "DualZone"
    }

/**
* Whether encryption is enabled or disabled
*/
    union EncryptionState {
        string,

        /**
* is enabled
*/"Enabled": "Enabled", /**
* is disabled
*/"Disabled": "Disabled"
    }

/**
* Whether the the encryption key is connected or access denied
*/
    union EncryptionKeyStatus {
        string,

        /**
* is connected
*/"Connected": "Connected", /**
* is access denied
*/"AccessDenied": "AccessDenied"
    }

/**
* Whether the encryption version is fixed or auto-detected
*/
    union EncryptionVersionType {
        string,

        /**
* is fixed
*/"Fixed": "Fixed", /**
* is auto-detected
*/"AutoDetected": "AutoDetected"
    }

/**
* private cloud provisioning state
*/
    union PrivateCloudProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled", /**
* is cancelled
*/"Cancelled": "Cancelled", /**
* is pending
*/"Pending": "Pending", /**
* is building
*/"Building": "Building", /**
* is deleting
*/"Deleting": "Deleting", /**
* is updating
*/"Updating": "Updating"
    }

/**
* NSX public IP quota raised
*/
    union NsxPublicIpQuotaRaisedEnum {
        string,

        /**
* is enabled
*/"Enabled": "Enabled", /**
* is disabled
*/"Disabled": "Disabled"
    }

/**
* The type of DNS zone.
*/
    union DnsZoneType {
        string,

        /**
* Primary DNS zone.
*/"Public": "Public", /**
* Private DNS zone.
*/"Private": "Private"
    }

/**
* Type of managed service identity (either system assigned, or none).
*/
    union SystemAssignedServiceIdentityType {
        string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"None": "None", #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"SystemAssigned": "SystemAssigned"
    }

/**
* Addon type
*/
    union AddonType {
        string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"SRM": "SRM", #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"VR": "VR", #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"HCX": "HCX", #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"Arc": "Arc"
    }

/**
* Addon provisioning state
*/
    union AddonProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled", /**
* is cancelled
*/"Cancelled": "Cancelled", /**
* is building
*/"Building": "Building", /**
* is deleting
*/"Deleting": "Deleting", /**
* is updating
*/"Updating": "Updating"
    }

/**
* Express Route Circuit Authorization provisioning state
*/
    union ExpressRouteAuthorizationProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled", /**
* is updating
*/"Updating": "Updating"
    }

/**
* cloud link provisioning state
*/
    union CloudLinkProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled"
    }

/**
* Cloud Link status
*/
    union CloudLinkStatus {
        string,

        /**
* is active
*/"Active": "Active", /**
* is building
*/"Building": "Building", /**
* is deleting
*/"Deleting": "Deleting", /**
* is failed
*/"Failed": "Failed", /**
* is disconnected
*/"Disconnected": "Disconnected"
    }

/**
* datastore provisioning state
*/
    union DatastoreProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled", /**
* is cancelled
*/"Cancelled": "Cancelled", /**
* is pending
*/"Pending": "Pending", /**
* is creating
*/"Creating": "Creating", /**
* is updating
*/"Updating": "Updating", /**
* is deleting
*/"Deleting": "Deleting"
    }

/**
* Mode that describes whether the LUN has to be mounted as a datastore or
* attached as a LUN
*/
    union MountOptionEnum {
        string,

        /**
* is mount
*/"MOUNT": "MOUNT", /**
* is attach
*/"ATTACH": "ATTACH"
    }

/**
* datastore status
*/
    union DatastoreStatus {
        string,

        /**
* is unknown
*/"Unknown": "Unknown", /**
* is accessible
*/"Accessible": "Accessible", /**
* is inaccessible
*/"Inaccessible": "Inaccessible", /**
* is attached
*/"Attached": "Attached", /**
* is detached
*/"Detached": "Detached", /**
* is lost communication
*/"LostCommunication": "LostCommunication", /**
* is dead or error
*/"DeadOrError": "DeadOrError"
    }

/**
* Placement Policy type
*/
    union PlacementPolicyType {
        string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"VmVm": "VmVm", #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"VmHost": "VmHost"
    }

/**
* Placement Policy state
*/
    union PlacementPolicyState {
        string,

        /**
* is enabled
*/"Enabled": "Enabled", /**
* is disabled
*/"Disabled": "Disabled"
    }

/**
* Placement Policy provisioning state
*/
    union PlacementPolicyProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled", /**
* is building
*/"Building": "Building", /**
* is deleting
*/"Deleting": "Deleting", /**
* is updating
*/"Updating": "Updating"
    }

/**
* Affinity Strength
*/
    union AffinityStrength {
        string,

        /**
* is should
*/"Should": "Should", /**
* is must
*/"Must": "Must"
    }

/**
* Azure Hybrid Benefit type
*/
    union AzureHybridBenefitType {
        string,

        /**
* is SqlHost
*/"SqlHost": "SqlHost", /**
* is None
*/"None": "None"
    }

/**
* Virtual Machine provisioning state
*/
    union VirtualMachineProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled"
    }

/**
* Virtual Machine Restrict Movement state
*/
    union VirtualMachineRestrictMovementState {
        string,

        /**
* is enabled
*/"Enabled": "Enabled", /**
* is disabled
*/"Disabled": "Disabled"
    }

/**
* Global Reach Connection provisioning state
*/
    union GlobalReachConnectionProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled", /**
* is updating
*/"Updating": "Updating"
    }

/**
* Global Reach Connection status
*/
    union GlobalReachConnectionStatus {
        string,

        /**
* is connected
*/"Connected": "Connected", /**
* is connecting
*/"Connecting": "Connecting", /**
* is disconnected
*/"Disconnected": "Disconnected"
    }

/**
* HCX Enterprise Site provisioning state
*/
    union HcxEnterpriseSiteProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled"
    }

/**
* HCX Enterprise Site status
*/
    union HcxEnterpriseSiteStatus {
        string,

        /**
* is available
*/"Available": "Available", /**
* is consumed
*/"Consumed": "Consumed", /**
* is deactivated
*/"Deactivated": "Deactivated", /**
* is deleted
*/"Deleted": "Deleted"
    }

/**
* private cloud provisioning state
*/
    union IscsiPathProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled", /**
* is pending
*/"Pending": "Pending", /**
* is building
*/"Building": "Building", /**
* is deleting
*/"Deleting": "Deleting", /**
* is updating
*/"Updating": "Updating"
    }

/**
* script execution parameter type
*/
    union ScriptExecutionParameterType {
        string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"Value": "Value", #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"SecureValue": "SecureValue", #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"Credential": "Credential"
    }

/**
* Script Execution provisioning state
*/
    union ScriptExecutionProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled", /**
* is pending
*/"Pending": "Pending", /**
* is running
*/"Running": "Running", /**
* is cancelling
*/"Cancelling": "Cancelling", /**
* is cancelled
*/"Cancelled": "Cancelled", /**
* is deleting
*/"Deleting": "Deleting"
    }

/**
* Script Output Stream type
*/
    union ScriptOutputStreamType {
        string,

        /**
* is information
*/"Information": "Information", /**
* is warning
*/"Warning": "Warning", /**
* is output
*/"Output": "Output", /**
* is error
*/"Error": "Error"
    }

/**
* Script Package provisioning state
*/
    union ScriptPackageProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled"
    }

/**
* A script cmdlet provisioning state
*/
    union ScriptCmdletProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled"
    }

/**
* Specifies whether a script cmdlet is intended to be invoked only through automation or visible to customers
*/
    union ScriptCmdletAudience {
        string,

        /**
* is automation
*/"Automation": "Automation", /**
* is any
*/"Any": "Any"
    }

/**
* Script Parameter types
*/
    union ScriptParameterTypes {
        string,

        /**
* is string
*/"String": "String", /**
* is secure string
*/"SecureString": "SecureString", /**
* is credential
*/"Credential": "Credential", /**
* is int
*/"Int": "Int", /**
* is bool
*/"Bool": "Bool", /**
* is float
*/"Float": "Float"
    }

/**
* Visibility Parameter
*/
    union VisibilityParameterEnum {
        string,

        /**
* is visible
*/"Visible": "Visible", /**
* is hidden
*/"Hidden": "Hidden"
    }

/**
* Optional Param
*/
    union OptionalParamEnum {
        string,

        /**
* is optional
*/"Optional": "Optional", /**
* is required
*/"Required": "Required"
    }

/**
* base Workload Network provisioning state
*/
    union WorkloadNetworkProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled", /**
* is building
*/"Building": "Building", /**
* is deleting
*/"Deleting": "Deleting", /**
* is updating
*/"Updating": "Updating"
    }

/**
* Type of DHCP: SERVER or RELAY.
*/
    union DhcpTypeEnum {
        string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"SERVER": "SERVER", #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
"RELAY": "RELAY"
    }

/**
* Workload Network DHCP provisioning state
*/
    union WorkloadNetworkDhcpProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled", /**
* is building
*/"Building": "Building", /**
* is deleting
*/"Deleting": "Deleting", /**
* is updating
*/"Updating": "Updating"
    }

/**
* DNS service log level
*/
    union DnsServiceLogLevelEnum {
        string,

        /**
* is debug
*/"DEBUG": "DEBUG", /**
* is info
*/"INFO": "INFO", /**
* is warning
*/"WARNING": "WARNING", /**
* is error
*/"ERROR": "ERROR", /**
* is fatal
*/"FATAL": "FATAL"
    }

/**
* DNS service status
*/
    union DnsServiceStatusEnum {
        string,

        /**
* is success
*/"SUCCESS": "SUCCESS", /**
* is failure
*/"FAILURE": "FAILURE"
    }

/**
* Workload Network DNS Service provisioning state
*/
    union WorkloadNetworkDnsServiceProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled", /**
* is building
*/"Building": "Building", /**
* is deleting
*/"Deleting": "Deleting", /**
* is updating
*/"Updating": "Updating"
    }

/**
* Workload Network DNS Zone provisioning state
*/
    union WorkloadNetworkDnsZoneProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled", /**
* is building
*/"Building": "Building", /**
* is deleting
*/"Deleting": "Deleting", /**
* is updating
*/"Updating": "Updating"
    }

/**
* Port Mirroring Direction
*/
    union PortMirroringDirectionEnum {
        string,

        /**
* is ingress
*/"INGRESS": "INGRESS", /**
* is egress
*/"EGRESS": "EGRESS", /**
* is bidirectional
*/"BIDIRECTIONAL": "BIDIRECTIONAL"
    }

/**
* Port Mirroring status
*/
    union PortMirroringStatusEnum {
        string,

        /**
* is success
*/"SUCCESS": "SUCCESS", /**
* is failure
*/"FAILURE": "FAILURE"
    }

/**
* Workload Network Port Mirroring provisioning state
*/
    union WorkloadNetworkPortMirroringProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled", /**
* is building
*/"Building": "Building", /**
* is deleting
*/"Deleting": "Deleting", /**
* is updating
*/"Updating": "Updating"
    }

/**
* Workload Network Public IP provisioning state
*/
    union WorkloadNetworkPublicIPProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled", /**
* is building
*/"Building": "Building", /**
* is deleting
*/"Deleting": "Deleting", /**
* is updating
*/"Updating": "Updating"
    }

/**
* Segment status
*/
    union SegmentStatusEnum {
        string,

        /**
* is success
*/"SUCCESS": "SUCCESS", /**
* is failure
*/"FAILURE": "FAILURE"
    }

/**
* Workload Network Segment provisioning state
*/
    union WorkloadNetworkSegmentProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled", /**
* is building
*/"Building": "Building", /**
* is deleting
*/"Deleting": "Deleting", /**
* is updating
*/"Updating": "Updating"
    }

/**
* VM type
*/
    union VMTypeEnum {
        string,

        /**
* is regular
*/"REGULAR": "REGULAR", /**
* is edge
*/"EDGE": "EDGE", /**
* is service
*/"SERVICE": "SERVICE"
    }

/**
* VM group status
*/
    union VMGroupStatusEnum {
        string,

        /**
* is success
*/"SUCCESS": "SUCCESS", /**
* is failure
*/"FAILURE": "FAILURE"
    }

/**
* Workload Network VM Group provisioning state
*/
    union WorkloadNetworkVMGroupProvisioningState {
        string,

        /**
* Resource has been created.
*/"Succeeded": "Succeeded", /**
* Resource creation failed.
*/"Failed": "Failed", /**
* Resource creation was canceled.
*/"Canceled": "Canceled", /**
* is building
*/"Building": "Building", /**
* is deleting
*/"Deleting": "Deleting", /**
* is updating
*/"Updating": "Updating"
    }

/**
* Affinity type
*/
    union AffinityType {
        string,

        /**
* is affinity
*/"Affinity": "Affinity", /**
* is anti-affinity
*/"AntiAffinity": "AntiAffinity"
    }




/**
* Subscription quotas
*/
model Quota {
/**
* Remaining hosts quota by sku type
*/
@visibility(Lifecycle.Read)
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"hostsRemaining"?: Record<int32>;
/**
* Host quota is active for current subscription
*/
@visibility(Lifecycle.Read)
"quotaEnabled"?: QuotaEnabled;
}

/**
* The resource model definition representing SKU
*/
model Sku {
/**
* The name of the SKU. E.g. P3. It is typically a letter+number code
*/
"name": string;
/**
* This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.
*/
"tier"?: SkuTier;
/**
* The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code. 
*/
"size"?: string;
/**
* If the service has different generations of hardware, for the same SKU, then that can be captured here.
*/
"family"?: string;
/**
* If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.
*/
"capacity"?: int32;
}

/**
* Subscription trial availability
*/
model Trial {
/**
* Trial status
*/
@visibility(Lifecycle.Read)
"status"?: TrialStatus;
/**
* Number of trial hosts available
*/
@visibility(Lifecycle.Read)
"availableHosts"?: int32;
}

/**
* The response of a PrivateCloud list operation.
*/
model PrivateCloudList is Azure.Core.Page<PrivateCloud> {
}

/**
* The properties of a private cloud resource
*/
model PrivateCloudProperties {
/**
* The default cluster used for management
*/
"managementCluster": ManagementCluster;
/**
* Connectivity to internet is enabled or disabled
*/
"internet"?: InternetEnum;
/**
* vCenter Single Sign On Identity Sources
*/
@OpenAPI.extension("x-ms-identifiers", #[])
"identitySources"?: IdentitySource[];
/**
* Properties describing how the cloud is distributed across availability zones
*/
@visibility(Lifecycle.Read, Lifecycle.Create)
"availability"?: AvailabilityProperties;
/**
* Customer managed key encryption, can be enabled or disabled
*/
"encryption"?: Encryption;
/**
* Array of additional networks noncontiguous with networkBlock. Networks must be
* unique and non-overlapping across VNet in your subscription, on-premise, and
* this privateCloud networkBlock attribute. Make sure the CIDR format conforms to
* (A.B.C.D/X).
*/
"extendedNetworkBlocks"?: string[];
/**
* The provisioning state
*/
@visibility(Lifecycle.Read)
"provisioningState"?: PrivateCloudProvisioningState;
/**
* An ExpressRoute Circuit
*/
"circuit"?: Circuit;
/**
* The endpoints
*/
@visibility(Lifecycle.Read)
"endpoints"?: Endpoints;
/**
* The block of addresses should be unique across VNet in your subscription as
* well as on-premise. Make sure the CIDR format is conformed to (A.B.C.D/X) where
* A,B,C,D are between 0 and 255, and X is between 0 and 22
*/
"networkBlock": string;
/**
* Network used to access vCenter Server and NSX-T Manager
*/
@visibility(Lifecycle.Read)
"managementNetwork"?: string;
/**
* Used for virtual machine cold migration, cloning, and snapshot migration
*/
@visibility(Lifecycle.Read)
"provisioningNetwork"?: string;
/**
* Used for live migration of virtual machines
*/
@visibility(Lifecycle.Read)
"vmotionNetwork"?: string;
/**
* Optionally, set the vCenter admin password when the private cloud is created
*/
@secret
"vcenterPassword"?: string;
/**
* Optionally, set the NSX-T Manager password when the private cloud is created
*/
@secret
"nsxtPassword"?: string;
/**
* Thumbprint of the vCenter Server SSL certificate
*/
@visibility(Lifecycle.Read)
"vcenterCertificateThumbprint"?: string;
/**
* Thumbprint of the NSX-T Manager SSL certificate
*/
@visibility(Lifecycle.Read)
"nsxtCertificateThumbprint"?: string;
/**
* Array of cloud link IDs from other clouds that connect to this one
*/
@visibility(Lifecycle.Read)
"externalCloudLinks"?: string[];
/**
* A secondary expressRoute circuit from a separate AZ. Only present in a
* stretched private cloud
*/
"secondaryCircuit"?: Circuit;
/**
* Flag to indicate whether the private cloud has the quota for provisioned NSX
* Public IP count raised from 64 to 1024
*/
@visibility(Lifecycle.Read)
"nsxPublicIpQuotaRaised"?: NsxPublicIpQuotaRaisedEnum;
/**
* Azure resource ID of the virtual network
*/
@visibility(Lifecycle.Read, Lifecycle.Create)
"virtualNetworkId"?: Azure.Core.armResourceIdentifier<[{type: "\Microsoft.Network\vnet";}]>;
/**
* The type of DNS zone to use.
*/
"dnsZoneType"?: DnsZoneType;
}

/**
* The properties of a management cluster
*/
model ManagementCluster {
/**
* The cluster size
*/
"clusterSize"?: int32;
/**
* The state of the cluster provisioning
*/
@visibility(Lifecycle.Read)
"provisioningState"?: ClusterProvisioningState;
/**
* The identity
*/
@visibility(Lifecycle.Read)
"clusterId"?: int32;
/**
* The hosts
*/
"hosts"?: string[];
/**
* Name of the vsan datastore associated with the cluster
*/
"vsanDatastoreName"?: string;
}

/**
* vCenter Single Sign On Identity Source
*/
model IdentitySource {
/**
* The name of the identity source
*/
"name"?: string;
/**
* The domain's NetBIOS name
*/
"alias"?: string;
/**
* The domain's dns name
*/
"domain"?: string;
/**
* The base distinguished name for users
*/
"baseUserDN"?: string;
/**
* The base distinguished name for groups
*/
"baseGroupDN"?: string;
/**
* Primary server URL
*/
"primaryServer"?: string;
/**
* Secondary server URL
*/
"secondaryServer"?: string;
/**
* Protect LDAP communication using SSL certificate (LDAPS)
*/
"ssl"?: SslEnum;
/**
* The ID of an Active Directory user with a minimum of read-only access to Base
* DN for users and group
*/
"username"?: string;
/**
* The password of the Active Directory user with a minimum of read-only access to
* Base DN for users and groups.
*/
@secret
"password"?: string;
}

/**
* The properties describing private cloud availability zone distribution
*/
model AvailabilityProperties {
/**
* The availability strategy for the private cloud
*/
"strategy"?: AvailabilityStrategy;
/**
* The primary availability zone for the private cloud
*/
"zone"?: int32;
/**
* The secondary availability zone for the private cloud
*/
"secondaryZone"?: int32;
}

/**
* The properties of customer managed encryption key
*/
model Encryption {
/**
* Status of customer managed encryption key
*/
"status"?: EncryptionState;
/**
* The key vault where the encryption key is stored
*/
"keyVaultProperties"?: EncryptionKeyVaultProperties;
}

/**
* An Encryption Key
*/
model EncryptionKeyVaultProperties {
/**
* The name of the key.
*/
"keyName"?: string;
/**
* The version of the key.
*/
"keyVersion"?: string;
/**
* The auto-detected version of the key if versionType is auto-detected.
*/
@visibility(Lifecycle.Read)
"autoDetectedKeyVersion"?: string;
/**
* The URL of the vault.
*/
"keyVaultUrl"?: string;
/**
* The state of key provided
*/
@visibility(Lifecycle.Read)
"keyState"?: EncryptionKeyStatus;
/**
* Property of the key if user provided or auto detected
*/
@visibility(Lifecycle.Read)
"versionType"?: EncryptionVersionType;
}

/**
* An ExpressRoute Circuit
*/
model Circuit {
/**
* CIDR of primary subnet
*/
@visibility(Lifecycle.Read)
"primarySubnet"?: string;
/**
* CIDR of secondary subnet
*/
@visibility(Lifecycle.Read)
"secondarySubnet"?: string;
/**
* Identifier of the ExpressRoute Circuit (Microsoft Colo only)
*/
@visibility(Lifecycle.Read)
"expressRouteID"?: string;
/**
* ExpressRoute Circuit private peering identifier
*/
@visibility(Lifecycle.Read)
"expressRoutePrivatePeeringID"?: string;
}

/**
* Endpoint addresses
*/
model Endpoints {
/**
* Endpoint FQDN for the NSX-T Data Center manager
*/
@visibility(Lifecycle.Read)
"nsxtManager"?: string;
/**
* Endpoint FQDN for Virtual Center Server Appliance
*/
@visibility(Lifecycle.Read)
"vcsa"?: string;
/**
* Endpoint FQDN for the HCX Cloud Manager
*/
@visibility(Lifecycle.Read)
"hcxCloudManager"?: string;
/**
* Endpoint IP for the NSX-T Data Center manager
*/
@visibility(Lifecycle.Read)
"nsxtManagerIp"?: string;
/**
* Endpoint IP for Virtual Center Server Appliance
*/
@visibility(Lifecycle.Read)
"vcenterIp"?: string;
/**
* Endpoint IP for the HCX Cloud Manager
*/
@visibility(Lifecycle.Read)
"hcxCloudManagerIp"?: string;
}

/**
* Managed service identity (either system assigned, or none)
*/
model SystemAssignedServiceIdentity {
/**
* The service principal ID of the system assigned identity. This property will only be provided for a system assigned identity.
*/
@visibility(Lifecycle.Read)
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"principalId"?: string;
/**
* The tenant ID of the system assigned identity. This property will only be provided for a system assigned identity.
*/
@visibility(Lifecycle.Read)
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
"tenantId"?: string;
/**
* Type of managed service identity (either system assigned, or none).
*/
"type": SystemAssignedServiceIdentityType;
}

/**
* Common fields that are returned in the response for all Azure Resource Manager resources
*/
model Resource {
/**
* Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
*/
@visibility(Lifecycle.Read)
"id"?: Azure.Core.armResourceIdentifier;
/**
* The name of the resource
*/
@visibility(Lifecycle.Read)
"name"?: string;
/**
* The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
*/
@visibility(Lifecycle.Read)
"type"?: string;
/**
* Azure Resource Manager metadata containing createdBy and modifiedBy information.
*/
@visibility(Lifecycle.Read)
"systemData"?: SystemData;
}

/**
* An update to a private cloud resource
*/
model PrivateCloudUpdate {
/**
* Resource tags.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"tags"?: Record<string>;
/**
* The SKU (Stock Keeping Unit) assigned to this resource.
*/
"sku"?: Sku;
/**
* The managed service identities assigned to this resource.
*/
"identity"?: SystemAssignedServiceIdentity;
/**
* The updatable properties of a private cloud resource
*/
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
@Azure.ResourceManager.Private.conditionalClientFlatten
"properties"?: PrivateCloudUpdateProperties;
}

/**
* The properties of a private cloud resource that may be updated
*/
model PrivateCloudUpdateProperties {
/**
* The default cluster used for management
*/
"managementCluster"?: ManagementCluster;
/**
* Connectivity to internet is enabled or disabled
*/
"internet"?: InternetEnum;
/**
* vCenter Single Sign On Identity Sources
*/
@OpenAPI.extension("x-ms-identifiers", #[])
"identitySources"?: IdentitySource[];
/**
* Properties describing how the cloud is distributed across availability zones
*/
@visibility(Lifecycle.Read, Lifecycle.Create)
"availability"?: AvailabilityProperties;
/**
* Customer managed key encryption, can be enabled or disabled
*/
"encryption"?: Encryption;
/**
* Array of additional networks noncontiguous with networkBlock. Networks must be
* unique and non-overlapping across VNet in your subscription, on-premise, and
* this privateCloud networkBlock attribute. Make sure the CIDR format conforms to
* (A.B.C.D/X).
*/
"extendedNetworkBlocks"?: string[];
/**
* The type of DNS zone to use.
*/
"dnsZoneType"?: DnsZoneType;
}

/**
* The response of a Addon list operation.
*/
model AddonList is Azure.Core.Page<Addon> {
}

/**
* The properties of an addon
*/
@discriminator("addonType")
model AddonProperties {
/**
* Addon type
*/
"addonType": AddonType;
/**
* The state of the addon provisioning
*/
@visibility(Lifecycle.Read)
"provisioningState"?: AddonProvisioningState;
}

/**
* The response of a ExpressRouteAuthorization list operation.
*/
model ExpressRouteAuthorizationList is Azure.Core.Page<ExpressRouteAuthorization> {
}

/**
* The properties of an ExpressRoute Circuit Authorization resource
*/
model ExpressRouteAuthorizationProperties {
/**
* The state of the ExpressRoute Circuit Authorization provisioning
*/
@visibility(Lifecycle.Read)
"provisioningState"?: ExpressRouteAuthorizationProvisioningState;
/**
* The ID of the ExpressRoute Circuit Authorization
*/
@visibility(Lifecycle.Read)
"expressRouteAuthorizationId"?: string;
/**
* The key of the ExpressRoute Circuit Authorization
*/
@visibility(Lifecycle.Read)
"expressRouteAuthorizationKey"?: string;
/**
* The ID of the ExpressRoute Circuit
*/
"expressRouteId"?: string;
}

/**
* The response of a CloudLink list operation.
*/
model CloudLinkList is Azure.Core.Page<CloudLink> {
}

/**
* The properties of a cloud link.
*/
model CloudLinkProperties {
/**
* The provisioning state of the resource.
*/
@visibility(Lifecycle.Read)
"provisioningState"?: CloudLinkProvisioningState;
/**
* The state of the cloud link.
*/
@visibility(Lifecycle.Read)
"status"?: CloudLinkStatus;
/**
* Identifier of the other private cloud participating in the link.
*/
"linkedCloud"?: string;
}

/**
* The response of a Cluster list operation.
*/
model ClusterList is Azure.Core.Page<Cluster> {
}

/**
* The properties of a cluster
*/
model ClusterProperties {
/**
* The cluster size
*/
"clusterSize"?: int32;
/**
* The state of the cluster provisioning
*/
@visibility(Lifecycle.Read)
"provisioningState"?: ClusterProvisioningState;
/**
* The identity
*/
@visibility(Lifecycle.Read)
"clusterId"?: int32;
/**
* The hosts
*/
"hosts"?: string[];
/**
* Name of the vsan datastore associated with the cluster
*/
"vsanDatastoreName"?: string;
}

/**
* An update of a cluster resource
*/
model ClusterUpdate {
/**
* The SKU (Stock Keeping Unit) assigned to this resource.
*/
"sku"?: Sku;
/**
* The properties of a cluster resource that may be updated
*/
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
@Azure.ResourceManager.Private.conditionalClientFlatten
"properties"?: ClusterUpdateProperties;
}

/**
* The properties of a cluster that may be updated
*/
model ClusterUpdateProperties {
/**
* The cluster size
*/
"clusterSize"?: int32;
/**
* The hosts
*/
"hosts"?: string[];
}

/**
* The response of a Datastore list operation.
*/
model DatastoreList is Azure.Core.Page<Datastore> {
}

/**
* The properties of a datastore
*/
model DatastoreProperties {
/**
* The state of the datastore provisioning
*/
@visibility(Lifecycle.Read)
"provisioningState"?: DatastoreProvisioningState;
/**
* An Azure NetApp Files volume
*/
"netAppVolume"?: NetAppVolume;
/**
* An iSCSI volume
*/
"diskPoolVolume"?: DiskPoolVolume;
/**
* An Elastic SAN volume
*/
"elasticSanVolume"?: ElasticSanVolume;
/**
* The operational status of the datastore
*/
@visibility(Lifecycle.Read)
"status"?: DatastoreStatus;
}

/**
* An Azure NetApp Files volume from Microsoft.NetApp provider
*/
model NetAppVolume {
/**
* Azure resource ID of the NetApp volume
*/
"id": string;
}

/**
* An iSCSI volume from Microsoft.StoragePool provider
*/
model DiskPoolVolume {
/**
* Azure resource ID of the iSCSI target
*/
"targetId": string;
/**
* Name of the LUN to be used for datastore
*/
"lunName": string;
/**
* Mode that describes whether the LUN has to be mounted as a datastore or
* attached as a LUN
*/
"mountOption"?: MountOptionEnum = MountOptionEnum.`MOUNT`;
/**
* Device path
*/
@visibility(Lifecycle.Read)
"path"?: string;
}

/**
* An Elastic SAN volume from Microsoft.ElasticSan provider
*/
model ElasticSanVolume {
/**
* Azure resource ID of the Elastic SAN Volume
*/
"targetId": Azure.Core.armResourceIdentifier<[{type: "Microsoft.ElasticSan/elasticSans/volumeGroups/volumes";}]>;
}

/**
* List of all zones and associated hosts for a cluster
*/
model ClusterZoneList {
/**
* Zone and associated hosts info
*/
@OpenAPI.extension("x-ms-identifiers", #[])
"zones"?: ClusterZone[];
}

/**
* Zone and associated hosts info
*/
model ClusterZone {
/**
* List of hosts belonging to the availability zone in a cluster
*/
@visibility(Lifecycle.Read)
"hosts"?: string[];
/**
* Availability zone identifier
*/
@visibility(Lifecycle.Read)
"zone"?: string;
}

/**
* The response of a PlacementPolicy list operation.
*/
model PlacementPoliciesList is Azure.Core.Page<PlacementPolicy> {
}

/**
* Abstract placement policy properties
*/
@discriminator("type")
model PlacementPolicyProperties {
/**
* Placement Policy type
*/
"type": PlacementPolicyType;
/**
* Whether the placement policy is enabled or disabled
*/
"state"?: PlacementPolicyState;
/**
* Display name of the placement policy
*/
"displayName"?: string;
/**
* The provisioning state
*/
@visibility(Lifecycle.Read)
"provisioningState"?: PlacementPolicyProvisioningState;
}

/**
* An update of a DRS placement policy resource
*/
model PlacementPolicyUpdate {
/**
* The properties of a placement policy resource that may be updated
*/
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
@Azure.ResourceManager.Private.conditionalClientFlatten
"properties"?: PlacementPolicyUpdateProperties;
}

/**
* The properties of a placement policy resource that may be updated
*/
model PlacementPolicyUpdateProperties {
/**
* Whether the placement policy is enabled or disabled
*/
"state"?: PlacementPolicyState;
/**
* Virtual machine members list
*/
"vmMembers"?: string[];
/**
* Host members list
*/
"hostMembers"?: string[];
/**
* vm-host placement policy affinity strength (should/must)
*/
"affinityStrength"?: AffinityStrength;
/**
* placement policy azure hybrid benefit opt-in type
*/
"azureHybridBenefitType"?: AzureHybridBenefitType;
}

/**
* The response of a VirtualMachine list operation.
*/
model VirtualMachinesList is Azure.Core.Page<VirtualMachine> {
}

/**
* Virtual Machine Properties
*/
model VirtualMachineProperties {
/**
* The provisioning state of the resource.
*/
@visibility(Lifecycle.Read)
"provisioningState"?: VirtualMachineProvisioningState;
/**
* Display name of the VM.
*/
@visibility(Lifecycle.Read)
"displayName"?: string;
/**
* Virtual machine managed object reference id
*/
@visibility(Lifecycle.Read)
"moRefId"?: string;
/**
* Path to virtual machine's folder starting from datacenter virtual machine folder
*/
@visibility(Lifecycle.Read)
"folderPath"?: string;
/**
* Whether VM DRS-driven movement is restricted (enabled) or not (disabled)
*/
@visibility(Lifecycle.Read)
"restrictMovement"?: VirtualMachineRestrictMovementState;
}

/**
* Set VM DRS-driven movement to restricted (enabled) or not (disabled)
*/
model VirtualMachineRestrictMovement {
/**
* Whether VM DRS-driven movement is restricted (enabled) or not (disabled)
*/
"restrictMovement"?: VirtualMachineRestrictMovementState;
}

/**
* The response of a GlobalReachConnection list operation.
*/
model GlobalReachConnectionList is Azure.Core.Page<GlobalReachConnection> {
}

/**
* The properties of a global reach connection
*/
model GlobalReachConnectionProperties {
/**
* The state of the  ExpressRoute Circuit Authorization provisioning
*/
@visibility(Lifecycle.Read)
"provisioningState"?: GlobalReachConnectionProvisioningState;
/**
* The network used for global reach carved out from the original network block
* provided for the private cloud
*/
@visibility(Lifecycle.Read)
"addressPrefix"?: string;
/**
* Authorization key from the peer express route used for the global reach
* connection
*/
"authorizationKey"?: string;
/**
* The connection status of the global reach connection
*/
@visibility(Lifecycle.Read)
"circuitConnectionStatus"?: GlobalReachConnectionStatus;
/**
* Identifier of the ExpressRoute Circuit to peer with in the global reach
* connection
*/
"peerExpressRouteCircuit"?: string;
/**
* The ID of the Private Cloud's ExpressRoute Circuit that is participating in the
* global reach connection
*/
"expressRouteId"?: string;
}

/**
* The response of a HcxEnterpriseSite list operation.
*/
model HcxEnterpriseSiteList is Azure.Core.Page<HcxEnterpriseSite> {
}

/**
* The properties of an HCX Enterprise Site
*/
model HcxEnterpriseSiteProperties {
/**
* The provisioning state of the resource.
*/
@visibility(Lifecycle.Read)
"provisioningState"?: HcxEnterpriseSiteProvisioningState;
/**
* The activation key
*/
@visibility(Lifecycle.Read)
"activationKey"?: string;
/**
* The status of the HCX Enterprise Site
*/
@visibility(Lifecycle.Read)
"status"?: HcxEnterpriseSiteStatus;
}

/**
* The properties of an iSCSI path resource
*/
model IscsiPathProperties {
/**
* The state of the iSCSI path provisioning
*/
@visibility(Lifecycle.Read)
"provisioningState"?: IscsiPathProvisioningState;
/**
* CIDR Block for iSCSI path.
*/
@visibility(Lifecycle.Read, Lifecycle.Create)
"networkBlock": string;
}

/**
* Administrative credentials for accessing vCenter and NSX-T
*/
model AdminCredentials {
/**
* NSX-T Manager username
*/
@visibility(Lifecycle.Read)
"nsxtUsername"?: string;
/**
* NSX-T Manager password
*/
@visibility(Lifecycle.Read)
@secret
"nsxtPassword"?: string;
/**
* vCenter admin username
*/
@visibility(Lifecycle.Read)
"vcenterUsername"?: string;
/**
* vCenter admin password
*/
@visibility(Lifecycle.Read)
@secret
"vcenterPassword"?: string;
}

/**
* The response of a ScriptExecution list operation.
*/
model ScriptExecutionsList is Azure.Core.Page<ScriptExecution> {
}

/**
* Properties of a user-invoked script
*/
model ScriptExecutionProperties {
/**
* A reference to the script cmdlet resource if user is running a AVS script
*/
"scriptCmdletId"?: string;
/**
* Parameters the script will accept
*/
@OpenAPI.extension("x-ms-identifiers", #[])
"parameters"?: ScriptExecutionParameter[];
/**
* Parameters that will be hidden/not visible to ARM, such as passwords and
* credentials
*/
@OpenAPI.extension("x-ms-identifiers", #[])
"hiddenParameters"?: ScriptExecutionParameter[];
/**
* Error message if the script was able to run, but if the script itself had
* errors or powershell threw an exception
*/
"failureReason"?: string;
/**
* Time limit for execution
*/
"timeout": string;
/**
* Time to live for the resource. If not provided, will be available for 60 days
*/
"retention"?: string;
/**
* Time the script execution was submitted
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"submittedAt"?: utcDateTime;
/**
* Time the script execution was started
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"startedAt"?: utcDateTime;
/**
* Time the script execution was finished
*/
@visibility(Lifecycle.Read)
// FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
"finishedAt"?: utcDateTime;
/**
* The state of the script execution resource
*/
@visibility(Lifecycle.Read)
"provisioningState"?: ScriptExecutionProvisioningState;
/**
* Standard output stream from the powershell execution
*/
"output"?: string[];
/**
* User-defined dictionary.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
"namedOutputs"?: Record<Record<unknown>>;
/**
* Standard information out stream from the powershell execution
*/
@visibility(Lifecycle.Read)
"information"?: string[];
/**
* Standard warning out stream from the powershell execution
*/
@visibility(Lifecycle.Read)
"warnings"?: string[];
/**
* Standard error output stream from the powershell execution
*/
@visibility(Lifecycle.Read)
"errors"?: string[];
}

/**
* The arguments passed in to the execution
*/
@discriminator("type")
model ScriptExecutionParameter {
/**
* script execution parameter type
*/
"type": ScriptExecutionParameterType;
/**
* The parameter name
*/
"name": string;
}

/**
* The response of a ScriptPackage list operation.
*/
model ScriptPackagesList is Azure.Core.Page<ScriptPackage> {
}

/**
* Properties of a Script Package subresource
*/
model ScriptPackageProperties {
/**
* The provisioning state of the resource.
*/
@visibility(Lifecycle.Read)
"provisioningState"?: ScriptPackageProvisioningState;
/**
* User friendly description of the package
*/
@visibility(Lifecycle.Read)
"description"?: string;
/**
* Module version
*/
@visibility(Lifecycle.Read)
"version"?: string;
/**
* Company that created and supports the package
*/
@visibility(Lifecycle.Read)
"company"?: string;
/**
* Link to support by the package vendor
*/
@visibility(Lifecycle.Read)
"uri"?: string;
}

/**
* The response of a ScriptCmdlet list operation.
*/
model ScriptCmdletsList is Azure.Core.Page<ScriptCmdlet> {
}

/**
* Properties of a pre-canned script
*/
model ScriptCmdletProperties {
/**
* The provisioning state of the resource.
*/
@visibility(Lifecycle.Read)
"provisioningState"?: ScriptCmdletProvisioningState;
/**
* Description of the scripts functionality
*/
@visibility(Lifecycle.Read)
"description"?: string;
/**
* Recommended time limit for execution
*/
@visibility(Lifecycle.Read)
"timeout"?: string;
/**
* Specifies whether a script cmdlet is intended to be invoked only through automation or visible to customers
*/
@visibility(Lifecycle.Read)
"audience"?: ScriptCmdletAudience;
/**
* Parameters the script will accept
*/
@visibility(Lifecycle.Read)
@OpenAPI.extension("x-ms-identifiers", #[])
"parameters"?: ScriptParameter[];
}

/**
* An parameter that the script will accept
*/
model ScriptParameter {
/**
* The type of parameter the script is expecting. psCredential is a
* PSCredentialObject
*/
@visibility(Lifecycle.Read)
"type"?: ScriptParameterTypes;
/**
* The parameter name that the script will expect a parameter value for
*/
"name"?: string;
/**
* User friendly description of the parameter
*/
@visibility(Lifecycle.Read)
"description"?: string;
/**
* Should this parameter be visible to arm and passed in the parameters argument
* when executing
*/
@visibility(Lifecycle.Read)
"visibility"?: VisibilityParameterEnum;
/**
* Is this parameter required or optional
*/
@visibility(Lifecycle.Read)
"optional"?: OptionalParamEnum;
}

/**
* The response of a WorkloadNetwork list operation.
*/
model WorkloadNetworkList is Azure.Core.Page<WorkloadNetwork> {
}

/**
* The properties of a workload network
*/
model WorkloadNetworkProperties {
/**
* The provisioning state of the resource.
*/
@visibility(Lifecycle.Read)
"provisioningState"?: WorkloadNetworkProvisioningState;
}

/**
* The response of a WorkloadNetworkDhcp list operation.
*/
model WorkloadNetworkDhcpList is Azure.Core.Page<WorkloadNetworkDhcp> {
}

/**
* Base class for WorkloadNetworkDhcpServer and WorkloadNetworkDhcpRelay to
* inherit from
*/
@discriminator("dhcpType")
model WorkloadNetworkDhcpEntity {
/**
* Type of DHCP: SERVER or RELAY.
*/
"dhcpType": DhcpTypeEnum;
/**
* Display name of the DHCP entity.
*/
"displayName"?: string;
/**
* NSX Segments consuming DHCP.
*/
@visibility(Lifecycle.Read)
"segments"?: string[];
/**
* The provisioning state
*/
@visibility(Lifecycle.Read)
"provisioningState"?: WorkloadNetworkDhcpProvisioningState;
/**
* NSX revision number.
*/
"revision"?: int64;
}

/**
* The response of a WorkloadNetworkDnsService list operation.
*/
model WorkloadNetworkDnsServicesList is Azure.Core.Page<WorkloadNetworkDnsService> {
}

/**
* NSX DNS Service Properties
*/
model WorkloadNetworkDnsServiceProperties {
/**
* Display name of the DNS Service.
*/
"displayName"?: string;
/**
* DNS service IP of the DNS Service.
*/
"dnsServiceIp"?: string;
/**
* Default DNS zone of the DNS Service.
*/
"defaultDnsZone"?: string;
/**
* FQDN zones of the DNS Service.
*/
"fqdnZones"?: string[];
/**
* DNS Service log level.
*/
"logLevel"?: DnsServiceLogLevelEnum;
/**
* DNS Service status.
*/
@visibility(Lifecycle.Read)
"status"?: DnsServiceStatusEnum;
/**
* The provisioning state
*/
@visibility(Lifecycle.Read)
"provisioningState"?: WorkloadNetworkDnsServiceProvisioningState;
/**
* NSX revision number.
*/
"revision"?: int64;
}

/**
* The response of a WorkloadNetworkDnsZone list operation.
*/
model WorkloadNetworkDnsZonesList is Azure.Core.Page<WorkloadNetworkDnsZone> {
}

/**
* NSX DNS Zone Properties
*/
model WorkloadNetworkDnsZoneProperties {
/**
* Display name of the DNS Zone.
*/
"displayName"?: string;
/**
* Domain names of the DNS Zone.
*/
"domain"?: string[];
/**
* DNS Server IP array of the DNS Zone.
*/
"dnsServerIps"?: string[];
/**
* Source IP of the DNS Zone.
*/
"sourceIp"?: string;
/**
* Number of DNS Services using the DNS zone.
*/
"dnsServices"?: int64;
/**
* The provisioning state
*/
@visibility(Lifecycle.Read)
"provisioningState"?: WorkloadNetworkDnsZoneProvisioningState;
/**
* NSX revision number.
*/
"revision"?: int64;
}

/**
* The response of a WorkloadNetworkGateway list operation.
*/
model WorkloadNetworkGatewayList is Azure.Core.Page<WorkloadNetworkGateway> {
}

/**
* Properties of a NSX Gateway.
*/
model WorkloadNetworkGatewayProperties {
/**
* The provisioning state of the resource.
*/
@visibility(Lifecycle.Read)
"provisioningState"?: WorkloadNetworkProvisioningState;
/**
* Display name of the DHCP entity.
*/
"displayName"?: string;
/**
* NSX Gateway Path.
*/
@visibility(Lifecycle.Read)
"path"?: string;
}

/**
* The response of a WorkloadNetworkPortMirroring list operation.
*/
model WorkloadNetworkPortMirroringList is Azure.Core.Page<WorkloadNetworkPortMirroring> {
}

/**
* NSX Port Mirroring Properties
*/
model WorkloadNetworkPortMirroringProperties {
/**
* Display name of the port mirroring profile.
*/
"displayName"?: string;
/**
* Direction of port mirroring profile.
*/
"direction"?: PortMirroringDirectionEnum;
/**
* Source VM Group.
*/
"source"?: string;
/**
* Destination VM Group.
*/
"destination"?: string;
/**
* Port Mirroring Status.
*/
@visibility(Lifecycle.Read)
"status"?: PortMirroringStatusEnum;
/**
* The provisioning state
*/
@visibility(Lifecycle.Read)
"provisioningState"?: WorkloadNetworkPortMirroringProvisioningState;
/**
* NSX revision number.
*/
"revision"?: int64;
}

/**
* The response of a WorkloadNetworkPublicIP list operation.
*/
model WorkloadNetworkPublicIPsList is Azure.Core.Page<WorkloadNetworkPublicIP> {
}

/**
* NSX Public IP Block Properties
*/
model WorkloadNetworkPublicIPProperties {
/**
* Display name of the Public IP Block.
*/
"displayName"?: string;
/**
* Number of Public IPs requested.
*/
"numberOfPublicIPs"?: int64;
/**
* CIDR Block of the Public IP Block.
*/
@visibility(Lifecycle.Read)
"publicIPBlock"?: string;
/**
* The provisioning state
*/
@visibility(Lifecycle.Read)
"provisioningState"?: WorkloadNetworkPublicIPProvisioningState;
}

/**
* The response of a WorkloadNetworkSegment list operation.
*/
model WorkloadNetworkSegmentsList is Azure.Core.Page<WorkloadNetworkSegment> {
}

/**
* NSX Segment Properties
*/
model WorkloadNetworkSegmentProperties {
/**
* Display name of the segment.
*/
"displayName"?: string;
/**
* Gateway which to connect segment to.
*/
"connectedGateway"?: string;
/**
* Subnet which to connect segment to.
*/
"subnet"?: WorkloadNetworkSegmentSubnet;
/**
* Port Vif which segment is associated with.
*/
@visibility(Lifecycle.Read)
@OpenAPI.extension("x-ms-identifiers", #[])
"portVif"?: WorkloadNetworkSegmentPortVif[];
/**
* Segment status.
*/
@visibility(Lifecycle.Read)
"status"?: SegmentStatusEnum;
/**
* The provisioning state
*/
@visibility(Lifecycle.Read)
"provisioningState"?: WorkloadNetworkSegmentProvisioningState;
/**
* NSX revision number.
*/
"revision"?: int64;
}

/**
* Subnet configuration for segment
*/
model WorkloadNetworkSegmentSubnet {
/**
* DHCP Range assigned for subnet.
*/
"dhcpRanges"?: string[];
/**
* Gateway address.
*/
"gatewayAddress"?: string;
}

/**
* Ports and any VIF attached to segment.
*/
model WorkloadNetworkSegmentPortVif {
/**
* Name of port or VIF attached to segment.
*/
"portName"?: string;
}

/**
* The response of a WorkloadNetworkVirtualMachine list operation.
*/
model WorkloadNetworkVirtualMachinesList is Azure.Core.Page<WorkloadNetworkVirtualMachine> {
}

/**
* NSX Virtual Machine Properties
*/
model WorkloadNetworkVirtualMachineProperties {
/**
* The provisioning state of the resource.
*/
@visibility(Lifecycle.Read)
"provisioningState"?: WorkloadNetworkProvisioningState;
/**
* Display name of the VM.
*/
"displayName"?: string;
/**
* Virtual machine type.
*/
@visibility(Lifecycle.Read)
"vmType"?: VMTypeEnum;
}

/**
* The response of a WorkloadNetworkVMGroup list operation.
*/
model WorkloadNetworkVMGroupsList is Azure.Core.Page<WorkloadNetworkVMGroup> {
}

/**
* NSX VM Group Properties
*/
model WorkloadNetworkVMGroupProperties {
/**
* Display name of the VM group.
*/
"displayName"?: string;
/**
* Virtual machine members of this group.
*/
"members"?: string[];
/**
* VM Group status.
*/
@visibility(Lifecycle.Read)
"status"?: VMGroupStatusEnum;
/**
* The provisioning state
*/
@visibility(Lifecycle.Read)
"provisioningState"?: WorkloadNetworkVMGroupProvisioningState;
/**
* NSX revision number.
*/
"revision"?: int64;
}

/**
* The properties of an Arc addon
*/
model AddonArcProperties extends AddonProperties {
/**
* The VMware vCenter resource ID
*/
"vCenter"?: string;
/**
* Addon type
*/
"addonType": "Arc";
}

/**
* The properties of an HCX addon
*/
model AddonHcxProperties extends AddonProperties {
/**
* The HCX offer, example VMware MaaS Cloud Provider (Enterprise)
*/
"offer": string;
/**
* Addon type
*/
"addonType": "HCX";
}

/**
* The properties of a Site Recovery Manager (SRM) addon
*/
model AddonSrmProperties extends AddonProperties {
/**
* The Site Recovery Manager (SRM) license
*/
"licenseKey"?: string;
/**
* Addon type
*/
"addonType": "SRM";
}

/**
* The properties of a vSphere Replication (VR) addon
*/
model AddonVrProperties extends AddonProperties {
/**
* The vSphere Replication Server (VRS) count
*/
"vrsCount": int32;
/**
* Addon type
*/
"addonType": "VR";
}

/**
* a powershell credential object
*/
model PSCredentialExecutionParameter extends ScriptExecutionParameter {
/**
* username for login
*/
"username"?: string;
/**
* password for login
*/
@secret
"password"?: string;
/**
* script execution parameter type
*/
"type": "Credential";
}

/**
* a plain text value execution parameter
*/
model ScriptSecureStringExecutionParameter extends ScriptExecutionParameter {
/**
* A secure value for the passed parameter, not to be stored in logs
*/
@secret
"secureValue"?: string;
/**
* script execution parameter type
*/
"type": "SecureValue";
}

/**
* a plain text value execution parameter
*/
model ScriptStringExecutionParameter extends ScriptExecutionParameter {
/**
* The value for the passed parameter
*/
"value"?: string;
/**
* script execution parameter type
*/
"type": "Value";
}

/**
* VM-Host placement policy properties
*/
model VmHostPlacementPolicyProperties extends PlacementPolicyProperties {
/**
* Virtual machine members list
*/
"vmMembers": string[];
/**
* Host members list
*/
"hostMembers": string[];
/**
* placement policy affinity type
*/
"affinityType": AffinityType;
/**
* vm-host placement policy affinity strength (should/must)
*/
"affinityStrength"?: AffinityStrength;
/**
* placement policy azure hybrid benefit opt-in type
*/
"azureHybridBenefitType"?: AzureHybridBenefitType;
/**
* Placement Policy type
*/
"type": "VmHost";
}

/**
* VM-VM placement policy properties
*/
model VmVmPlacementPolicyProperties extends PlacementPolicyProperties {
/**
* Virtual machine members list
*/
"vmMembers": string[];
/**
* placement policy affinity type
*/
"affinityType": AffinityType;
/**
* Placement Policy type
*/
"type": "VmVm";
}

/**
* NSX DHCP Relay
*/
model WorkloadNetworkDhcpRelay extends WorkloadNetworkDhcpEntity {
/**
* DHCP Relay Addresses. Max 3.
*/
"serverAddresses"?: string[];
/**
* Type of DHCP: SERVER or RELAY.
*/
"dhcpType": "RELAY";
}

/**
* NSX DHCP Server
*/
model WorkloadNetworkDhcpServer extends WorkloadNetworkDhcpEntity {
/**
* DHCP Server Address.
*/
"serverAddress"?: string;
/**
* DHCP Server Lease Time.
*/
"leaseTime"?: int64;
/**
* Type of DHCP: SERVER or RELAY.
*/
"dhcpType": "SERVER";
}