import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace DeploymentScriptsClient;

/**
 * Type of the managed identity.
 */
union ManagedServiceIdentityType {
  string,

  /**
   * User assigned identity.
   */
  UserAssigned: "UserAssigned",
}

/**
 * Type of the script.
 */
union ScriptType {
  string,

  /**
   * Azure PowerShell script.
   */
  AzurePowerShell: "AzurePowerShell",

  /**
   * Azure CLI script.
   */
  AzureCLI: "AzureCLI",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * Created by user
   */
  User: "User",

  /**
   * Created by Application
   */
  Application: "Application",

  /**
   * Created by Managed Identity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Created By Key
   */
  Key: "Key",
}

/**
 * The clean up preference when the script execution gets in a terminal state. Default setting is 'Always'.
 */
union CleanupOptions {
  string,

  /**
   * Always clean up the resources created by the script execution.
   */
  Always: "Always",

  /**
   * Clean up the resources created by the script execution only if the script execution is successful.
   */
  OnSuccess: "OnSuccess",

  /**
   * Clean up the resources created by the script execution only on expiration.
   */
  OnExpiration: "OnExpiration",
}

/**
 * State of the script execution. This only appears in the response.
 */
union ScriptProvisioningState {
  string,

  /**
   * The script is being created.
   */
  Creating: "Creating",

  /**
   * The script is provisioning resources.
   */
  ProvisioningResources: "ProvisioningResources",

  /**
   * The script is running.
   */
  Running: "Running",

  /**
   * The script execution is succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * The script execution has failed.
   */
  Failed: "Failed",

  /**
   * The script was canceled.
   */
  Canceled: "Canceled",
}

/**
 * Describes the managed identities for an Azure resource.
 */
