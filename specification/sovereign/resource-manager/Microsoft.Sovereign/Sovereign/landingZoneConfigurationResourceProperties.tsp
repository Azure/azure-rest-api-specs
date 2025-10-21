using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Sovereign;

@added(Versions.Preview20250227)
@doc("The properties of landing zone configuration resource type.")
model LandingZoneConfigurationResourceProperties {
  @visibility(Lifecycle.Read)
  @doc("The state that reflects the current stage in the creation, updating, or deletion process of the landing zone configuration.")
  provisioningState?: provisioningState;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "Handled in code."
  @visibility(Lifecycle.Read)
  @doc("The status that indicates the current phase of the configuration process for a deployment.")
  authoringStatus?: AuthoringStatus;

  @doc("Parameter used to deploy a DDoS protection plan: Select 'Yes' to enable deployment, 'No' to skip it, or 'Existing' to reuse an existing DDoS protection plan.")
  ddosProtectionCreationOption: ResourceCreationOptions;

  @doc("The resource ID of the DDoS protection plan when reusing an existing one.")
  existingDdosProtectionId?: armResourceIdentifier<[
    {
      type: "Microsoft.Network/ddosProtectionPlans";
    }
  ]>;

  @doc("Parameter used to deploy a log analytics workspace: Select 'Yes' to enable deployment, 'No' to skip it, or 'Existing' to reuse an existing log analytics workspace.")
  logAnalyticsWorkspaceCreationOption: ResourceCreationOptions;

  @doc("The resource ID of the log analytics workspace when reusing an existing one.")
  existingLogAnalyticsWorkspaceId?: armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  @doc("Tags are key-value pairs that can be assigned to a resource to organize and manage it more effectively. Example: {'name': 'a tag name', 'value': 'a tag value'}")
  @identifiers(#[])
  tags?: Tags[];

  @doc("Parameter used for deploying a Firewall: Select 'No' to skip deployment, 'Standard' to deploy the Standard SKU, or 'Premium' to deploy the Premium SKU.")
  firewallCreationOption: FirewallCreationOptions;

  @doc("The Firewall subnet address used for deploying a firewall. Specify the Firewall subnet using IPv4 CIDR notation.")
  firewallSubnetCidrBlock?: string;

  @doc("The gateway subnet address used for deploying a virtual network. Specify the subnet using IPv4 CIDR notation.")
  gatewaySubnetCidrBlock: string;

  @doc("Parameter to define the retention period for logs, in days. The minimum duration is 30 days and the maximum is 730 days.")
  @minValue(30)
  @maxValue(730)
  logRetentionInDays: int64;

  @doc("The Virtual Network address. Specify the address using IPv4 CIDR notation.")
  hubNetworkCidrBlock: string;

  @doc("Parameter used to deploy a Bastion: Select 'Yes' to enable deployment, 'No' to skip it, or 'Existing' to reuse an existing Bastion.")
  azureBastionCreationOption: ResourceCreationOptions;

  @doc("The resource ID of the Bastion when reusing an existing one.")
  existingAzureBastionId?: armResourceIdentifier<[
    {
      type: "Microsoft.Network/bastionHosts";
    }
  ]>;

  @doc("The Bastion subnet address. Specify the address using IPv4 CIDR notation.")
  azureBastionSubnetCidrBlock?: string;

  @doc("The child management groups of 'Landing Zones' management group and their assigned policies.")
  @identifiers(#[])
  landingZonesMgChildren?: LandingZoneManagementGroupProperties[];

  @doc("The assigned policies of the parent management group.")
  topLevelMgMetadata?: ManagementGroupProperties;

  @doc("The assigned policies of the 'Landing Zones' management group.")
  landingZonesMgMetadata?: ManagementGroupProperties;

  @doc("The assigned policies of the 'Platform' management group.")
  platformMgMetadata?: ManagementGroupProperties;

  @doc("The assigned policies of the 'Management' management group under 'Platform' management group.")
  platformManagementMgMetadata?: ManagementGroupProperties;

  @doc("The assigned policies of the 'Connectivity' management group under 'Platform' management group.")
  platformConnectivityMgMetadata?: ManagementGroupProperties;

  @doc("The assigned policies of the 'Identity' management group under 'Platform' management group.")
  platformIdentityMgMetadata?: ManagementGroupProperties;

  @doc("The assigned policies of the 'Decommissioned' management group and indicator to create it or not.")
  decommissionedMgMetadata?: DecommissionedManagementGroupProperties;

  @doc("The assigned policies of the 'Sandbox' management group and indicator to create it or not.")
  sandboxMgMetadata?: SandboxManagementGroupProperties;

  @doc("The managed identity to be assigned to this landing zone configuration.")
  managedIdentity: ManagedIdentityProperties;

  @doc("The names of the 'Platform' child management groups and their assigned policies, excluding the default ones: 'Connectivity', 'Identity', and 'Management'")
  @identifiers(#[])
  platformMgChildren?: PlatformManagementGroupProperties[];

  @doc("The default naming convention applied to all resources for this landing zone configuration. Example - {DeploymentPrefix}-Contoso-{ResourceTypeAbbreviation}{DeploymentSuffix}-{Environment}-testing")
  namingConventionFormula?: string;

  @doc("The custom naming convention applied to specific resource types for this landing zone configuration, which overrides the default naming convention for those resource types. Example - 'customNamingConvention': [{'resourceType': 'azureFirewalls', 'formula': '{DeploymentPrefix}-afwl-{DeploymentSuffix}'}]")
  @identifiers(#[])
  customNamingConvention?: CustomNamingConvention[];
}

@added(Versions.Preview20250227)
@doc("The properties of managed identity, specifically including type and resource ID.")
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
@doc("The managed identity resource.")
union ManagedIdentityResourceType {
  @doc("System assigned managed identity.")
  SystemAssigned: "SystemAssigned",

  @doc("User assigned managed identity.")
  UserAssigned: "UserAssigned",

  string,
}

@doc("Key-value pairs that can be assigned to this resource.")
model Tags {
  @doc("A tag name.")
  name: string;

  @doc("A tag value.")
  @madeOptional(Versions.Preview20250227)
  value?: string;
}

@doc("The 'Landing Zones' management group properties..")
model LandingZoneManagementGroupProperties {
  ...ManagementGroupProperties;

  @doc("Management group name.")
  name: string;
}

@doc("The properties of policy initiatives applied to the management group.")
model ManagementGroupProperties {
  @doc("Array of policy initiatives applied to the management group.")
  @identifiers(#[])
  policyInitiativesAssignmentProperties: PolicyInitiativeAssignmentProperties[];
}

@doc("The properties of assigned policy initiatives.")
model PolicyInitiativeAssignmentProperties {
  @doc("The fully qualified id of the policy initiative.")
  policyInitiativeId: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This would be customer defined parameter based on the policy initiatives to be assigned. Hence we need to use Record<unknown> as it will differ per initiative."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Model properties or operation parameters should not be of type Record. ARM requires Resource provider teams to define types explicitly."
  @doc("The parameters of the assigned policy initiative.")
  assignmentParameters: Record<unknown>;
}

@doc("The 'Decommissioned' management group properties.")
model DecommissionedManagementGroupProperties {
  ...ManagementGroupProperties;

  @doc("This parameter determines whether the 'Decommissioned' management group will be created. If set to true, the group will be created; if set to false, it will not be created. The default value is false.")
  create: boolean;
}

@doc("The 'Sandbox' management group properties.")
model SandboxManagementGroupProperties {
  ...ManagementGroupProperties;

  @doc("This parameter determines whether the 'Sandbox' management group will be created. If set to true, the group will be created; if set to false, it will not be created. The default value is false.")
  create: boolean;
}

@doc("The request to generate Infrastructure as Code (IaC) for a landing zone.")
model GenerateLandingZoneRequest {
  @doc("The export options available for code generation.")
  infrastructureAsCodeOutputOptions: InfrastructureAsCodeOutputOptions;

  @doc("Existing 'Management' subscription ID to be linked with this deployment when reusing instead of creating a new subscription.")
  existingManagementSubscriptionId?: armResourceIdentifier<[
    {
      type: "Microsoft.Subscription/aliases";
    }
  ]>;

  @doc("Existing 'Identity' subscription ID to be linked with this deployment when reusing instead of creating a new subscription.")
  existingIdentitySubscriptionId?: armResourceIdentifier<[
    {
      type: "Microsoft.Subscription/aliases";
    }
  ]>;

  @doc("Existing 'Connectivity' subscription ID to be linked with this deployment when reusing instead of creating a new subscription.")
  existingConnectivitySubscriptionId?: armResourceIdentifier<[
    {
      type: "Microsoft.Subscription/aliases";
    }
  ]>;

  @doc("The complete resource ID of the billing scope linked to the EA, MCA, or MPA account where you want to create the subscription.")
  subscriptionBillingScope?: string;

  @doc("Optional parent for the management group hierarchy, serving as an intermediate root management group parent if specified. If left empty, the default will be to deploy under the tenant root management group.")
  existingTopLevelMgParentId?: armResourceIdentifier<[
    {
      type: "Microsoft.Management/managementGroups";
    }
  ]>;

  @doc("The prefix that will be added to all resources created by this deployment. Use between 2 and 5 characters, consisting only of letters, digits, '-', '.', or '_'. No other special characters are supported.")
  @minLength(2)
  @maxLength(5)
  @pattern("^([a-zA-Z0-9-]*)$")
  deploymentPrefix: string;

  @doc("The optional suffix that will be appended to all resources created by this deployment, maximum 5 characters.")
  @minLength(2)
  @maxLength(5)
  deploymentSuffix?: string;

  @doc("The display name assigned to the top management group of the landing zone deployment hierarchy. It is recommended to use unique names for each landing zone deployment.")
  @minLength(1)
  @maxLength(90)
  topLevelMgDisplayName: string;

  @doc("The Azure region where the landing zone will be deployed. All Azure regions are supported.")
  @pattern("^([a-zA-Z0-9]+)$")
  deploymentLocation: string;

  @doc("The name of the organization or agency for which the landing zone is being deployed. This is optional.")
  organization?: string;

  @doc("The environment where the landing zone is being deployed, such as ppe, prod, test, etc.")
  environment?: string;
}

@doc("The response payload for generating infrastructure-as-code for the landing zone.")
model GenerateLandingZoneResponse {
  @doc("The parent management group name of the landing zone deployment.")
  topLevelMgDisplayName: string;

  @doc("The name of the Landing zone configuration resource.")
  landingZoneConfigurationName: string;

  @doc("The url to access the generated code.")
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

  @doc("The generated code content in JSON string format.")
  @secret
  generatedArmTemplate?: string;
}

@doc("The request to update the authoring status of a configuration.")
model UpdateAuthoringStatusRequest {
  @doc("The authoring status value to be updated. Possible values include: 'Authoring', 'ReadyForUse' and 'Disabled'.")
  authoringStatus: AuthoringStatus;
}

@doc("The response for authoring status update request.")
model UpdateAuthoringStatusResponse {
  @doc("The name of the landing zone configuration resource.")
  landingZoneConfigurationName: string;

  @doc("The authoring status value to be updated.")
  authoringStatus: AuthoringStatus;
}

@doc("The authoring status for a landing zone configuration.")
union AuthoringStatus {
  @doc("'Authoring' is the default status when a create configuration request is made. In this state, the Landing zone configuration can be modified.")
  Authoring: "Authoring",

  @doc("'ReadyForUse' status is set when the configuration updates are finished, and the configuration is ready for code generation or deployment.")
  ReadyForUse: "ReadyForUse",

  @doc("'Disabled' status is set when the landing zone configuration is no longer in use.")
  Disabled: "Disabled",

  string,
}

@doc("Output options for landing zone code generation.")
union InfrastructureAsCodeOutputOptions {
  @doc("Value when generating Landing zone code in Bicep format.")
  Bicep: "Bicep",

  @doc("Value when generating Landing zone code in ARM format.")
  ARM: "ARM",

  string,
}

@doc("Parameter used for deploying or not a Firewall resource.")
union FirewallCreationOptions {
  @doc("Select 'None' value to skip Firewall deployment.")
  None: "None",

  @doc("Select 'Standard' value to deploy the Firewall Standard SKU.")
  Standard: "Standard",

  @doc("Select 'Premium' value to deploy the Firewall Premium SKU.")
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

@doc("The request for duplicate landing zone configuration.")
model CreateCopyRequest {
  @doc("The name of the duplicate landing zone configuration resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@doc("The response of the request for duplicate landing zone configuration.")
model CreateCopyResponse {
  @doc("The ID of the duplicate landing zone configuration resource.")
  copiedLandingZoneConfigurationId: armResourceIdentifier<[
    {
      type: "Microsoft.Sovereign/landingZoneConfigurations";
    }
  ]>;
}

@doc("The request for create duplicate landing zone configuration.")
model CreateLandingZoneConfigurationCopyRequest {
  @doc("The name of the duplicate landing zone configuration resource.")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  name: string;
}

@doc("The response of the create duplicate landing zone configuration.")
model CreateLandingZoneConfigurationCopyResponse {
  @doc("The ID of the duplicate landing zone configuration resource.")
  copiedLandingZoneConfigurationId: armResourceIdentifier<[
    {
      type: "Microsoft.Sovereign/landingZoneAccounts/landingZoneConfigurations";
    }
  ]>;
}

@doc("The details for the custom naming convention override for a specific resource type.")
@added(Versions.Preview20250227)
model CustomNamingConvention {
  @doc("The type of the resource.")
  resourceType: ResourceType;

  @doc("The custom naming formula for the resource type.")
  formula: string;
}

@doc("The input values for resource types for custom naming conventions.")
@added(Versions.Preview20250227)
union ResourceType {
  @doc("Value when customer wants to provide a custom naming convention for Azure Firewall.")
  azureFirewalls: "azureFirewalls",

  @doc("Value when customer wants to provide a custom naming convention for Log Analytics workspace.")
  workspaces: "workspaces",

  @doc("Value when customer wants to provide a custom naming convention for automation account.")
  automationAccounts: "automationAccounts",

  @doc("Value when customer wants to provide a custom naming convention for dashboard.")
  dashboards: "dashboards",

  @doc("Value when customer wants to provide a custom naming convention for managed identity.")
  userAssignedIdentities: "userAssignedIdentities",

  @doc("Value when customer wants to provide a custom naming convention for Bastion.")
  bastionHosts: "bastionHosts",

  @doc("Value when customer wants to provide a custom naming convention for DDoS protection plan.")
  ddosProtectionPlans: "ddosProtectionPlans",

  @doc("Value when customer wants to provide a custom naming convention for Bastion NSG.")
  networkSecurityGroups: "networkSecurityGroups",

  @doc("Value when customer wants to provide a custom naming convention for virtual network.")
  virtualNetworks: "virtualNetworks",

  @doc("Value when customer wants to provide a custom naming convention for route table.")
  routeTables: "routeTables",

  string,
}

@added(Versions.Preview20250227)
@doc("The 'Platform' management group properties.")
model PlatformManagementGroupProperties {
  ...ManagementGroupProperties;

  @doc("Management group name.")
  name: string;
}
