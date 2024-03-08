import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../AzureDeployments.common/helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.Core.Traits;
using Microsoft.Resources.Deployments.Common;
using TypeSpec.OpenAPI;

namespace Microsoft.Resources.Deployments.DeploymentScripts;

@doc("The body of the request for the decompileBicep operation.")
model DecompileOperationRequest {
  @doc("The ARM json template to be decompiled into a Bicep file.")
  template: string;
}

@doc("The definition of a file along with its contents.")
model FileDefinition {
  @visibility("read")
  @doc("The path to the fille.")
  path: string;

  @visibility("read")
  @doc("The file contents.")
  contents: string;
}

@doc("The successful decompilation response.")
model DecompileOperationSuccessResponse {
  @visibility("read")
  @doc("An array of files decompiled from the ARM json template.")
  @extension("x-ms-identifiers", ["path"])
  files: FileDefinition[];

  @visibility("read")
  @doc("The file path to the main Bicep file generated from the decompiled ARM json template.")
  entryPoint: string;
}

@doc("The deploymentScripts resource.")
@resource("deploymentScripts")
@discriminator("kind")
model DeploymentScript is TrackedResource<DeploymentScriptPropertiesBase> {
  @doc("The name of the deploymentScripts resource.")
  @key("scriptName")
  @path
  @segment("deploymentScripts")
  @visibility("create", "read")
  name: string;

  @doc("Type of the script.")
  kind: ScriptType;
}

enum ScriptType {
  AzurePowerShell,
  AzureCLI,
}

enum CleanUpOptions {
  Always,
  OnSuccess,
  OnExpiration,
}

enum ScriptProvisioningState {
  Creating,
  ProvisioningResources,
  Running,
  Succeeded,
  Failed,
  Canceled,
}

@doc("Object model for the Azure PowerShell script.")
model AzurePowerShellScript extends DeploymentScript {
  @doc("Properties of the Azure PowerShell script object.")
  properties: AzurePowerShellScriptProperties;

  @doc("Type of the script.")
  kind: ScriptType.AzurePowerShell;
}

@doc("Object model for the Azure CLI script.")
model AzureCliScript extends DeploymentScript {
  @doc("Properties of the Azure CLI script object.")
  properties: AzureCliScriptProperties;

  @doc("Type of the script.")
  kind: ScriptType.AzureCLI;
}

@doc("Common properties for the deployment script.")
model DeploymentScriptPropertiesBase extends ScriptConfigurationBase {
  @doc("Container settings.")
  containerSettings: ContainerConfiguration;

  @doc("Storage Account settings.")
  storageAccountSettings: StorageAccountConfiguration;

  @doc("The clean up preference when the script execution gets in a terminal state. Default setting is 'Always'.")
  cleanupPreference: CleanUpOptions;

  @doc("State of the script execution. This only appears in the response.")
  @visibility("read")
  provisioningState: ScriptProvisioningState;

  @doc("Contains the results of script execution.")
  @visibility("read")
  status: ScriptStatus;

  @doc("List of script outputs.")
  @visibility("read")
  outputs: Record<unknown>;
}

@doc("Common configuration settings for both Azure PowerShell and Azure CLI scripts.")
model ScriptConfigurationBase {
  @doc("Uri for the script. This is the entry point for the external script.")
  primaryScriptUri: string;

  @doc("Supporting files for the external script.")
  supportingScriptUris: string[];

  @doc("Script body.")
  @maxLength(32000)
  scriptContent: string;

  @doc("Command line arguments to pass to the script. Arguments are separated by spaces. ex: -Name blue* -Location 'West US 2' ")
  arguments: string;

  @doc("The environment variables to pass over to the script.")
  @extension("x-ms-identifiers", ["name"])
  environmentVariables: EnvironmentVariable[];

  @doc("Gets or sets how the deployment script should be forced to execute even if the script resource has not changed. Can be current time stamp or a GUID.")
  forceUpdateTag: string;

  @doc("Interval for which the service retains the script resource after it reaches a terminal state. Resource will be deleted when this duration expires. Duration is based on ISO 8601 pattern (for example P1D means one day).")
  retentionInterval: duration;

  @doc("Maximum allowed script execution time specified in ISO 8601 format. Default value is P1D")
  timeout: duration;
}

