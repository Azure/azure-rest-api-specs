import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "This is defined in other swagger file - hybridconnectivity.json"
@armCommonTypesVersion(CommonTypes.Versions.v5)
@armProviderNamespace
@versioned(Versions)
@service({
  title: "Hybrid Connectivity Management API",
})
@doc("REST API for public clouds.")
namespace Microsoft.HybridConnectivity;

@doc("Hybrid Connectivity Management service version.")
enum Versions {
  @doc("Version 2023-04-01")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_04_01: "2023-04-01-preview",

  @doc("Version 2023-12-01")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_12_01: "2023-12-01-preview",
}


//---------------------------------------------- Models ----------------------------------------------

//------------------- Generate Aws Template -------------------

@added(Versions.v2023_12_01)
@doc("ConnectorId and SolutionTypes and their properties to Generate AWS CFT Template.")
model GenerateAwsTemplateRequest {
  @doc("The name of public cloud connector")
  connectorId: string;

  @doc("The list of solution types and their settings")
  solutionTypes?: Array<SolutionTypeSettings>;
}

@added(Versions.v2023_12_01)
@doc("The properties of Solution Type")
model SolutionTypeSettings {
  @doc("The type of the solution")
  solutionType: string;

  @doc("Solution settings")
  solutionSettings?: SolutionSettings;
}

//------------------- Test Permissions -------------------

@added(Versions.v2023_12_01)
@doc("Public connector permissions.")
model TestPermissionResponse {
  @doc("The name of public cloud connector")
  overallStatus: Status;

  @doc("Solution type permissions.")
  solutionTypes: Array<SolutionTypePermissions>;
}

@added(Versions.v2023_12_01)
@doc("Solution type permissions.")
model SolutionTypePermissions {
  @doc("The name of solution Type")
  solutionType: SolutionTypeEnum;

  @doc("The status")
  status: Status;

  @doc("The details of the status")
  statusDetails: string;
}

@added(Versions.v2023_12_01)
@doc("Solution types.")
enum SolutionTypeEnum {
  @doc("Asset Management solution type")
  `Microsoft.AssetManagement`,

  @doc("Hybrid Compute Onboard solution type")
  `Microsoft.HybridCompute.Onboard`,

  @doc("VWan Provisioning solution type")
  `Microsoft.HybridNetwork.VWan.Provision`,
}

@added(Versions.v2023_12_01)
@doc("Connection status.")
enum Status {
  @doc("Connected status")
  Connected,

  @doc("Disconnected status")
  Disconnected,
}

//------------------- Public Cloud Connector -------------------

@added(Versions.v2023_04_01)
@removed(Versions.v2023_12_01)
@doc("Public Cloud Connector")
model PublicCloudConnector is TrackedResource<PublicCloudConnectorProperties> {
  @doc("Represent public cloud connectors resource.")
  @key("publicCloudConnector")
  @path
  @segment("publicCloudConnectors")
  name: string;
}

@added(Versions.v2023_04_01)
@removed(Versions.v2023_12_01)
@doc("Properties of public cloud connectors.")
model PublicCloudConnectorProperties {
  @doc("Cloud profile for AWS.")
  awsCloudProfile?: AwsCloudProfile;

  @doc("Host cloud the public cloud connector.")
  @visibility("create")
  hostType?: HostType;

  @visibility("read")
  @doc("The resource provisioning state.")
  provisioningState?: ProvisioningState;
}

@added(Versions.v2023_04_01)
@removed(Versions.v2023_12_01)
@doc("Enum of host cloud the public cloud connector is referencing.")
enum HostType {
  @doc("AWS state")
  AWS
}

@added(Versions.v2023_04_01)
@removed(Versions.v2023_12_01)
@doc("cloud profile for AWS.")
model AwsCloudProfile {
  @doc("Account id for the AWS account.")
  @visibility("create")
  accountId: string;

  @doc("List of AWS accounts which need to be excluded.")
  excludedAccounts?: string[];

  @doc("Boolean value that indicates whether the account is organizational or not. True represents organization account, whereas false represents a single account.")
  @visibility("create")
  isOrganizationalAccount?: boolean;
}

//------------------- Solution Configuration -------------------

@added(Versions.v2023_04_01)
@removed(Versions.v2023_12_01)
@doc("Solution Configuration")
model SolutionConfiguration is TrackedResource<SolutionConfigurationProperties> {
  @doc("Represent Solution Configuration Resource.")
  @key("solutionConfiguration")
  @path
  @segment("solutionConfigurations")
  name: string;
}

@added(Versions.v2023_04_01)
@removed(Versions.v2023_12_01)
@doc("Solution configuration resource.")
model SolutionConfigurationProperties {
  @doc("The resource provisioning state.")
  provisioningState?: ProvisioningState;

  @doc("The type of the solution")
  solutionType: string;

  @doc("Solution settings")
  solutionSettings?: SolutionSettings;

  @doc("The status of solution configurations")
  status?: SolutionConfigurationStatus;

  @doc("The detailed message of status details")
  statusDetails?: string;

  @doc("The last execution time of solution configuration")
  lastExecutionTime?: string;
}

@added(Versions.v2023_04_01)
@removed(Versions.v2023_12_01)
@doc("Solution Configuration Status.")
enum SolutionConfigurationStatus {
  @doc("New status")
  New,

  @doc("InProgress status")
  InProgress,

  @doc("Canceled status")
  Completed,

  @doc("Failed status")
  Failed,
}

//------------------- Solution Type -------------------

