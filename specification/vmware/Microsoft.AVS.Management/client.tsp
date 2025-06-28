import "./main.tsp";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.ResourceManager;
using Microsoft.AVS;
using TypeSpec.Versioning;

@client(
  {
    name: "AvsClient",
    service: Microsoft.AVS,
  },
  "csharp,java,go"
)
@client(
  {
    name: "AzureVMwareSolutionAPI",
    service: Microsoft.AVS,
  },
  "javascript"
)
@client(
  {
    name: "AVSClient",
    service: Microsoft.AVS,
  },
  "python"
)
@useDependency(Microsoft.AVS.Versions.v2024_09_01)
namespace Customization;

@@clientName(Addon, "AvsPrivateCloudAddon", "csharp");
@@clientName(AddonProperties, "AvsPrivateCloudAddonProperties", "csharp");
@@alternateType(CloudLinkProperties.linkedCloud,
  armResourceIdentifier,
  "csharp"
);
@@clientName(Cluster, "AvsPrivateCloudCluster", "csharp");
@@clientName(Datastore, "AvsPrivateCloudDatastore", "csharp");
@@alternateType(ExpressRouteAuthorizationProperties.expressRouteAuthorizationId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ExpressRouteAuthorizationProperties.expressRouteId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(GlobalReachConnectionProperties.expressRouteId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(GlobalReachConnectionProperties.peerExpressRouteCircuit,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AvailabilityProperties,
  "PrivateCloudAvailabilityProperties",
  "csharp"
);
@@clientName(Circuit, "ExpressRouteCircuit", "csharp");
@@clientName(Microsoft.AVS.Encryption, "CustomerManagedEncryption", "csharp");
@@clientName(Endpoints, "AvsPrivateCloudEndpoints", "csharp");
@@clientName(IdentitySource, "SingleSignOnIdentitySource", "csharp");
@@alternateType(IdentitySource.primaryServer, url, "csharp");
@@alternateType(IdentitySource.secondaryServer, url, "csharp");
@@clientName(InternetEnum, "InternetConnectivityState", "csharp");
@@clientName(ScriptExecutionParameter,
  "ScriptExecutionParameterDetails",
  "csharp"
);
@@clientName(PSCredentialExecutionParameter,
  "PSCredentialExecutionParameterDetails",
  "csharp"
);
@@clientName(ScriptSecureStringExecutionParameter,
  "ScriptSecureStringExecutionParameterDetails",
  "csharp"
);
@@clientName(ScriptStringExecutionParameter,
  "ScriptStringExecutionParameterDetails",
  "csharp"
);
@@alternateType(ScriptExecutionProperties.scriptCmdletId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ScriptPackageProperties.uri, url, "csharp");
@@usage(ScriptPackage, Usage.input, "csharp");
@@usage(ScriptCmdlet, Usage.input, "csharp");
@@alternateType(ScriptCmdletProperties.timeout, duration, "csharp");
@@alternateType(ScriptExecutionProperties.namedOutputs, unknown, "csharp");
@@clientName(VirtualMachine, "AvsPrivateCloudClusterVirtualMachine", "csharp");
@@usage(VirtualMachine, Usage.input, "csharp");
@@usage(WorkloadNetwork, Usage.input, "csharp");
@@alternateType(WorkloadNetworkDnsServiceProperties.dnsServiceIp,
  ipV4Address,
  "csharp"
);
@@clientName(DnsServiceLogLevelEnum, "DnsServiceLogLevel", "csharp");
@@clientName(DnsServiceLogLevelEnum.DEBUG, "Debug", "csharp");
@@clientName(DnsServiceLogLevelEnum.INFO, "Info", "csharp");
@@clientName(DnsServiceLogLevelEnum.WARNING, "Warning", "csharp");
@@clientName(DnsServiceLogLevelEnum.ERROR, "Error", "csharp");
@@clientName(DnsServiceLogLevelEnum.FATAL, "Fatal", "csharp");
@@clientName(DnsServiceStatusEnum, "DnsServiceStatus", "csharp");
@@clientName(DnsServiceStatusEnum.SUCCESS, "Success", "csharp");
@@clientName(DnsServiceStatusEnum.FAILURE, "Failure", "csharp");
@@alternateType(WorkloadNetworkDnsZoneProperties.sourceIp,
  ipV4Address,
  "csharp"
);
@@usage(WorkloadNetworkGateway, Usage.input, "csharp");
@@usage(WorkloadNetworkVirtualMachine, Usage.input, "csharp");
@@alternateType(WorkloadNetworkDnsZoneProperties.dnsServerIps,
  ipV4Address[],
  "csharp"
);
@@clientName(WorkloadNetworkPortMirroring,
  "WorkloadNetworkPortMirroringProfile",
  "csharp"
);
@@clientName(PortMirroringDirectionEnum,
  "PortMirroringProfileDirection",
  "csharp"
);
@@clientName(PortMirroringDirectionEnum.INGRESS, "Ingress", "csharp");
@@clientName(PortMirroringDirectionEnum.EGRESS, "Egress", "csharp");
@@clientName(PortMirroringDirectionEnum.BIDIRECTIONAL,
  "Bidirectional",
  "csharp"
);
@@clientName(WorkloadNetworkPortMirroringProvisioningState,
  "WorkloadNetworkPortMirroringProfileProvisioningState",
  "csharp"
);
@@clientName(PortMirroringStatusEnum, "PortMirroringProfileStatus", "csharp");
@@clientName(PortMirroringStatusEnum.SUCCESS, "Success", "csharp");
@@clientName(PortMirroringStatusEnum.FAILURE, "Failure", "csharp");
@@clientName(SegmentStatusEnum, "WorkloadNetworkSegmentStatus", "csharp");
@@clientName(SegmentStatusEnum.SUCCESS, "Success", "csharp");
@@clientName(SegmentStatusEnum.FAILURE, "Failure", "csharp");
@@clientName(VMTypeEnum, "WorkloadNetworkVmType", "csharp");
@@clientName(VMTypeEnum.REGULAR, "Regular", "csharp");
@@clientName(VMTypeEnum.EDGE, "Edge", "csharp");
@@clientName(VMTypeEnum.SERVICE, "Service", "csharp");
@@clientName(VMGroupStatusEnum, "WorkloadNetworkVmGroupStatus", "csharp");
@@clientName(VMGroupStatusEnum.SUCCESS, "Success", "csharp");
@@clientName(VMGroupStatusEnum.FAILURE, "Failure", "csharp");
@@clientName(Quota, "AvsSubscriptionQuotaAvailabilityResult", "csharp");
@@clientName(QuotaEnabled, "AvsSubscriptionQuotaEnabled", "csharp");
@@clientName(Trial, "AvsSubscriptionTrialAvailabilityResult", "csharp");
@@clientName(TrialStatus, "AvsSubscriptionTrialStatus", "csharp");
@@alternateType(Circuit.expressRouteID, armResourceIdentifier, "csharp");
@@alternateType(Circuit.expressRoutePrivatePeeringID,
  armResourceIdentifier,
  "csharp"
);
@@clientName(MountOptionEnum, "LunMountMode", "csharp");
@@clientName(MountOptionEnum.MOUNT, "Mount", "csharp");
@@clientName(MountOptionEnum.ATTACH, "Attach", "csharp");
@@clientName(SslEnum, "SslCertificateStatus", "csharp");
@@clientName(OptionalParamEnum, "ParameterOptionalityStatus", "csharp");
@@clientName(VisibilityParameterEnum, "ParameterVisibilityStatus", "csharp");
@@clientName(ClusterProvisioningState,
  "AvsPrivateCloudClusterProvisioningState",
  "csharp"
);
@@clientName(DatastoreProvisioningState,
  "AvsPrivateCloudDatastoreProvisioningState",
  "csharp"
);
@@clientName(VirtualMachineRestrictMovement,
  "AvsPrivateCloudClusterVirtualMachineRestrictMovement",
  "csharp"
);
@@clientName(PrivateClouds.rotateVcenterPassword,
  "RotateVCenterPassword",
  "csharp"
);
@@clientName(PrivateCloud, "AvsPrivateCloud", "csharp");
@@alternateType(PrivateCloudProperties.externalCloudLinks,
  armResourceIdentifier[],
  "csharp"
);
@@clientName(PrivateCloudProvisioningState,
  "AvsPrivateCloudProvisioningState",
  "csharp"
);
@@clientName(PrivateCloudProperties.vmotionNetwork, "VMotionNetwork", "csharp");
@@clientName(PrivateCloudProperties.vcenterPassword,
  "VCenterPassword",
  "csharp"
);
@@clientName(PrivateCloudProperties.vcenterCertificateThumbprint,
  "VCenterCertificateThumbprint",
  "csharp"
);
@@clientName(AdminCredentials.vcenterUsername, "VCenterUsername", "csharp");
@@clientName(AdminCredentials.vcenterPassword, "VCenterPassword", "csharp");
@@clientName(AffinityType, "AvsPlacementPolicyAffinityType", "csharp");
@@alternateType(DiskPoolVolume.targetId, armResourceIdentifier, "csharp");
@@clientName(EncryptionState, "AvsEncryptionState", "csharp");
@@clientName(EncryptionVersionType, "AvsEncryptionVersionType", "csharp");
@@clientName(ManagementCluster, "AvsManagementCluster", "csharp");
@@clientName(AffinityStrength,
  "VmHostPlacementPolicyAffinityStrength",
  "csharp"
);
@@clientName(ClusterZone, "AvsClusterZone", "csharp");
@@clientName(CloudLinkProvisioningState,
  "AvsCloudLinkProvisioningState",
  "csharp"
);
@@clientName(DnsZoneType, "AvsDnsZoneType", "csharp");
@@clientName(VirtualMachineProvisioningState,
  "AvsVirtualMachineProvisioningState",
  "csharp"
);
@@clientName(CloudLink, "AvsCloudLink", "csharp");
@@clientName(CloudLinkStatus, "AvsCloudLinkStatus", "csharp");
@@clientName(ClusterZoneList, "AvsClusterZoneListResult", "csharp");
@@clientName(Clusters.listZones, "getClusterZones", "csharp");
@@clientName(EncryptionKeyVaultProperties,
  "AvsEncryptionKeyVaultProperties",
  "csharp"
);
@@alternateType(EncryptionKeyVaultProperties.keyVaultUrl, url, "csharp");
@@clientName(EncryptionKeyStatus, "AvsEncryptionKeyStatus", "csharp");
@@alternateType(Location.name, azureLocation, "csharp");
@@clientName(Locations.checkQuotaAvailability,
  "CheckAvsQuotaAvailability",
  "csharp"
);
@@clientName(Locations.checkTrialAvailability,
  "CheckAvsTrialAvailability",
  "csharp"
);
@@clientName(Skus.list, "getAvsSkus", "csharp");
@@clientName(Microsoft.AVS.ResourceSku, "AvsResourceSku", "csharp");
@@clientName(DhcpTypeEnum.SERVER, "Server", "csharp");
@@clientName(DhcpTypeEnum.RELAY, "Relay", "csharp");
@@alternateType(PlacementPolicyUpdateProperties.vmMembers,
  armResourceIdentifier[],
  "csharp"
);
@@clientName(ScriptParameter.type, "ParameterType", "csharp");
@@alternateType(VmHostPlacementPolicyProperties.vmMembers,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(VmVmPlacementPolicyProperties.vmMembers,
  armResourceIdentifier[],
  "csharp"
);
@@clientName(Host, "AvsHost", "csharp");
@@clientName(HostProperties, "AvsHostProperties", "csharp");
@@clientName(GeneralHostProperties, "GeneralAvsHostProperties", "csharp");
@@clientName(SpecializedHostProperties,
  "SpecializedAvsHostProperties",
  "csharp"
);
@@clientName(HostMaintenance, "AvsHostMaintenance", "csharp");
@@clientName(HostProvisioningState, "AvsHostProvisioningState", "csharp");
@@clientName(ProvisionedNetworkProperties,
  "AvsProvisionedNetworkProperties",
  "csharp"
);
@@clientName(ProvisionedNetworkProvisioningState,
  "AvsProvisionedNetworkProvisioningState",
  "csharp"
);
@@clientName(ProvisionedNetworkTypes, "AvsProvisionedNetworkType", "csharp");
@@clientName(PureStoragePolicyProperties,
  "AvsPureStoragePolicyProperties",
  "csharp"
);
@@clientName(PureStoragePolicyProvisioningState,
  "AvsPureStoragePolicyProvisioningState",
  "csharp"
);
@@clientName(PureStorageVolume, "AvsPureStorageVolume", "csharp");
@@clientName(ProvisionedNetwork, "AvsProvisionedNetwork", "csharp");
@@clientName(PureStoragePolicy, "AvsPureStoragePolicy", "csharp");
@@clientName(ResourceSkuCapabilities, "AvsResourceSkuCapabilities", "csharp");
@@clientName(ResourceSkuLocationInfo, "AvsResourceSkuLocationInfo", "csharp");
@@clientName(ResourceSkuResourceType, "AvsResourceSkuResourceType", "csharp");
@@clientName(ResourceSkuRestrictionInfo,
  "AvsResourceSkuRestrictionInfo",
  "csharp"
);
@@clientName(ResourceSkuRestrictions, "AvsResourceSkuRestrictions", "csharp");
@@clientName(ResourceSkuRestrictionsReasonCode,
  "AvsResourceSkuRestrictionsReasonCode",
  "csharp"
);
@@clientName(ResourceSkuRestrictionsType,
  "AvsResourceSkuRestrictionsType",
  "csharp"
);
@@clientName(ResourceSkuZoneDetails, "AvsResourceSkuZoneDetails", "csharp");

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface WorkloadNetworks {
  list is Microsoft.AVS.WorkloadNetworks.list;
  get is Microsoft.AVS.WorkloadNetworks.get;

  listDhcp is WorkloadNetworkDhcpConfigurations.list;
  getDhcp is WorkloadNetworkDhcpConfigurations.get;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createDhcp is WorkloadNetworkDhcpConfigurations.create;
  updateDhcp is WorkloadNetworkDhcpConfigurations.update;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  deleteDhcp is WorkloadNetworkDhcpConfigurations.delete;

  listDnsServices is WorkloadNetworkDnsServices.list;
  getDnsService is WorkloadNetworkDnsServices.get;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createDnsService is WorkloadNetworkDnsServices.create;
  updateDnsService is WorkloadNetworkDnsServices.update;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  deleteDnsService is WorkloadNetworkDnsServices.delete;

  listDnsZones is WorkloadNetworkDnsZones.list;
  getDnsZone is WorkloadNetworkDnsZones.get;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createDnsZone is WorkloadNetworkDnsZones.create;
  updateDnsZone is WorkloadNetworkDnsZones.update;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  deleteDnsZone is WorkloadNetworkDnsZones.delete;

  listGateways is WorkloadNetworkGateways.list;
  getGateway is WorkloadNetworkGateways.get;

  listPortMirroring is WorkloadNetworkPortMirroringProfiles.list;
  getPortMirroring is WorkloadNetworkPortMirroringProfiles.get;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createPortMirroring is WorkloadNetworkPortMirroringProfiles.create;
  updatePortMirroring is WorkloadNetworkPortMirroringProfiles.update;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  deletePortMirroring is WorkloadNetworkPortMirroringProfiles.delete;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  @clientName("list_public_ips", "python")
  listPublicIPs is WorkloadNetworkPublicIps.list;
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  @clientName("getPublicIp", "java")
  getPublicIP is WorkloadNetworkPublicIps.get;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @clientName("createPublicIp", "java")
  createPublicIP is WorkloadNetworkPublicIps.create;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  @clientName("deletePublicIp", "java")
  deletePublicIP is WorkloadNetworkPublicIps.delete;

  listSegments is WorkloadNetworkSegments.list;
  getSegment is WorkloadNetworkSegments.get;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createSegments is WorkloadNetworkSegments.create;
  updateSegments is WorkloadNetworkSegments.update;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  deleteSegment is WorkloadNetworkSegments.deleteSegment;

  listVirtualMachines is WorkloadNetworkVirtualMachines.list;
  getVirtualMachine is WorkloadNetworkVirtualMachines.get;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  listVMGroups is WorkloadNetworkVmGroups.list;
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  getVMGroup is WorkloadNetworkVmGroups.get;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createVMGroup is WorkloadNetworkVmGroups.create;
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  updateVMGroup is WorkloadNetworkVmGroups.update;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  deleteVMGroup is WorkloadNetworkVmGroups.delete;
}

// operation group per interface

@operationGroup
interface Operations extends Microsoft.AVS.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Locations extends Microsoft.AVS.Locations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface PrivateClouds extends Microsoft.AVS.PrivateClouds {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Clusters extends Microsoft.AVS.Clusters {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Datastores extends Microsoft.AVS.Datastores {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface HcxEnterpriseSites extends Microsoft.AVS.HcxEnterpriseSites {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Authorizations extends Microsoft.AVS.Authorizations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface GlobalReachConnections extends Microsoft.AVS.GlobalReachConnections {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface CloudLinks extends Microsoft.AVS.CloudLinks {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Addons extends Microsoft.AVS.Addons {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface VirtualMachines extends Microsoft.AVS.VirtualMachines {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface PlacementPolicies extends Microsoft.AVS.PlacementPolicies {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface ScriptPackages extends Microsoft.AVS.ScriptPackages {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface ScriptCmdlets extends Microsoft.AVS.ScriptCmdlets {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface ScriptExecutions extends Microsoft.AVS.ScriptExecutions {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface IscsiPaths extends Microsoft.AVS.IscsiPaths {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Hosts extends Microsoft.AVS.Hosts {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface ProvisionedNetworks extends Microsoft.AVS.ProvisionedNetworks {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Skus extends Microsoft.AVS.Skus {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface PureStoragePolicies extends Microsoft.AVS.PureStoragePolicies {}

// model
@@clientName(VmVmPlacementPolicyProperties, "VmPlacementPolicyProperties");

@@clientName(Azure.ResourceManager.CommonTypes.SystemAssignedServiceIdentity,
  "PrivateCloudIdentity",
  "java,go,javascript"
);
@@clientName(Azure.ResourceManager.CommonTypes.SystemAssignedServiceIdentityType,
  "ResourceIdentityType",
  "java,go,javascript"
);
@@clientName(Azure.ResourceManager.CommonTypes.ResourceIdentityType,
  "SystemAssignedResourceIdentityType",
  "java,go,javascript"
);

@@clientName(WorkloadNetworkPublicIP, "WorkloadNetworkPublicIp", "java");
@@clientName(WorkloadNetworkPublicIPProvisioningState,
  "WorkloadNetworkPublicIpProvisioningState",
  "java"
);

// property
@@clientName(Circuit.expressRouteID, "expressRouteId", "java");
@@clientName(Circuit.expressRoutePrivatePeeringID,
  "expressRoutePrivatePeeringId",
  "java"
);
@@clientName(WorkloadNetworkPublicIPProperties,
  "WorkloadNetworkPublicIpProperties",
  "java"
);
@@clientName(WorkloadNetworkPublicIPProperties.publicIPBlock,
  "publicIpBlock",
  "java"
);

// parameter
@@clientName(PublicIPIdParameter.publicIPId, "publicIpId", "java");
@@clientName(WorkloadNetworkPublicIps.create::parameters.resource,
  "workloadNetworkPublicIp",
  "java"
);

@@clientName(Customization, "AvsClient", "java");

// flatten
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.TrackedResource.properties,
  "java,python"
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "java,python"
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.Foundations.ProxyResourceUpdateModel.properties,
  "java,python"
);

#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Location.properties, "java,python");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Cluster.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Datastore.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(HcxEnterpriseSite.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(ExpressRouteAuthorization.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(GlobalReachConnection.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetwork.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkSegment.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkGateway.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkPortMirroring.properties,
  "java,python,csharp"
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkVMGroup.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkVirtualMachine.properties,
  "java,python,csharp"
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkDnsService.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkDnsZone.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkPublicIP.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(CloudLink.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(VirtualMachine.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(ScriptPackage.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(ScriptCmdlet.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(ScriptExecution.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(IscsiPath.properties, "java,python,csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(PrivateCloud.properties, "csharp");

#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(PrivateCloudUpdate.properties, "java,python");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(ClusterUpdate.properties, "java,python");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(PlacementPolicyUpdate.properties, "java,python");

@@alternateType(ScriptExecutionProperties.namedOutputs,
  Record<unknown>,
  "java,go"
);
