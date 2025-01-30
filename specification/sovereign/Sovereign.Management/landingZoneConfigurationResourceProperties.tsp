using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Sovereign;

@added(Versions.Preview20250227)
@doc("The properties of landing zone configuration resource type.")
model LandingZoneConfigurationResourceProperties {
  @visibility("read")
  @doc("The status of a user-initiated, control-plane operation on the landing zone configuration.")
  provisioningState?: provisioningState;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "Handled in code."
  @visibility("read")
  @doc("The status for the landing zone configurations workflow.")
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

  @doc("The managed identity to be tied to this landing zone configuration")
  managedIdentity: ManagedIdentityProperties;

  @doc("Platform children management group properties.")
  @OpenAPI.extension("x-ms-identifiers", [])
  platformMgChildren?: PlatformManagementGroupProperties[];

  @doc("The naming convention that's used by default for all resource types for this landing zone configuration")
  namingConventionFormula?: string;

  @doc("The customized naming convention for one or more resource types in this landing zone configuration")
  @OpenAPI.extension("x-ms-identifiers", [])
  customNamingConvention?: CustomNamingConvention[];
}

@added(Versions.Preview20250227)
@doc("The properties of managed identity.")
model ManagedIdentityProperties {
  @doc("The type of managed identity.")
  type: ManagedIdentityResourceType;

  @doc("The resource id of the managed identity.")
  userAssignedIdentityResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

@added(Versions.Preview20250227)
@doc("The authoring status for a landing zone configuration.")
union ManagedIdentityResourceType {
  @doc("System assigned managed identity.")
  SystemAssigned: "SystemAssigned",

  @doc("User assigned managed identity.")
  UserAssigned: "UserAssigned",

  string,
}

@doc("The details associated with tags.")
model Tags {
  @doc("A tag name.")
  name: string;

  @doc("A tag value.")
  @madeOptional(Versions.Preview20250227)
  value?: string;
}

@doc("Landing zone management group properties.")
model LandingZoneManagementGroupProperties {
  ...ManagementGroupProperties;

  @doc("Management group name.")
  name: string;
}

@doc("Details of the policy and initiatives associated with the management group.")
model ManagementGroupProperties {
  @doc("Array of initiative assignments to be applied to the management group.")
  @OpenAPI.extension("x-ms-identifiers", [])
  policyInitiativesAssignmentProperties: PolicyInitiativeAssignmentProperties[];
}

@doc("Details of policy assignments")
model PolicyInitiativeAssignmentProperties {
  @doc("The fully qualified id of the policy initiative.")
  policyInitiativeId: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This would be customer defined parameter based on the policy initiatives to be assigned. Hence we need to use Record<unknown> as it will differ per initiative."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Model properties or operation parameters should not be of type Record. ARM requires Resource provider teams to define types explicitly."
  @doc("The parameters for the assignment of policy initiatives.")
  assignmentParameters: Record<unknown>;
}

@doc("Decommissioned management group properties.")
model DecommissionedManagementGroupProperties {
  ...ManagementGroupProperties;

  @doc("When set to false, this management group will not be created. The default value is false.")
  create: boolean;
}

@doc("Sandbox management group properties.")
model SandboxManagementGroupProperties {
  ...ManagementGroupProperties;

  @doc("When set to false this management group will not be created. The default value is false.")
  create: boolean;
}

@doc("The request to generate code for a landing zone.")
model GenerateLandingZoneRequest {
  @doc("The export options available for code generation.")
  infrastructureAsCodeOutputOptions: InfrastructureAsCodeOutputOptions;

  @doc("Management subscription fully qualified Id.")
  existingManagementSubscriptionId?: armResourceIdentifier<[
    {
      type: "Microsoft.Subscription/aliases";
    }
  ]>;

  @doc("Identity subscription fully qualified Id.")
  existingIdentitySubscriptionId?: armResourceIdentifier<[
    {
      type: "Microsoft.Subscription/aliases";
    }
  ]>;

  @doc("Connectivity subscription fully qualified Id.")
  existingConnectivitySubscriptionId?: armResourceIdentifier<[
    {
      type: "Microsoft.Subscription/aliases";
    }
  ]>;

  @doc("The full resource ID of billing scope associated to the EA, MCA or MPA account you wish to create the subscription in.")
  subscriptionBillingScope?: string;

  @doc("Optional parent for management group hierarchy, used as intermediate root management group parent, if specified. If empty, default will deploy beneath tenant toot management group.")
  existingTopLevelMgParentId?: armResourceIdentifier<[
    {
      type: "Microsoft.Management/managementGroups";
    }
  ]>;

  @doc("The prefix that will be added to all resources created by this deployment.")
  @minLength(2)
  @maxLength(5)
  @pattern("^([a-zA-Z0-9-]*)$")
  deploymentPrefix: string;

  @doc("The suffix that will be added to all resources created by this deployment.")
  @minLength(2)
  @maxLength(5)
  deploymentSuffix?: string;

  @doc("The top level management group display name.")
  @minLength(1)
  @maxLength(90)
  topLevelMgDisplayName: string;

  @doc("Location to run deployment(s) from the list of azure regions.")
  @pattern("^([a-zA-Z0-9]+)$")
  deploymentLocation: string;

  @doc("The name of the organization or agency the landing zone is being deployed for.")
  organization?: string;

  @doc("The environment for which the landing zone is being deployed")
  environment?: string;
}

@doc("The response for the request to generate landing zone code.")
model GenerateLandingZoneResponse {
  @doc("The top level Management Group display name.")
  topLevelMgDisplayName: string;

  @doc("The name of the Landing Zone configuration resource.")
  landingZoneConfigurationName: string;

  @doc("The url to access the generated code..")
  @secret
  generatedCodeUrl: url;

  @doc("The storage account name to access the generated code.")
  @secret
  storageAccountName: string;

  @doc("The storage account container to access the generated code.")
  @secret
  containerName: string;

  @doc("The storage account blob name to access the generated code.")
  @secret
  blobName: string;

  @doc("The generated code content as a json string.")
  @secret
  generatedArmTemplate?: string;
}

@doc("The request to update authoring status of a configuration.")
model UpdateAuthoringStatusRequest {
  @doc("The value of the authoring status to be updated.")
  authoringStatus: AuthoringStatus;
}

@doc("The response for the request to update authoring status.")
model UpdateAuthoringStatusResponse {
  @doc("The name of the landing zone configuration resource.")
  landingZoneConfigurationName: string;

  @doc("The value of the authoring status to be updated.")
  authoringStatus: AuthoringStatus;
}

@doc("The authoring status for a landing zone configuration.")
union AuthoringStatus {
  @doc("This is the default status when a create configuration request is made. In this state, the Landing Zone configuration can be updated.")
  Authoring: "Authoring",

  @doc("This status is set when the configuration changes are complete and the configuration is ready for code generation")
  ReadyForUse: "ReadyForUse",

  @doc("This status is set when the landing zone configuration is no longer in use.")
  Disabled: "Disabled",

  string,
}

@doc("Output options for landing zone code generation.")
union InfrastructureAsCodeOutputOptions {
  @doc("Value when generating Landing Zone code in Bicep.")
  Bicep: "Bicep",

  @doc("Value when generating landing zone code in Arm.")
  ARM: "ARM",

  string,
}

@doc("The input values for creating or using an existing firewall resource.")
union FirewallCreationOptions {
  @doc("Value when a firewall resource is not created.")
  None: "None",

  @doc("Value when the firewall creation is based on the standard SKU.")
  Standard: "Standard",

  @doc("Value when the firewall creation is based on the premium SKU.")
  Premium: "Premium",

  string,
}

@doc("Options for resource creation.")
union ResourceCreationOptions {
  @doc("Value to create a new resource.")
  Yes: "Yes",

  @doc("Value to not create a new resource.")
  No: "No",

  @doc("Value to use an existing resource.")
  UseExisting: "UseExisting",

  string,
}

@doc("The request for the create copy action of landing zone configuration.")
model CreateCopyRequest {
  @doc("The name of the new landing zone configuration resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@doc("The response of the create copy action of landing zone configuration.")
model CreateCopyResponse {
  @doc("The id of the copied landing zone configuration resource.")
  copiedLandingZoneConfigurationId: armResourceIdentifier<[
    {
      type: "Microsoft.Sovereign/landingZoneConfigurations";
    }
  ]>;
}

@doc("The request for the create copy action of landing zone configuration.")
model CreateLandingZoneConfigurationCopyRequest {
  @doc("The name of the new landing zone configuration resource.")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  name: string;
}

@doc("The response of the create copy action of landing zone configuration.")
model CreateLandingZoneConfigurationCopyResponse {
  @doc("The id of the copied landing zone configuration resource.")
  copiedLandingZoneConfigurationId: armResourceIdentifier<[
    {
      type: "Microsoft.Sovereign/landingZoneAccounts/landingZoneConfigurations";
    }
  ]>;
}

@doc("The details for the custom resource override.")
@added(Versions.Preview20250227)
model CustomNamingConvention {
  @doc("The type of the resource.")
  resourceType: ResourceType;

  @doc("The custom formula for the resource type.")
  formula: string;
}

@doc("The input values for defining resource types for naming conventions.")
@added(Versions.Preview20250227)
union ResourceType {
  @doc("Value when customer wants to provide custom naming convention for Azure Firewall.")
  azureFirewalls: "azureFirewalls",

  @doc("Value when customer wants to provide custom naming convention for Log Analytics workspace.")
  workspaces: "workspaces",

  @doc("Value when customer wants to provide custom naming convention for automation account.")
  automationAccounts: "automationAccounts",

  @doc("Value when customer wants to provide custom naming convention for dashboard.")
  dashboards: "dashboards",

  @doc("Value when customer wants to provide custom naming convention for managed identity.")
  userAssignedIdentities: "userAssignedIdentities",

  @doc("Value when customer wants to provide custom naming convention for Bastion.")
  bastionHosts: "bastionHosts",

  @doc("Value when customer wants to provide custom naming convention for DDoS protection plan.")
  ddosProtectionPlans: "ddosProtectionPlans",

  @doc("Value when customer wants to provide custom naming convention for Bastion NSG.")
  networkSecurityGroups: "networkSecurityGroups",

  @doc("Value when customer wants to provide custom naming convention for virtual network.")
  virtualNetworks: "virtualNetworks",

  @doc("Value when customer wants to provide custom naming convention for route table.")
  routeTables: "routeTables",

  string,
}

@added(Versions.Preview20250227)
@doc("Platform management group properties.")
model PlatformManagementGroupProperties {
  ...ManagementGroupProperties;

  @doc("Management group name.")
  name: string;
}
