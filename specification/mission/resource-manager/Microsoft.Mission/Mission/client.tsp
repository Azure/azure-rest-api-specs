import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Mission;

@@clientName(ApprovalResource, "EnclaveApproval", "csharp");
@@clientName(ApprovalProperties, "EnclaveApprovalProperties", "csharp");
@@clientName(
  CommunityEndpointResource,
  "EnclaveCommunityEndpoint",
  "csharp"
);
@@clientName(
  CommunityEndpointProperties,
  "EnclaveCommunityEndpointProperties",
  "csharp"
);
@@clientName(CommunityResource, "EnclaveCommunity", "csharp");
@@clientName(
  CommunityProperties,
  "EnclaveCommunityProperties",
  "csharp"
);
@@clientName(EnclaveConnectionResource, "EnclaveConnection", "csharp");
@@clientName(
  EnclaveConnectionProperties,
  "EnclaveConnectionProperties",
  "csharp"
);
@@clientName(EnclaveEndpointResource, "EnclaveEndpoint", "csharp");
@@clientName(
  EnclaveEndpointProperties,
  "EnclaveEndpointProperties",
  "csharp"
);
@@clientName(EnclaveResource, "Enclave", "csharp");
@@clientName(TransitHubResource, "EnclaveTransitHub", "csharp");
@@clientName(TransitHubResource, "EnclaveTransitHub", "csharp");
@@clientName(
  TransitHubProperties,
  "EnclaveTransitHubProperties",
  "csharp"
);
@@clientName(WorkloadResource, "EnclaveWorkload", "csharp");
@@clientName(WorkloadProperties, "EnclaveWorkloadProperties", "csharp");
@@clientName(
  TransitHubProperties,
  "EnclaveTransitHubProperties",
  "csharp"
);
@@clientName(ApprovalActionResponse, "ApprovalActionResult", "csharp");
@@clientName(ApprovalCallbackRequest, "ApprovalCallbackContent", "csharp");
@@clientName(
  ApprovalDeletionCallbackRequest,
  "ApprovalDeletionCallbackContent",
  "csharp"
);
@@clientName(
  ApprovalPatchProperties,
  "EnclaveApprovalPatchProperties",
  "csharp"
);
@@clientName(Approver, "EnclaveApprover", "csharp");
@@clientName(ApprovalPolicy, "EnclaveApprovalPolicy", "csharp");
@@clientName(ApprovalSettings, "EnclaveBaseApprovalSettings", "csharp");
@@clientName(
  LegacyApprovalSettings,
  "EnclaveLegacyApprovalSettings",
  "csharp"
);
@@clientName(ApprovalStatus, "EnclaveApprovalStatus", "csharp");
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
@@clientName(DestinationType, "EnclaveCommunityEndpointDestinationType", "csharp");
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
@@clientName(CommunityPatchModel, "EnclaveCommunityPatch", "csharp");
@@clientName(
  CommunityPatchProperties,
  "EnclaveCommunityPatchProperties",
  "csharp"
);
@@clientName(
  DiagnosticDestination,
  "EnclaveDiagnosticDestination",
  "csharp"
);
@@clientName(FirewallSKU, "EnclaveFirewallSku", "csharp");
@@clientName(GovernedServiceItem, "EnclaveGovernedService", "csharp");
@@clientName(
  ServiceIdentifier,
  "EnclaveGovernedServiceIdentifier",
  "csharp"
);
@@clientName(ServiceIdentifier.AKS, "Aks", "csharp");
@@clientName(
  MaintenanceModeConfigurationModel,
  "EnclaveMaintenanceModeConfiguration",
  "csharp"
);
@@clientName(
  MaintenanceModeConfigurationPatchModel,
  "EnclaveMaintenanceModeConfigurationPatch",
  "csharp"
);
@@clientName(TransitOption, "EnclaveTransitOptionProperties", "csharp");
@@clientName(Principal, "EnclavePrincipal", "csharp");
@@clientName(MandatoryApprover, "EnclaveMandatoryApprover", "csharp");
@@clientName(ProvisioningState, "EnclaveProvisioningState", "csharp");
@@clientName(RoleAssignmentItem, "EnclaveRoleAssignmentItem", "csharp");
@@clientName(
  SubnetConfiguration,
  "EnclaveSubnetConfiguration",
  "csharp"
);
@@clientName(RequestMetadata, "ApprovalRequestMetadata", "csharp");
@@clientName(
  RequestMetadataUpdatableProperties,
  "ApprovalRequestMetadataPatch",
  "csharp"
);
@@clientName(
  TransitHubPatchProperties,
  "EnclaveTransitHubPatchProperties",
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

@@clientName(Microsoft.Mission, "VirtualEnclavesMgmtClient", "python");

// Resource rename: DedicatedHubResource -> DedicatedHub (also renames Data/Collection/Patch derivatives)
@@clientName(DedicatedHubResource, "DedicatedHub", "csharp");

// Types renamed to add resource provider or feature context
@@clientName(CommunityEndpointDestinationRule, "EnclaveCommunityEndpointDestinationRule", "csharp");
@@clientName(CommunityEndpointPatchProperties, "EnclaveCommunityEndpointPatchProperties", "csharp");
@@clientName(CommunityEndpointProtocol, "EnclaveCommunityEndpointProtocol", "csharp");
@@clientName(Designation, "EnclaveDesignation", "csharp");
@@clientName(EnclaveEndpointPatchProperties, "EnclaveEndpointPatchProperties", "csharp");
@@clientName(MonitoringDestination, "EnclaveMonitoringDestination", "csharp");
@@clientName(MonitoringDestinationPatchModel, "EnclaveMonitoringDestinationPatch", "csharp");
@@clientName(MonitoringDestinationType, "EnclaveMonitoringDestinationType", "csharp");
@@clientName(MonitoringSettingsModel, "EnclaveMonitoringSettings", "csharp");
@@clientName(MonitoringSettingsPatchModel, "EnclaveMonitoringSettingsPatch", "csharp");
@@clientName(RbacInheritanceMode, "EnclaveRbacInheritanceMode", "csharp");
@@clientName(ResourceVisibilityMode, "EnclaveResourceVisibilityMode", "csharp");
@@clientName(SecurityProvider, "EnclaveSecurityProvider", "csharp");
@@clientName(TransitHubState, "EnclaveTransitHubState", "csharp");
@@clientName(TransitOptionParams, "EnclaveTransitOptionContent", "csharp");
@@clientName(TransitOptionType, "EnclaveTransitOptionType", "csharp");
@@clientName(UpdateMode, "EnclaveUpdateMode", "csharp");
