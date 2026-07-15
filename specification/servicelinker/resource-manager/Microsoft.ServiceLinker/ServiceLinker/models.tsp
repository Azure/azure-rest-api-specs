import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ServiceLinker;

/**
 * The name of action for you dryrun job.
 */
union DryrunActionName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate: "createOrUpdate",
}

/**
 * The type of dryrun result.
 */
union DryrunPrerequisiteResultType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  basicError: "basicError",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  permissionsMissing: "permissionsMissing",
}

/**
 * The operation type
 */
union DryrunPreviewOperationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  configConnection: "configConnection",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  configNetwork: "configNetwork",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  configAuth: "configAuth",
}

/**
 * The target service type.
 */
union TargetServiceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureResource: "AzureResource",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ConfluentBootstrapServer: "ConfluentBootstrapServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ConfluentSchemaRegistry: "ConfluentSchemaRegistry",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SelfHostedServer: "SelfHostedServer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FabricPlatform: "FabricPlatform",
}

/**
 * The authentication type.
 */
union AuthType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  systemAssignedIdentity: "systemAssignedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentity: "userAssignedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalSecret: "servicePrincipalSecret",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servicePrincipalCertificate: "servicePrincipalCertificate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  secret: "secret",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accessKey: "accessKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAccount: "userAccount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  easyAuthMicrosoftEntraID: "easyAuthMicrosoftEntraID",
}

/**
 * Indicates how to apply the authentication configuration operations.
 */
union AuthMode {
  string,

  /**
   * Default authentication configuration according to the authentication type.
   */
  optInAllAuth: "optInAllAuth",

  /**
   * Skip all authentication configuration such as enabling managed identity and granting RBAC roles
   */
  optOutAllAuth: "optOutAllAuth",
}

/**
 * The application client type
 */
union ClientType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  none: "none",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dotnet: "dotnet",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  java: "java",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  python: "python",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  go: "go",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  php: "php",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ruby: "ruby",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  django: "django",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nodejs: "nodejs",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  springBoot: "springBoot",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `kafka-springBoot`: "kafka-springBoot",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `jms-springBoot`: "jms-springBoot",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dapr: "dapr",
}

/**
 * Type of VNet solution.
 */
union VNetSolutionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceEndpoint: "serviceEndpoint",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateLink: "privateLink",
}

/**
 * The cleanup behavior to indicate whether clean up operation when resource is deleted or updated
 */
union DeleteOrUpdateBehavior {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ForcedCleanup: "ForcedCleanup",
}

/**
 * Whether to allow firewall rules.
 */
union AllowType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `true`: "true",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `false`: "false",
}

/**
 * The value indicating whether the metadata is required or not
 */
union DaprMetadataRequired {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `true`: "true",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `false`: "false",
}

/**
 * The direction supported by the dapr binding component
 */
union DaprBindingComponentDirection {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  input: "input",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  output: "output",
}

/**
 * The result of validation
 */
union ValidationResultStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  success: "success",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  failure: "failure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  warning: "warning",
}

/**
 * Type of configuration to determine whether the configuration can be modified after creation. KeyvaultSecret means the configuration references a key vault secret, such as App Service/ACA key vault reference. Default means the configuration is real value, such as user name, raw secret, etc.
 */
union LinkerConfigurationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  KeyVaultSecret: "KeyVaultSecret",
}

/**
 * The type of secret source.
 */
union SecretSourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rawValue: "rawValue",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keyVaultSecret: "keyVaultSecret",
}

/**
 * The azure resource type.
 */
union AzureResourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  KeyVault: "KeyVault",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AppConfig: "AppConfig",
}

/**
 * The secret type.
 */
union SecretType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rawValue: "rawValue",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keyVaultSecretUri: "keyVaultSecretUri",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keyVaultSecretReference: "keyVaultSecretReference",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AccessKeyPermissions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Read: "Read",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Write: "Write",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Listen: "Listen",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Send: "Send",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Manage: "Manage",
}

/**
 * Describes a page of resource object.
 * @template Resource The resource type.
 */
@friendlyName("Paged{name}", Resource)
@doc("Paged collection of {name} items", Resource)
model CustomPage<Resource extends TypeSpec.Reflection.Model> {
  @doc("The {name} items on this page", Resource)
  @pageItems
  value?: Resource[];

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<Resource> | null;
}