@doc("Properties of the Azure PowerShell script object.")
model AzurePowerShellScriptProperties is DeploymentScriptPropertiesBase {
  @doc("Azure PowerShell module version to be used.")
  azPowerShellVersion: string;
}

@doc("Properties of the Azure CLI script object.")
model AzureCliScriptProperties is DeploymentScriptPropertiesBase {
  @doc("Azure CLI module version to be used.")
  azCliVersion: string;
}

@doc("Settings to customize ACI container instance.")
model ContainerConfiguration {
  @doc("Container group name, if not specified then the name will get auto-generated. Not specifying a 'containerGroupName' indicates the system to generate a unique name which might end up flagging an Azure Policy as non-compliant. Use 'containerGroupName' when you have an Azure Policy that expects a specific naming convention or when you want to fully control the name. 'containerGroupName' property must be between 1 and 63 characters long, must contain only lowercase letters, numbers, and dashes and it cannot start or end with a dash and consecutive dashes are not allowed. To specify a 'containerGroupName', add the following object to properties: { \"containerSettings\": { \"containerGroupName\": \"contoso-container\" } }. If you do not want to specify a 'containerGroupName' then do not add 'containerSettings' property.")
  @minLength(1)
  @maxLength(63)
  containerGroupName?: string;

  @doc("The subnet resource IDs for a container group.")
  @added(Versions.v2023_08_01)
  @extension("x-ms-identifiers", ["id"])
  subnetIds?: ContainerGroupSubnetId[];
}

@doc("Container group subnet information.")
@added(Versions.v2023_08_01)
model ContainerGroupSubnetId {
  @doc("Resource ID of subnet.")
  id: ResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets",
    }
  ]>;

  @doc("Friendly name for the subnet.")
  name?: string;
}

@doc("Settings to use an existing storage account. Valid storage account kinds are: Storage, StorageV2 and FileStorage")
model StorageAccountConfiguration {
  @doc("The storage account name.")
  storageAccountName?: string;

  @doc("The storage account access key.")
  @secret()
  storageAccountKey?: string;
}

@doc("The environment variable to pass to the script in the container instance.",)
model EnvironmentVariable {
  @doc("The name of the environment variable.")
  name: string;

  @doc("The value of the environment variable.")
  value?: string;

  @doc("The value of the secure environment variable.")
  @secret()
  secureValue?: string;
}

@doc("Generic object modeling results of script execution.")
model ScriptStatus {
  @doc("ACI resource Id.")
  @visibility("read")
  containerInstanceId?: string;

  @doc("Storage account resource Id.")
  @visibility("read")
  storageAccountId?: string;

  @doc("Start time of the script execution.")
  @visibility("read")
  startTime?: utcDateTime;

  @doc("End time of the script execution.")
  @visibility("read")
  endTime?: utcDateTime;

  @doc("Time the deployment script resource will expire.")
  @visibility("read")
  expirationTime?: utcDateTime;

  @doc("Error that is relayed from the script execution.")
  error?: ErrorResponse;
}

@armResourceOperations
interface DeploymentScripts {
  @doc("Gets a deployment script.")
  get is ArmResourceRead<DeploymentScript>;

  @doc("Creates or updates a deployment script.")
  create is ArmResourceCreateOrUpdateAsync<DeploymentScript>;

  @doc("Updates deployment script tags with specified values.")
  update is ArmCustomPatchSync<DeploymentScript>;

  @doc("Deletes a deployment script. When operation completes, status code 200 returned without content.")
  delete is ArmResourceDeleteSync<DeploymentScript>;

  @doc("Lists deployments scripts.")
  list is ArmResourceListAtScope<DeploymentScript>;
}

@armResourceOperations
interface DeploymentScriptLogs {
  @doc("Gets a deployment script log.")
  get is ArmResourceRead<ScriptLog>;

  @doc("Lists deployments script logs.")
  list is ArmResourceListByParent<ScriptLog>;
}

@parentResource(DeploymentScript)
@doc("Script execution log object.")
model ScriptLog is ProxyResource<LogProperties> {
  @doc("The name of the deploymentScripts resource.")
  @key("logName")
  @path
  @segment("deploymentScripts")
  name: string;
}

@doc("Script log properties.")
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Existing service"
model LogProperties {
  @doc("Script execution logs in text format.")
  @visibility("read")
  log?: string;
}