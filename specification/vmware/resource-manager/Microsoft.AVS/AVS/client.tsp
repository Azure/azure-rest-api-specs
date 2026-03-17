import "./main.tsp";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.AVS;

@@clientName(Microsoft.AVS, "AvsClient", "csharp,java,go");
@@clientName(Microsoft.AVS, "AzureVMwareSolutionAPI", "javascript");
@@clientName(Microsoft.AVS, "AVSClient", "python");

@@clientName(Addon, "AvsPrivateCloudAddon", "csharp");
@@clientName(AddonProperties, "AvsPrivateCloudAddonProperties", "csharp");
@@alternateType(CloudLinkProperties.linkedCloud,
  armResourceIdentifier,
  "csharp"
);
@@clientName(Cluster, "AvsPrivateCloudCluster", "csharp");
@@clientName(Datastore, "AvsPrivateCloudDatastore", "csharp");
@@alternateType(NetAppVolume.id, armResourceIdentifier, "csharp");
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
@@clientName(Circuit.expressRouteID, "ExpressRouteId", "csharp");
@@clientName(Circuit.expressRoutePrivatePeeringID,
  "ExpressRoutePrivatePeeringId",
  "csharp"
);
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
@@clientName(WorkloadNetworkDnsZoneProperties.dnsServerIps,
  "DnsServerIPs",
  "csharp"
);
@@clientName(WorkloadNetworkDnsZoneProperties.sourceIp, "SourceIP", "csharp");
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
@@alternateType(PrivateCloud.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(PrivateCloudUpdate.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
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
@@clientName(PrivateCloudProperties.nsxPublicIpQuotaRaised,
  "NsxPublicIPQuotaRaised",
  "csharp"
);
@@clientName(AdminCredentials.vcenterUsername, "VCenterUsername", "csharp");
@@clientName(AdminCredentials.vcenterPassword, "VCenterPassword", "csharp");
@@clientName(AffinityType, "AvsPlacementPolicyAffinityType", "csharp");
@@alternateType(DiskPoolVolume.targetId, armResourceIdentifier, "csharp");
@@clientName(EncryptionState, "AvsEncryptionState", "csharp");
@@clientName(EncryptionVersionType, "AvsEncryptionVersionType", "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding decorator for backwards compatibility with existing spec"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ManagementCluster,
  CommonClusterProperties,
  "csharp"
);
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
@@clientName(NsxPublicIpQuotaRaisedEnum,
  "NsxPublicIPQuotaRaisedEnum",
  "csharp"
);
@@clientName(WorkloadNetworkVMGroup, "WorkloadNetworkVmGroup", "csharp");
@@clientName(WorkloadNetworkVMGroupProvisioningState,
  "WorkloadNetworkVmGroupProvisioningState",
  "csharp"
);
@@clientName(WorkloadNetworkDnsServiceProperties.dnsServiceIp,
  "DnsServiceIP",
  "csharp"
);
@@clientName(Endpoints.nsxtManagerIp, "NsxtManagerIP", "csharp");
@@clientName(Endpoints.vcenterIp, "VcenterIP", "csharp");
@@clientName(Endpoints.hcxCloudManagerIp, "HcxCloudManagerIP", "csharp");
@@clientName(ScriptParameterTypes, "ScriptParameterType", "csharp");
@@clientName(ImpactedMaintenanceResource,
  "ImpactedMaintenanceResourceDetails",
  "csharp"
);
@@clientName(ImpactedMaintenanceResourceError.actionRequired,
  "IsActionRequired",
  "csharp"
);
@@clientName(License, "AvsLicense", "csharp");
@@clientName(LicenseProperties, "AvsLicenseProperties", "csharp");
@@clientName(Label, "AvsLicenseLabel", "csharp");
@@clientName(LicenseName, "AvsLicenseName", "csharp");
@@clientName(LicenseName.VmwareFirewall, "VMwareFirewall", "csharp");
@@clientName(LicenseKind.VmwareFirewall, "VMwareFirewall", "csharp");
@@clientName(LicenseProvisioningState, "AvsLicenseProvisioningState", "csharp");
@@clientName(Maintenance, "AvsMaintenance", "csharp");
@@clientName(MaintenanceProperties, "AvsMaintenanceProperties", "csharp");
@@clientName(MaintenanceProperties.scheduledByMicrosoft,
  "IsScheduledByMicrosoft",
  "csharp"
);
@@clientName(MaintenanceCheckType, "AvsMaintenanceCheckType", "csharp");
@@clientName(MaintenanceFailedCheck, "AvsMaintenanceFailedCheck", "csharp");
@@clientName(MaintenanceManagementOperation,
  "AvsMaintenanceManagementOperation",
  "csharp"
);
@@clientName(MaintenanceProvisioningState,
  "AvsMaintenanceProvisioningState",
  "csharp"
);
@@clientName(MaintenanceReadiness, "AvsMaintenanceReadiness", "csharp");
@@clientName(MaintenanceReadiness.lastUpdated, "LastUpdatedOn", "csharp");
@@clientName(MaintenanceReadinessRefreshOperation,
  "AvsMaintenanceReadinessRefreshOperation",
  "csharp"
);
@@clientName(MaintenanceReadinessRefreshOperation.refreshedByMicrosoft,
  "IsRefreshedByMicrosoft",
  "csharp"
);
@@clientName(MaintenanceReadinessRefreshOperationStatus,
  "AvsMaintenanceReadinessRefreshOperationStatus",
  "csharp"
);
@@clientName(MaintenanceReadinessStatus,
  "AvsMaintenanceReadinessStatus",
  "csharp"
);
@@clientName(MaintenanceReschedule, "AvsMaintenanceReschedule", "csharp");
@@clientName(MaintenanceSchedule, "AvsMaintenanceSchedule", "csharp");
@@clientName(MaintenanceState, "AvsMaintenanceState", "csharp");
@@clientName(MaintenanceStateName, "AvsMaintenanceStateName", "csharp");
@@clientName(MaintenanceStatusFilter, "AvsMaintenanceStatusFilter", "csharp");
@@clientName(MaintenanceType, "AvsMaintenanceType", "csharp");
@@clientName(MaintenanceType.VCSA, "Vcsa", "csharp");
@@clientName(MaintenanceType.ESXI, "Esxi", "csharp");
@@clientName(MaintenanceType.NSXT, "Nsxt", "csharp");
@@clientName(RescheduleOperation, "AvsRescheduleOperation", "csharp");
@@clientName(RescheduleOperationConstraint,
  "AvsRescheduleOperationConstraint",
  "csharp"
);
@@clientName(ScheduleOperation, "AvsScheduleOperation", "csharp");
@@clientName(ScheduleOperationConstraint,
  "AvsScheduleOperationConstraint",
  "csharp"
);
@@clientName(SchedulingWindow, "AvsSchedulingWindow", "csharp");
@@clientName(SchedulingWindow, "AvsSchedulingWindow", "csharp");
@@clientName(VmwareFirewallLicenseProperties,
  "VMwareFirewallLicenseProperties",
  "csharp"
);

@@clientName(WorkloadNetworkPublicIps.list, "list_public_ips", "python");
@@clientName(WorkloadNetworkPublicIps.get, "getPublicIp", "java");
@@clientName(WorkloadNetworkPublicIps.create, "createPublicIp", "java");
@@clientName(WorkloadNetworkPublicIps.delete, "deletePublicIp", "java");

// model
@@clientName(VmVmPlacementPolicyProperties, "VmPlacementPolicyProperties");

@@clientName(Azure.ResourceManager.CommonTypes.SystemAssignedServiceIdentity,
  "PrivateCloudIdentity",
  "java,go,javascript,python"
);
@@clientName(Azure.ResourceManager.CommonTypes.SystemAssignedServiceIdentityType,
  "ResourceIdentityType",
  "java,go,javascript,python"
);
@@clientName(Azure.ResourceManager.CommonTypes.ResourceIdentityType,
  "SystemAssignedResourceIdentityType",
  "java,go,javascript,python"
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

// flatten
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.TrackedResource.properties,
  "java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ProxyResourceUpdateModel.properties,
  "java,python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Location.properties,
  "java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Cluster.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Datastore.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(HcxEnterpriseSite.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExpressRouteAuthorization.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GlobalReachConnection.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetwork.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetworkSegment.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetworkGateway.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetworkPortMirroring.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetworkVMGroup.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetworkVirtualMachine.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetworkDnsService.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetworkDnsZone.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkloadNetworkPublicIP.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CloudLink.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachine.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScriptPackage.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScriptCmdlet.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScriptExecution.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(IscsiPath.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateCloud.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateCloudUpdate.properties,
  "java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ClusterUpdate.properties,
  "java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PlacementPolicyUpdate.properties,
  "java,python"
);

@@alternateType(ScriptExecutionProperties.namedOutputs,
  Record<unknown>,
  "java,go"
);

// We do not wish for ServiceComponents operations to be in the SDKs.
@@scope(ServiceComponents.checkAvailability,
  "!(python,javascript,go,java,csharp)"
);
