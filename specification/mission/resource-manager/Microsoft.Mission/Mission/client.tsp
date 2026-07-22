import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Mission;

@@clientName(ApprovalResource, "VirtualEnclaveApproval", "csharp");
@@clientName(ApprovalProperties, "VirtualEnclaveApprovalProperties", "csharp");
@@clientName(CommunityEndpointResource, "VirtualEnclaveCommunityEndpoint", "csharp");
@@clientName(
  CommunityEndpointProperties,
  "VirtualEnclaveCommunityEndpointProperties",
  "csharp"
);
@@clientName(CommunityResource, "VirtualEnclaveCommunity", "csharp");
@@clientName(CommunityProperties, "VirtualEnclaveCommunityProperties", "csharp");
@@clientName(EnclaveConnectionResource, "VirtualEnclaveConnection", "csharp");
@@clientName(
  EnclaveConnectionProperties,
  "VirtualEnclaveConnectionProperties",
  "csharp"
);
@@clientName(EnclaveEndpointResource, "VirtualEnclaveEndpoint", "csharp");
@@clientName(EnclaveEndpointProperties, "VirtualEnclaveEndpointProperties", "csharp");
@@clientName(EnclaveResource, "VirtualEnclave", "csharp");
@@clientName(TransitHubResource, "VirtualEnclaveTransitHub", "csharp");
@@clientName(TransitHubResource, "VirtualEnclaveTransitHub", "csharp");
@@clientName(TransitHubProperties, "VirtualEnclaveTransitHubProperties", "csharp");
@@clientName(WorkloadResource, "VirtualEnclaveWorkload", "csharp");
@@clientName(WorkloadProperties, "VirtualEnclaveWorkloadProperties", "csharp");
@@clientName(TransitHubProperties, "VirtualEnclaveTransitHubProperties", "csharp");
@@clientName(ApprovalActionResponse, "ApprovalActionResult", "csharp");
@@clientName(ApprovalCallbackRequest, "ApprovalCallbackContent", "csharp");
@@clientName(
  ApprovalDeletionCallbackRequest,
  "ApprovalDeletionCallbackContent",
  "csharp"
);
@@clientName(
  ApprovalPatchProperties,
  "VirtualEnclaveApprovalPatchProperties",
  "csharp"
);
@@clientName(Approver, "VirtualEnclaveApprover", "csharp");
@@clientName(ApprovalPolicy, "VirtualEnclaveApprovalPolicy", "csharp");
@@clientName(ApprovalSettings, "VirtualEnclaveBaseApprovalSettings", "csharp");
@@clientName(LegacyApprovalSettings, "VirtualEnclaveLegacyApprovalSettings", "csharp");
@@clientName(ApprovalStatus, "VirtualEnclaveApprovalStatus", "csharp");
@@clientName(
  CheckAddressSpaceAvailabilityResponse,
  "CheckAddressSpaceAvailabilityResult",
  "csharp"
);
@@clientName(
  CheckAddressSpaceAvailabilityResponse.value,
  "IsAvailable",
  "csharp"
);
@@clientName(
  DestinationType,
  "VirtualEnclaveCommunityEndpointDestinationType",
  "csharp"
);
@@clientName(CommunityEndpointProtocol.ANY, "Any", "csharp");
@@clientName(CommunityEndpointProtocol.TCP, "Tcp", "csharp");
@@clientName(CommunityEndpointProtocol.UDP, "Udp", "csharp");
@@clientName(CommunityEndpointProtocol.ICMP, "Icmp", "csharp");
@@clientName(CommunityEndpointProtocol.ESP, "Esp", "csharp");
@@clientName(CommunityEndpointProtocol.HTTPS, "Https", "csharp");
@@clientName(CommunityEndpointProtocol.HTTP, "Http", "csharp");
@@clientName(EnclaveEndpointProtocol.ANY, "Any", "csharp");
@@clientName(EnclaveEndpointProtocol.TCP, "Tcp", "csharp");
@@clientName(EnclaveEndpointProtocol.UDP, "Udp", "csharp");
@@clientName(EnclaveEndpointProtocol.ICMP, "Icmp", "csharp");
@@clientName(EnclaveEndpointProtocol.ESP, "Esp", "csharp");
@@clientName(DestinationType.FQDN, "Fqdn", "csharp");
@@clientName(DestinationType.FQDNTag, "FqdnTag", "csharp");
@@clientName(CommunityPatchModel, "VirtualEnclaveCommunityPatch", "csharp");
@@clientName(
  CommunityPatchProperties,
  "VirtualEnclaveCommunityPatchProperties",
  "csharp"
);
@@clientName(DiagnosticDestination, "VirtualEnclaveDiagnosticDestination", "csharp");
@@clientName(FirewallSKU, "VirtualEnclaveFirewallSku", "csharp");
@@clientName(GovernedServiceItem, "VirtualEnclaveGovernedService", "csharp");
@@clientName(ServiceIdentifier, "VirtualEnclaveGovernedServiceIdentifier", "csharp");
@@clientName(ServiceIdentifier.AKS, "Aks", "csharp");
@@clientName(
  MaintenanceModeConfigurationModel,
  "VirtualEnclaveMaintenanceModeConfiguration",
  "csharp"
);
@@clientName(
  MaintenanceModeConfigurationPatchModel,
  "VirtualEnclaveMaintenanceModeConfigurationPatch",
  "csharp"
);
@@clientName(TransitOption, "VirtualEnclaveTransitOptionProperties", "csharp");
@@clientName(Principal, "VirtualEnclavePrincipal", "csharp");
@@clientName(MandatoryApprover, "VirtualEnclaveMandatoryApprover", "csharp");
@@clientName(ProvisioningState, "VirtualEnclaveProvisioningState", "csharp");
@@clientName(RoleAssignmentItem, "VirtualEnclaveRoleAssignmentItem", "csharp");
@@clientName(SubnetConfiguration, "VirtualEnclaveSubnetConfiguration", "csharp");
@@clientName(RequestMetadata, "ApprovalRequestMetadata", "csharp");
@@clientName(
  RequestMetadataUpdatableProperties,
  "ApprovalRequestMetadataPatch",
  "csharp"
);
@@clientName(
  TransitHubPatchProperties,
  "VirtualEnclaveTransitHubPatchProperties",
  "csharp"
);
@@clientName(
  VirtualEnclaveBaseModel.bastionEnabled,
  "IsBastionEnabled",
  "csharp"
);
@@clientName(EnclaveVirtualNetworkModel, "EnclaveVirtualNetwork", "csharp");
@@clientName(EnclaveAddressSpacesModel, "EnclaveAddressSpaces", "csharp");
@@clientName(EnclaveDefaultSettingsModel, "EnclaveDefaultSettings", "csharp");
@@clientName(
  EnclaveDefaultSettingsPatchModel,
  "EnclaveDefaultSettingsPatch",
  "csharp"
);
@@clientName(ApprovalActionRequest, "ApprovalActionContent", "csharp");
@@clientName(
  CheckAddressSpaceAvailabilityRequest,
  "CheckAddressSpaceAvailabilityContent",
  "csharp"
);
@@clientName(ServiceIdentifier.PrivateDNSZones, "PrivateDnsZones", "csharp");
@@clientName(ActionPerformed, "ApproverActionPerformed", "csharp");
@@clientName(DedicatedHubResource, "VirtualEnclaveDedicatedHub", "csharp");
@@clientName(DedicatedHubProperties, "VirtualEnclaveDedicatedHubProperties", "csharp");
@@clientName(DedicatedHubPatchModel, "VirtualEnclaveDedicatedHubPatch", "csharp");
@@clientName(
  DedicatedHubPatchProperties,
  "VirtualEnclaveDedicatedHubPatchProperties",
  "csharp"
);
@@clientName(
  CommunityEndpointDestinationRule,
  "VirtualEnclaveCommunityEndpointDestinationRule",
  "csharp"
);
@@clientName(
  CommunityEndpointPatchProperties,
  "VirtualEnclaveCommunityEndpointPatchProperties",
  "csharp"
);
@@clientName(
  CommunityEndpointProtocol,
  "VirtualEnclaveCommunityEndpointProtocol",
  "csharp"
);
@@clientName(Designation, "VirtualEnclaveDesignation", "csharp");
@@clientName(
  EnclaveEndpointPatchProperties,
  "VirtualEnclaveEndpointPatchProperties",
  "csharp"
);
@@clientName(MonitoringDestination, "VirtualEnclaveMonitoringDestination", "csharp");
@@clientName(
  MonitoringDestinationPatchModel,
  "VirtualEnclaveMonitoringDestinationPatch",
  "csharp"
);
@@clientName(
  MonitoringDestinationType,
  "VirtualEnclaveMonitoringDestinationType",
  "csharp"
);
@@clientName(MonitoringSettingsModel, "VirtualEnclaveMonitoringSettings", "csharp");
@@clientName(
  MonitoringSettingsPatchModel,
  "VirtualEnclaveMonitoringSettingsPatch",
  "csharp"
);
@@clientName(RbacInheritanceMode, "VirtualEnclaveRbacInheritanceMode", "csharp");
@@clientName(ResourceVisibilityMode, "VirtualEnclaveResourceVisibilityMode", "csharp");
@@clientName(SecurityProvider, "VirtualEnclaveSecurityProvider", "csharp");
@@clientName(TransitHubState, "VirtualEnclaveTransitHubState", "csharp");
@@clientName(TransitOptionParams, "VirtualEnclaveTransitOptionContent", "csharp");
@@clientName(TransitOptionType, "VirtualEnclaveTransitOptionType", "csharp");
@@clientName(UpdateMode, "VirtualEnclaveUpdateMode", "csharp");
@@clientName(VirtualEnclaveProperties, "VirtualEnclaveProperties", "csharp");
@@clientName(VirtualEnclavePatchProperties, "VirtualEnclavePatchProperties", "csharp");
@@clientName(
  VirtualEnclaveApprovalSettings,
  "VirtualEnclaveApprovalSettings",
  "csharp"
);
@@clientName(
  VirtualEnclaveApprovalSettingsPatchProperties,
  "VirtualEnclaveApprovalSettingsPatchProperties",
  "csharp"
);

@@clientName(Microsoft.Mission, "EnclaveMgmtClient", "python");