model ManagedServiceIdentity {
  /**
   * Type of the managed identity.
   */
  type?: ManagedServiceIdentityType;

  /**
   * The tenant id of the managed identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The list of user-assigned managed identities associated with the resource. Key is the Azure resource Id of the managed identity.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * User-assigned managed identity.
 */
model UserAssignedIdentity {
  /**
   * Azure Active Directory principal ID associated with this identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * Client App Id associated with this identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Common properties for all Azure resources.
 */
model AzureResourceBase {
  /**
   * String Id used to locate any resource on Azure.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of this resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Type of this resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Deployment scripts error response.
 */
@error
model DeploymentScriptsError {
  /**
   * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.)
   */
  error?: Azure.ResourceManager.CommonTypes.ErrorResponse;
}

/**
 * Deployment script parameters to be updated.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "For backward compatibility"
model DeploymentScriptUpdateParameter extends AzureResourceBase {
  /**
   * Resource tags to be updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Deployment script execution logs.
 */
model ScriptLogsList {
  /**
   * Deployment scripts logs.
   */
  value?: ScriptLog[];
}

/**
 * Script log properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model LogProperties {
  /**
   * Script execution logs in text format.
   */
  @visibility(Lifecycle.Read)
  log?: string;
}

/**
 * Object model for the Azure PowerShell script.
 */
model AzurePowerShellScript extends DeploymentScript {
  /**
   * Properties of the Azure PowerShell script object.
   */
  properties: AzurePowerShellScriptProperties;

  /**
   * Type of the script.
   */
  kind: "AzurePowerShell";
}

/**
 * Properties of the Azure PowerShell script object.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Discriminator is on enclosing model."
model AzurePowerShellScriptProperties extends DeploymentScriptPropertiesBase {
  /**
   * Azure PowerShell module version to be used.
   */
  azPowerShellVersion: string;
}

/**
 * Common properties for the deployment script.
 */
model DeploymentScriptPropertiesBase {
  ...ScriptConfigurationBase;

  /**
   * Container settings.
   */
  containerSettings?: ContainerConfiguration;

  /**
   * Storage Account settings.
   */
  storageAccountSettings?: StorageAccountConfiguration;

  /**
   * The clean up preference when the script execution gets in a terminal state. Default setting is 'Always'.
   */
  cleanupPreference?: CleanupOptions = CleanupOptions.Always;

  /**
   * State of the script execution. This only appears in the response.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ScriptProvisioningState;

  /**
   * Contains the results of script execution.
   */
  @visibility(Lifecycle.Read)
  status?: ScriptStatus;

  /**
   * List of script outputs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  outputs?: Record<unknown>;
}

/**
 * Settings to customize ACI container instance.
 */
model ContainerConfiguration {
  /**
   * Container group name, if not specified then the name will get auto-generated. Not specifying a 'containerGroupName' indicates the system to generate a unique name which might end up flagging an Azure Policy as non-compliant. Use 'containerGroupName' when you have an Azure Policy that expects a specific naming convention or when you want to fully control the name. 'containerGroupName' property must be between 1 and 63 characters long, must contain only lowercase letters, numbers, and dashes and it cannot start or end with a dash and consecutive dashes are not allowed. To specify a 'containerGroupName', add the following object to properties: { "containerSettings": { "containerGroupName": "contoso-container" } }. If you do not want to specify a 'containerGroupName' then do not add 'containerSettings' property.
   */
  @maxLength(63)
  @minLength(1)
  containerGroupName?: string;

  /**
   * The subnet resource IDs for a container group.
   */
  @added(Versions.v2023_08_01)
  @OpenAPI.extension("x-ms-identifiers", #["id"])
  subnetIds?: ContainerGroupSubnetId[];
}

/**
 * Container group subnet information.
 */
@added(Versions.v2023_08_01)
model ContainerGroupSubnetId {
  /**
   * Resource ID of subnet.
   */
  id: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Friendly name for the subnet.
   */
  name?: string;
}

/**
 * Settings to use an existing storage account. Valid storage account kinds are: Storage, StorageV2 and FileStorage
 */
model StorageAccountConfiguration {
  /**
   * The storage account name.
   */
  storageAccountName?: string;

  /**
   * The storage account access key.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Legacy"
  @extension("x-ms-secret", true)
  storageAccountKey?: string;
}

/**
 * Generic object modeling results of script execution.
 */
model ScriptStatus {
  /**
   * ACI resource Id.
   */
  @visibility(Lifecycle.Read)
  containerInstanceId?: string;

  /**
   * Storage account resource Id.
   */
  @visibility(Lifecycle.Read)
  storageAccountId?: string;

  /**
   * Start time of the script execution.
   */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /**
   * End time of the script execution.
   */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /**
   * Time the deployment script resource will expire.
   */
  @visibility(Lifecycle.Read)
  expirationTime?: utcDateTime;

  /**
   * Error that is relayed from the script execution.
   */
  error?: Azure.ResourceManager.CommonTypes.ErrorResponse;
}

/**
 * Common configuration settings for both Azure PowerShell and Azure CLI scripts.
 */
model ScriptConfigurationBase {
  /**
   * Uri for the script. This is the entry point for the external script.
   */
  primaryScriptUri?: string;

  /**
   * Supporting files for the external script.
   */
  supportingScriptUris?: string[];

  /**
   * Script body.
   */
  scriptContent?: string;

  /**
   * Command line arguments to pass to the script. Arguments are separated by spaces. ex: -Name blue* -Location 'West US 2'
   */
  arguments?: string;

  /**
   * The environment variables to pass over to the script.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  environmentVariables?: EnvironmentVariable[];

  /**
   * Gets or sets how the deployment script should be forced to execute even if the script resource has not changed. Can be current time stamp or a GUID.
   */
  forceUpdateTag?: string;

  /**
   * Interval for which the service retains the script resource after it reaches a terminal state. Resource will be deleted when this duration expires. Duration is based on ISO 8601 pattern (for example P1D means one day).
   */
  retentionInterval: duration;

  /**
   * Maximum allowed script execution time specified in ISO 8601 format. Default value is P1D
   */
  timeout?: duration;
}

/**
 * The environment variable to pass to the script in the container instance.
 */
model EnvironmentVariable {
  /**
   * The name of the environment variable.
   */
  name: string;

  /**
   * The value of the environment variable.
   */
  value?: string;

  /**
   * The value of the secure environment variable.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Legacy"
  @extension("x-ms-secret", true)
  secureValue?: string;
}

/**
 * Object model for the Azure CLI script.
 */
model AzureCliScript extends DeploymentScript {
  /**
   * Properties of the Azure CLI script object.
   */
  properties: AzureCliScriptProperties;

  /**
   * Type of the script.
   */
  kind: "AzureCLI";
}

/**
 * Properties of the Azure CLI script object.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Discriminator is on enclosing model."
model AzureCliScriptProperties extends DeploymentScriptPropertiesBase {
  /**
   * Azure CLI module version to be used.
   */
  azCliVersion: string;
}
