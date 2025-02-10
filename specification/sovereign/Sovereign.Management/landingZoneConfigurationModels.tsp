using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Sovereign;

@removed(Versions.Preview20241031)
@doc("The properties of landing zone configuration resource type.")
model LandingZoneConfigurationProperties {
  @visibility("read")
  @doc("The status of a user-initiated, control-plane operation on the landing zone configuration.")
  provisioningState?: ResourceProvisioningState;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "Handled in code."
  @visibility("read")
  @doc("The status for the landing zone configuration workflow.")
  authoringStatus?: AuthoringStatus;

  @doc("To deploy ddos, choose Yes, otherwise No. Select Existing to provide an existing ddos protection plan.")
  ddosProtectionCreationOption: ResourceCreationOptions;

  @doc("The resource id of the ddos protection plan.")
  existingDdosProtectionId?: armResourceIdentifier<[
    {
      type: "Microsoft.Network/ddosProtectionPlans";
    }
  ]>;

  @doc("To deploy log analytics workspace, choose Yes, otherwise No. Select UseExisting to provide an existing log analytics workspace.")
  logAnalyticsWorkspaceCreationOption: ResourceCreationOptions;

  @doc("The resource id of the log analytics workspace that was created to centralize log ingestion.")
  existingLogAnalyticsWorkspaceId?: armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  @doc("Array of tag objects in format of {'name':'a tag name', 'value':'a tag value'}.")
  @OpenAPI.extension("x-ms-identifiers", [])
  tags?: Tags[];

  @doc("To deploy firewall, choose the Standard/Premium based on the desired SKU. Choose None for no firewall and UseExisting for a pre existing one.")
  firewallCreationOption: FirewallCreationOptions;

  @doc("Azure firewall subnet. IPv4 CIDR block.")
  firewallSubnetCidrBlock?: string;

  @doc("Gateway subnet. IPv4 CIDR block.")
  gatewaySubnetCidrBlock: string;

  @doc("Set how long logs are retained for, in days. Minimum length is 30 and maximum is 730")
  @minValue(30)
  @maxValue(730)
  logRetentionInDays: int64;

  @doc("The address space for the VNET. IPv4 CIDR block.")
  hubNetworkCidrBlock: string;

  @doc("To deploy the bastion service, choose Yes, otherwise No. Choose UseExisting for existing bastion service.")
  azureBastionCreationOption: ResourceCreationOptions;

  @doc("The resource id of azure bastion.")
  existingAzureBastionId?: armResourceIdentifier<[
    {
      type: "Microsoft.Network/bastionHosts";
    }
  ]>;

  @doc("Azure bastion subnet. IP v4 CIDR block.")
  azureBastionSubnetCidrBlock?: string;

  @doc("Landing zone children management group properties")
  @OpenAPI.extension("x-ms-identifiers", [])
  landingZonesMgChildren?: LandingZoneManagementGroupProperties[];

  @doc("This will be applied to the root of the landing zone deployment.")
  topLevelMgMetadata?: ManagementGroupProperties;

  @doc("This will be applied to the landing zone management groups.")
  landingZonesMgMetadata?: ManagementGroupProperties;

  @doc("This will be applied to the platform management group.")
  platformMgMetadata?: ManagementGroupProperties;

  @doc("This will be applied to the management management group under platform.")
  platformManagementMgMetadata?: ManagementGroupProperties;

  @doc("This will be applied to the connectivity management group under platform.")
  platformConnectivityMgMetadata?: ManagementGroupProperties;

  @doc("This will be applied to the identity management group under platform.")
  platformIdentityMgMetadata?: ManagementGroupProperties;

  @doc("This will be applied to the decommissioned management group.")
  decommissionedMgMetadata?: DecommissionedManagementGroupProperties;

  @doc("This will be applied to the sandbox management group.")
  sandboxMgMetadata?: SandboxManagementGroupProperties;
}