/**
 * The list of dryrun.
 */
model DryrunList is CustomPage<DryrunResource>;

/**
 * The properties of the dryrun job
 */
model DryrunProperties {
  /**
   * The parameters of the dryrun
   */
  parameters?: DryrunParameters;

  /**
   * the result of the dryrun
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  prerequisiteResults?: DryrunPrerequisiteResult[];

  /**
   * the preview of the operations for creation
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  operationPreviews?: DryrunOperationPreview[];

  /**
   * The provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * The parameters of the dryrun
 */
@discriminator("actionName")
model DryrunParameters {
  /**
   * The name of action for you dryrun job.
   */
  actionName: DryrunActionName;
}

/**
 * A result of dryrun
 */
@discriminator("type")
model DryrunPrerequisiteResult {
  /**
   * The type of dryrun result.
   */
  type: DryrunPrerequisiteResultType;
}

/**
 * The preview of the operations for creation
 */
model DryrunOperationPreview {
  /**
   * The operation name
   */
  name?: string;

  /**
   * The operation type
   */
  operationType?: DryrunPreviewOperationType;

  /**
   * The description of the operation
   */
  description?: string;

  /**
   * The action defined by RBAC, refer https://docs.microsoft.com/azure/role-based-access-control/role-definitions#actions-format
   */
  action?: string;

  /**
   * The scope of the operation, refer https://docs.microsoft.com/azure/role-based-access-control/scope-overview
   */
  scope?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * a dryrun job to be updated.
 */
model DryrunPatch {
  /**
   * The properties of the dryrun job.
   */
  properties?: DryrunProperties;
}

/**
 * The list of Linker.
 */
model ResourceList is CustomPage<LinkerResource>;

/**
 * The properties of the Linker.
 */
model LinkerProperties {
  /**
   * The target service properties
   */
  targetService?: TargetServiceBase;

  /**
   * The authentication type.
   */
  authInfo?: AuthInfoBase;

  /**
   * The application client type
   */
  clientType?: ClientType;

  /**
   * The provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The VNet solution.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vNetSolution?: VNetSolution | null;

  /**
   * An option to store secret value in secure place
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  secretStore?: SecretStore | null;

  /**
   * connection scope in source service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  scope?: string | null;

  /**
   * The network solution.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicNetworkSolution?: PublicNetworkSolution | null;

  /**
   * The connection information consumed by applications, including secrets, connection strings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  configurationInfo?: ConfigurationInfo | null;
}

/**
 * The target service properties
 */
@discriminator("type")
model TargetServiceBase {
  /**
   * The target service type.
   */
  type: TargetServiceType;
}

/**
 * The authentication info
 */
@discriminator("authType")
model AuthInfoBase {
  /**
   * The authentication type.
   */
  authType: AuthType;

  /**
   * Optional. Indicates how to configure authentication. If optInAllAuth, service linker configures authentication such as enabling identity on source resource and granting RBAC roles. If optOutAllAuth, opt out authentication setup. Default is optInAllAuth.
   */
  authMode?: AuthMode;
}

/**
 * The VNet solution for linker
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VNetSolution {
  /**
   * Type of VNet solution.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: VNetSolutionType | null;

  /**
   * Indicates whether to clean up previous operation when Linker is updating or deleting
   */
  deleteOrUpdateBehavior?: DeleteOrUpdateBehavior;
}

/**
 * An option to store secret value in secure place
 */
model SecretStore {
  /**
   * The key vault id to store secret
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keyVaultId?: string | null;

  /**
   * The key vault secret name to store secret, only valid when storing one secret
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keyVaultSecretName?: string | null;
}

/**
 * Indicates public network solution, include firewall rules
 */
model PublicNetworkSolution {
  /**
   * Indicates whether to clean up previous operation(such as firewall rules) when Linker is updating or deleting
   */
  deleteOrUpdateBehavior?: DeleteOrUpdateBehavior;

  /**
   * Indicates how to apply the connector operations, such as opt out network configuration, opt in configuration.
   */
  action?: ActionType;

  /**
   * Describe firewall rules of target service to make sure source application could connect to the target.
   */
  firewallRules?: FirewallRules;
}

/**
 * Target service's firewall rules. to allow connections from source service.
 */
model FirewallRules {
  /**
   * This value specifies the set of IP addresses or IP address ranges in CIDR form to be included as the allowed list of client IPs for a given database account.
   */
  ipRanges?: string[];

  /**
   * Allow Azure services to access the target service if true.
   */
  azureServices?: AllowType;

  /**
   * Allow caller client IP to access the target service if true. the property is used when connecting local application to target service.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  callerClientIP?: AllowType;
}

/**
 * The configuration information, used to generate configurations or save to applications
 */
model ConfigurationInfo {
  /**
   * Indicates whether to clean up previous operation when Linker is updating or deleting
   */
  deleteOrUpdateBehavior?: DeleteOrUpdateBehavior;

  /**
   * Indicates how to apply the connector operations, such as opt out network configuration, opt in configuration.
   */
  action?: ActionType;

  /**
   * Optional. A dictionary of default key name and customized key name mapping. If not specified, default key name will be used for generate configurations
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customizedKeys?: Record<string>;

  /**
   * Indicates some additional properties for dapr client type
   */
  daprProperties?: DaprProperties;

  /**
   * A dictionary of additional configurations to be added. Service will auto generate a set of basic configurations and this property is to full fill more customized configurations
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalConfigurations?: Record<string>;

  /**
   * A dictionary of additional properties to be added in the end of connection string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalConnectionStringProperties?: Record<string>;

  /**
   * An option to store configuration into different place
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  configurationStore?: ConfigurationStore | null;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ActionType {
  /** Actions are for internal-only APIs. */
  enable: "enable",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  optOut: "optOut",
  string,
}
/**
 * Indicates some additional properties for dapr client type
 */
model DaprProperties {
  /**
   * The dapr component version
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  version?: string | null;

  /**
   * The dapr component type
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  componentType?: string | null;

  /**
   * The name of a secret store dapr to retrieve secret
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  secretStoreComponent?: string | null;

  /**
   * Additional dapr metadata
   */
  @identifiers(#["name"])
  metadata?: DaprMetadata[];

  /**
   * The dapr component scopes
   */
  scopes?: string[];

  /**
   * The runtime version supported by the properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  runtimeVersion?: string | null;

  /**
   * The direction supported by the dapr binding component
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  bindingComponentDirection?: DaprBindingComponentDirection | null;
}

/**
 * The dapr component metadata.
 */
model DaprMetadata {
  /**
   * Metadata property name.
   */
  name?: string;

  /**
   * Metadata property value.
   */
  value?: string;

  /**
   * The secret name where dapr could get value
   */
  secretRef?: string;

  /**
   * The description of the metadata, returned from configuration api
   */
  description?: string;

  /**
   * The value indicating whether the metadata is required or not
   */
  required?: DaprMetadataRequired;
}

/**
 * An option to store configuration into different place
 */
model ConfigurationStore {
  /**
   * The app configuration id to store configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  appConfigurationId?: string | null;
}

/**
 * A Linker to be updated.
 */
model LinkerPatch {
  /**
   * Linker properties
   */
  properties?: LinkerProperties;
}

/**
 * The validation operation result for a Linker.
 */
model ValidateOperationResult {
  /**
   * The validation result detail.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ValidateResult | null;

  /**
   * Validated Linker id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceId?: string | null;

  /**
   * Validation operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  status?: string | null;
}

/**
 * The validation result for a Linker.
 */
model ValidateResult {
  /**
   * The linker name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  linkerName?: string | null;

  /**
   * A boolean value indicating whether the connection is available or not
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  isConnectionAvailable?: boolean | null;

  /**
   * The start time of the validation report.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  reportStartTimeUtc?: utcDateTime | null;

  /**
   * The end time of the validation report.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  reportEndTimeUtc?: utcDateTime | null;

  /**
   * The resource id of the Linker source application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceId?: string | null;

  /**
   * The resource Id of target service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetId?: string | null;

  /**
   * The authentication type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authType?: AuthType | null;

  /**
   * The detail of validation result
   */
  @identifiers(#["name"])
  validationDetail?: ValidationResultItem[];
}

/**
 * The validation item for a Linker.
 */
model ValidationResultItem {
  /**
   * The validation item name.
   */
  name?: string;

  /**
   * The display name of validation item
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string | null;

  /**
   * The result of validation
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  result?: ValidationResultStatus | null;

  /**
   * The error message of validation result
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  errorMessage?: string | null;

  /**
   * The error code of validation result
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  errorCode?: string | null;
}

/**
 * Configurations for source resource, include appSettings, connectionString and serviceBindings
 */
model ConfigurationResult {
  /**
   * The configuration properties for source resource.
   */
  @identifiers(#["name"])
  configurations?: SourceConfiguration[];
}

/**
 * A configuration item for source resource
 */
model SourceConfiguration {
  /**
   * The name of setting.
   */
  name?: string;

  /**
   * The value of setting
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: string | null;

  /**
   * The type of setting
   */
  @visibility(Lifecycle.Read)
  configType?: LinkerConfigurationType;

  /**
   * The identity for key vault reference, system or user-assigned managed identity ID
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keyVaultReferenceIdentity?: string | null;

  /**
   * Descriptive information for the configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string | null;
}

/**
 * Configuration Name list which will be set based on different target resource, client type, auth type.
 */
model ConfigurationNameResult is Azure.Core.Page<ConfigurationNameItem>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConfigurationNameItem {
  /**
   * The result detail.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ConfigurationNames | null;
}

/**
 * The configuration names which will be set based on specific target resource, client type, auth type.
 */
model ConfigurationNames {
  /**
   * The target service provider name and resource name.
   */
  targetService?: string;

  /**
   * The client type for configuration names.
   */
  clientType?: ClientType;

  /**
   * The auth type.
   */
  authType?: AuthType;

  /**
   * Indicates where the secrets in configuration from. Used when secrets are from Keyvault.
   */
  secretType?: SecretSourceType;

  /**
   * Deprecated, please use #/definitions/DaprConfigurationList instead
   */
  daprProperties?: DaprProperties;

  /**
   * The configuration names to be set in compute service environment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  names?: ConfigurationName[];
}

/**
 * The configuration names.
 */
model ConfigurationName {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: string;

  /**
   * Description for the configuration name.
   */
  description?: string;

  /**
   * Represent the configuration is required or not
   */
  required?: boolean;
}

/**
 * Dapr configuration list supported by Service Connector
 */
model DaprConfigurationList is Azure.Core.Page<DaprConfigurationResource>;

/**
 * Represent one resource of the dapr configuration list
 */
model DaprConfigurationResource {
  /**
   * The properties of the dapr configuration.
   */
  properties?: DaprConfigurationProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DaprConfigurationProperties {
  /**
   * Supported target resource type, extract from resource id, uppercase
   */
  targetType?: string;

  /**
   * The authentication type.
   */
  authType?: AuthType;

  /**
   * Indicates some additional properties for dapr client type
   */
  daprProperties?: DaprProperties;
}

/**
 * The azure resource properties
 */
@discriminator("type")
model AzureResourcePropertiesBase {
  /**
   * The azure resource type.
   */
  type: AzureResourceType;
}

/**
 * The azure resource info when target service type is AzureResource
 */
model AzureResource extends TargetServiceBase {
  /**
   * The Id of azure resource.
   */
  id?: string;

  /**
   * The azure resource connection related properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceProperties?: AzureResourcePropertiesBase | null;

  /**
   * The target service type.
   */
  type: "AzureResource";
}

/**
 * The resource properties when type is Azure Key Vault
 */
model AzureKeyVaultProperties extends AzureResourcePropertiesBase {
  /**
   * True if connect via Kubernetes CSI Driver.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectAsKubernetesCsiDriver?: boolean | null;

  /**
   * The azure resource type.
   */
  type: "KeyVault";
}

/**
 * The resource properties when type is Azure App Configuration
 */
model AzureAppConfigProperties extends AzureResourcePropertiesBase {
  /**
   * True if connection enables app configuration kubernetes extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectWithKubernetesExtension?: boolean | null;

  /**
   * The azure resource type.
   */
  type: "AppConfig";
}

/**
 * The service properties when target service type is ConfluentBootstrapServer
 */
model ConfluentBootstrapServer extends TargetServiceBase {
  /**
   * The endpoint of service.
   */
  endpoint?: string;

  /**
   * The target service type.
   */
  type: "ConfluentBootstrapServer";
}

/**
 * The service properties when target service type is FabricPlatform
 */
model FabricPlatform extends TargetServiceBase {
  /**
   * The endpoint of service.
   */
  endpoint?: string;

  /**
   * The target service type.
   */
  type: "FabricPlatform";
}

/**
 * The service properties when target service type is SelfHostedServer
 */
model SelfHostedServer extends TargetServiceBase {
  /**
   * The endpoint of service.
   */
  endpoint?: string;

  /**
   * The target service type.
   */
  type: "SelfHostedServer";
}

/**
 * The service properties when target service type is ConfluentSchemaRegistry
 */
model ConfluentSchemaRegistry extends TargetServiceBase {
  /**
   * The endpoint of service.
   */
  endpoint?: string;

  /**
   * The target service type.
   */
  type: "ConfluentSchemaRegistry";
}

/**
 * The secret info
 */
@discriminator("secretType")
model SecretInfoBase {
  /**
   * The secret type.
   */
  secretType: SecretType;
}

/**
 * The secret info when type is rawValue. It's for scenarios that user input the secret.
 */
model ValueSecretInfo extends SecretInfoBase {
  /**
   * The actual value of the secret.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  value?: string | null;

  /**
   * The secret type.
   */
  secretType: "rawValue";
}

/**
 * The secret info when type is keyVaultSecretReference. It's for scenario that user provides a secret stored in user's keyvault and source is Azure Kubernetes. The key Vault's resource id is linked to secretStore.keyVaultId.
 */
model KeyVaultSecretReferenceSecretInfo extends SecretInfoBase {
  /**
   * Name of the Key Vault secret.
   */
  name?: string;

  /**
   * Version of the Key Vault secret.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  version?: string | null;

  /**
   * The secret type.
   */
  secretType: "keyVaultSecretReference";
}

/**
 * The secret info when type is keyVaultSecretUri. It's for scenario that user provides a secret stored in user's keyvault and source is Web App, Spring Cloud or Container App.
 */
model KeyVaultSecretUriSecretInfo extends SecretInfoBase {
  /**
   * URI to the keyvault secret
   */
  value?: string;

  /**
   * The secret type.
   */
  secretType: "keyVaultSecretUri";
}

/**
 * The access key directly from target resource properties, which target service is Azure Resource, such as Microsoft.Storage
 */
model AccessKeyInfoBase extends AuthInfoBase {
  /**
   * Permissions of the accessKey. `Read` and `Write` are for Azure Cosmos DB and Azure App Configuration, `Listen`, `Send` and `Manage` are for Azure Event Hub and Azure Service Bus.
   */
  permissions?: AccessKeyPermissions[];

  /**
   * The authentication type.
   */
  authType: "accessKey";
}

/**
 * The extra auth info required by Database AAD authentication.
 */
model DatabaseAadAuthInfo {
  /**
   * Username created in the database which is mapped to a user in AAD.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userName?: string | null;
}

/**
 * The authentication info when authType is secret
 */
model SecretAuthInfo extends AuthInfoBase {
  /**
   * Username or account name for secret auth.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string | null;

  /**
   * Password or key vault secret for secret auth.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  secretInfo?: SecretInfoBase | null;

  /**
   * The authentication type.
   */
  authType: "secret";
}

/**
 * The authentication info when authType is userAssignedIdentity
 */
model UserAssignedIdentityAuthInfo extends AuthInfoBase {
  ...DatabaseAadAuthInfo;

  /**
   * Client Id for userAssignedIdentity.
   */
  clientId?: string;

  /**
   * Subscription id for userAssignedIdentity.
   */
  subscriptionId?: string;

  /**
   * Indicates whether to clean up previous operation when Linker is updating or deleting
   */
  deleteOrUpdateBehavior?: DeleteOrUpdateBehavior;

  /**
   * Optional, this value specifies the Azure role to be assigned
   */
  roles?: string[];

  /**
   * The authentication type.
   */
  authType: "userAssignedIdentity";
}

/**
 * The authentication info when authType is systemAssignedIdentity
 */
model SystemAssignedIdentityAuthInfo extends AuthInfoBase {
  ...DatabaseAadAuthInfo;

  /**
   * Indicates whether to clean up previous operation when Linker is updating or deleting
   */
  deleteOrUpdateBehavior?: DeleteOrUpdateBehavior;

  /**
   * Optional, this value specifies the Azure role to be assigned
   */
  roles?: string[];

  /**
   * The authentication type.
   */
  authType: "systemAssignedIdentity";
}

/**
 * The authentication info when authType is servicePrincipal secret
 */
model ServicePrincipalSecretAuthInfo extends AuthInfoBase {
  ...DatabaseAadAuthInfo;

  /**
   * ServicePrincipal application clientId for servicePrincipal auth.
   */
  clientId: string;

  /**
   * Principal Id for servicePrincipal auth.
   */
  principalId: string;

  /**
   * Secret for servicePrincipal auth.
   */
  @secret
  secret: string;

  /**
   * Indicates whether to clean up previous operation when Linker is updating or deleting
   */
  deleteOrUpdateBehavior?: DeleteOrUpdateBehavior;

  /**
   * Optional, this value specifies the Azure roles to be assigned. Automatically
   */
  roles?: string[];

  /**
   * The authentication type.
   */
  authType: "servicePrincipalSecret";
}

/**
 * The authentication info when authType is servicePrincipal certificate
 */
model ServicePrincipalCertificateAuthInfo extends AuthInfoBase {
  /**
   * Application clientId for servicePrincipal auth.
   */
  clientId: string;

  /**
   * Principal Id for servicePrincipal auth.
   */
  principalId: string;

  /**
   * ServicePrincipal certificate for servicePrincipal auth.
   */
  @secret
  certificate: string;

  /**
   * Indicates whether to clean up previous operation when Linker is updating or deleting
   */
  deleteOrUpdateBehavior?: DeleteOrUpdateBehavior;

  /**
   * Optional, this value specifies the Azure roles to be assigned. Automatically
   */
  roles?: string[];

  /**
   * The authentication type.
   */
  authType: "servicePrincipalCertificate";
}

/**
 * The authentication info when authType is user account
 */
model UserAccountAuthInfo extends AuthInfoBase {
  ...DatabaseAadAuthInfo;

  /**
   * Principal Id for user account.
   */
  principalId?: string;

  /**
   * Indicates whether to clean up previous operation when Linker is updating or deleting
   */
  deleteOrUpdateBehavior?: DeleteOrUpdateBehavior;

  /**
   * Optional, this value specifies the Azure roles to be assigned. Automatically
   */
  roles?: string[];

  /**
   * The authentication type.
   */
  authType: "userAccount";
}

/**
 * The authentication info when authType is EasyAuth Microsoft Entra ID
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EasyAuthMicrosoftEntraIDAuthInfo extends AuthInfoBase {
  /**
   * Application clientId for EasyAuth Microsoft Entra ID.
   */
  clientId?: string;

  /**
   * Application Secret for EasyAuth Microsoft Entra ID.
   */
  @secret
  secret?: string;

  /**
   * Indicates whether to clean up previous operation when Linker is updating or deleting
   */
  deleteOrUpdateBehavior?: DeleteOrUpdateBehavior;

  /**
   * The authentication type.
   */
  authType: "easyAuthMicrosoftEntraID";
}

/**
 * The dryrun parameters for creation or update a linker
 */
model CreateOrUpdateDryrunParameters extends DryrunParameters {
  ...LinkerProperties;

  /**
   * The name of action for you dryrun job.
   */
  actionName: "createOrUpdate";
}

/**
 * The represent of basic error
 */
model BasicErrorDryrunPrerequisiteResult extends DryrunPrerequisiteResult {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The error message.
   */
  message?: string;

  /**
   * The type of dryrun result.
   */
  type: "basicError";
}

/**
 * The represent of missing permissions
 */
model PermissionsMissingDryrunPrerequisiteResult
  extends DryrunPrerequisiteResult {
  /**
   * The permission scope
   */
  scope?: string;

  /**
   * The permission list
   */
  permissions?: string[];

  /**
   * The recommended role to resolve permissions missing
   */
  recommendedRole?: string;

  /**
   * The type of dryrun result.
   */
  type: "permissionsMissing";
}