@added(Versions.v2023_04_01)
@removed(Versions.v2023_12_01)
model SolutionTypeResource is ProxyResource<SolutionTypeProperties> {
  @doc("Solution Type resource")
  @segment("solutionTypes")
  @key("solutionTypes")
  @path
  name: string;
}

@added(Versions.v2023_04_01)
@removed(Versions.v2023_12_01)
@doc("Represent Solution type resource.")
model SolutionTypeProperties {
  @doc("The name of the solution type.")
  solutionType?: string;

  @doc("Short description of solution type")
  description?: string;

  @doc("The link to AWS CloudFormation template.")
  awsIamConfigurationTemplateUri?: string;

  @doc("The link to GCP script.")
  gcpProjectConfigurationTemplateUri?: string;

  @doc("The locations this solution is supported")
  supportedAzureRegions?: string[];

  @doc("The resource provisioning state.")
  provisioningState?: ProvisioningState;
}

//------------------- Inventory -------------------

@added(Versions.v2023_04_01)
@removed(Versions.v2023_12_01)
@parentResource(SolutionConfiguration)
model InventoryResource is ProxyResource<InventoryProperties> {
  @doc("Inventory resource")
  @segment("inventoryId")
  @key("inventory")
  @visibility("read")
  @path
  name: string;
}

@added(Versions.v2023_04_01)
@removed(Versions.v2023_12_01)
@doc("Definition of inventory.")
model InventoryProperties {
  @doc("Gets or sets the cloud native resource type.")
  cloudNativeType?: CloudNativeType;

  @doc("Gets or sets the cloud native resource name.")
  cloudNativeResourceId?: string;

  @doc("Gets or sets the mapped azure resource id.")
  azureResourceId?: string;

  @doc("Gets or sets the status of the inventory.")
  status?: SolutionConfigurationStatus;

  @doc("Gets or sets the status details.")
  statusDetails?: string;

  @doc("The resource provisioning state.")
  provisioningState?: ProvisioningState;
}

@added(Versions.v2023_04_01)
@removed(Versions.v2023_12_01)
@doc("Cloud Native Type enum.")
enum CloudNativeType {
  @doc("ec2 enum.")
  ec2,
}

//------------------- Shared -------------------

@added(Versions.v2023_04_01)
@removed(Versions.v2023_12_01)
@doc("Provisioning State.")
enum ProvisioningState {
  @doc("Succeeded state")
  Succeeded,

  @doc("Failed state")
  Failed,

  @doc("Canceled state")
  Canceled,
}


@doc("Solution settings")
model SolutionSettings is Record<string>;

//---------------------------------------------- Operations ----------------------------------------------

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Need to remove autoroute"
@added(Versions.v2023_12_01)
@route("/subscriptions/{subscriptionId}/providers/Microsoft.HybridConnectivity/")
interface GenerateAwsTemplate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Need to remove autoroute"
  @route("generateAwsTemplate")
  @post
  @action
  @tag("GenerateAwsTemplate")
  @doc("Retrieve AWS Cloud Formation template")
  post(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @doc("ConnectorId and SolutionTypes and their properties to Generate AWS CFT Template.")
    @body
    generateAwsTemplateRequest: GenerateAwsTemplateRequest,
  ): Azure.ResourceManager.ArmResponse<{}> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Need to remove autoroute"
@added(Versions.v2023_12_01)
@route("/subscriptions/{subscriptionId}/providers/Microsoft.HybridConnectivity/publicCloudConnectors/{publicCloudConnectorId}")
interface TestPermissions {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Need to remove autoroute"
  @route("testPermissions")
  @post
  @action
  @tag("TestPermissions")
  @doc("Test permissions of solution configurations of a connector.")
  post(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @doc("ConnectorId to check permissions of.")
    publicCloudConnectorId: string,
  ): Azure.ResourceManager.ArmAcceptedLroResponse<"Asynchronous operation in progress."> | TestPermissionResponse | Azure.ResourceManager.ErrorResponse;
}

@added(Versions.v2023_04_01)
@removed(Versions.v2023_12_01)
@armResourceOperations
interface PublicCloudConnectors {
  get is ArmResourceRead<PublicCloudConnector>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PublicCloudConnector>;
  update is ArmResourcePatchSync<
    PublicCloudConnector,
    PublicCloudConnectorProperties
  >;
  delete is ArmResourceDeleteSync<PublicCloudConnector>;
  listByResourceGroup is ArmResourceListByParent<PublicCloudConnector>;
  listBySubscription is ArmListBySubscription<PublicCloudConnector>;
}

@added(Versions.v2023_04_01)
@removed(Versions.v2023_12_01)
@armResourceOperations
interface SolutionConfigurations {
  get is ArmResourceRead<SolutionConfiguration>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SolutionConfiguration>;
  update is ArmResourcePatchSync<
    SolutionConfiguration,
    SolutionConfigurationProperties
  >;
  delete is ArmResourceDeleteSync<SolutionConfiguration>;
  listBySubscription is ArmListBySubscription<SolutionConfiguration>;
}

@added(Versions.v2023_04_01)
@removed(Versions.v2023_12_01)
@armResourceOperations
interface Inventory {
  get is ArmResourceRead<InventoryResource>;
  listByWidget is ArmResourceListByParent<InventoryResource>;
}

@added(Versions.v2023_04_01)
@removed(Versions.v2023_12_01)
@armResourceOperations
interface SolutionTypes {
  get is ArmResourceRead<SolutionTypeResource>;
  listByWidget is ArmResourceListAtScope<SolutionTypeResource>;
}
