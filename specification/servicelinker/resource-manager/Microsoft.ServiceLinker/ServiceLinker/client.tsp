import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceLinker;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

@@clientName(Linkers, "LinkersOperations", "java");
@@clientName(
  Microsoft.ServiceLinker,
  "ServiceLinkerManagementClient",
  "javascript"
);
@@clientName(
  Microsoft.ServiceLinker,
  "ServiceLinkerManagementClient",
  "python"
);

// Go SDK Breaking Changes Resolution for TypeSpec conversion
@@clientName(DatabaseAadAuthInfo, "DatabaseAADAuthInfo", "go");

@@clientName(ActionType, "ActionTypeFlag", "!autorest");

@@override(
  LinkerResources.get,
  reorderParameters(
    LinkerResources.get,
    #[
      "apiVersion",
      "subscriptionId",
      "resourceGroupName",
      "provider",
      "location",
      "connectorName"
    ]
  )
);

@@override(
  LinkerResources.createOrUpdate,
  reorderParameters(
    LinkerResources.createOrUpdate,
    #[
      "apiVersion",
      "subscriptionId",
      "resourceGroupName",
      "provider",
      "location",
      "connectorName",
      "resource"
    ]
  )
);

@@clientName(LinkerResources.createOrUpdate::parameters.resource, "parameters");

@@override(
  LinkerResources.update,
  reorderParameters(
    LinkerResources.update,
    #[
      "apiVersion",
      "subscriptionId",
      "resourceGroupName",
      "provider",
      "location",
      "connectorName",
      "properties"
    ]
  )
);

@@clientName(LinkerResources.update::parameters.properties, "parameters");

@@override(
  LinkerResources.delete,
  reorderParameters(
    LinkerResources.delete,
    #[
      "apiVersion",
      "subscriptionId",
      "resourceGroupName",
      "provider",
      "location",
      "connectorName"
    ]
  )
);

@@override(
  LinkerResources.list,
  reorderParameters(
    LinkerResources.list,
    #[
      "apiVersion",
      "subscriptionId",
      "resourceGroupName",
      "provider",
      "location"
    ]
  )
);

@@override(
  LinkerResources.validate,
  reorderParameters(
    LinkerResources.validate,
    #[
      "apiVersion",
      "subscriptionId",
      "resourceGroupName",
      "provider",
      "location",
      "connectorName",
      "body"
    ]
  )
);

@@override(
  LinkerResources.generateConfigurations,
  reorderParameters(
    LinkerResources.generateConfigurations,
    #[
      "apiVersion",
      "subscriptionId",
      "resourceGroupName",
      "provider",
      "location",
      "connectorName",
      "body"
    ]
  )
);

@@clientName(
  LinkerResources.generateConfigurations::parameters.body,
  "parameters"
);

@@override(
  DryrunResources.getDryrun,
  reorderParameters(
    DryrunResources.getDryrun,
    #[
      "apiVersion",
      "subscriptionId",
      "resourceGroupName",
      "provider",
      "location",
      "dryrunName"
    ]
  )
);

@@override(
  DryrunResources.createDryrun,
  reorderParameters(
    DryrunResources.createDryrun,
    #[
      "apiVersion",
      "subscriptionId",
      "resourceGroupName",
      "provider",
      "location",
      "dryrunName",
      "resource"
    ]
  )
);

@@clientName(DryrunResources.createDryrun::parameters.resource, "parameters");

@@override(
  DryrunResources.updateDryrun,
  reorderParameters(
    DryrunResources.updateDryrun,
    #[
      "apiVersion",
      "subscriptionId",
      "resourceGroupName",
      "provider",
      "location",
      "dryrunName",
      "properties"
    ]
  )
);

@@clientName(DryrunResources.updateDryrun::parameters.properties, "parameters");

@@override(
  DryrunResources.deleteDryrun,
  reorderParameters(
    DryrunResources.deleteDryrun,
    #[
      "apiVersion",
      "subscriptionId",
      "resourceGroupName",
      "provider",
      "location",
      "dryrunName"
    ]
  )
);

@@override(
  DryrunResources.listDryrun,
  reorderParameters(
    DryrunResources.listDryrun,
    #[
      "apiVersion",
      "subscriptionId",
      "resourceGroupName",
      "provider",
      "location"
    ]
  )
);

// C# customizations preserve the shipped SDK surface and disambiguate dry-run resources.
@@clientName(ActionType, "LinkerActionType", "csharp");
@@clientName(AllowType, "LinkerAllowType", "csharp");
@@clientName(AuthInfoBase, "AuthBaseInfo", "csharp");
@@clientName(AuthMode, "LinkerAuthMode", "csharp");
@@clientName(Microsoft.ServiceLinker.AuthType, "LinkerAuthType", "csharp");
@@clientName(
  AzureAppConfigProperties.connectWithKubernetesExtension,
  "IsConnectedWithKubernetesExtension",
  "csharp"
);
@@clientName(
  AzureKeyVaultProperties.connectAsKubernetesCsiDriver,
  "DoesConnectAsKubernetesCsiDriver",
  "csharp"
);
@@clientName(AzureResource, "AzureResourceInfo", "csharp");
@@clientName(
  AzureResourcePropertiesBase,
  "AzureResourceBaseProperties",
  "csharp"
);
@@clientName(ClientType, "LinkerClientType", "csharp");
@@clientName(ConfigurationInfo, "LinkerConfigurationInfo", "csharp");
@@clientName(ConfigurationName, "LinkerConfigurationName", "csharp");
@@clientName(ConfigurationName.required, "IsRequired", "csharp");
@@clientName(ConfigurationNameItem, "LinkerConfigurationNameItem", "csharp");
@@clientName(ConfigurationResult, "SourceConfigurationResult", "csharp");
@@clientName(
  ConfluentBootstrapServer,
  "ConfluentBootstrapServerInfo",
  "csharp"
);
@@clientName(ConfluentSchemaRegistry, "ConfluentSchemaRegistryInfo", "csharp");
@@clientName(
  CreateOrUpdateDryrunParameters,
  "CreateOrUpdateDryrunContent",
  "csharp"
);
@@clientName(DaprConfigurationResource, "DaprConfiguration", "csharp");
@@clientName(DeleteOrUpdateBehavior, "LinkerDeleteOrUpdateBehavior", "csharp");
@@clientName(DryrunParameters, "DryrunContent", "csharp");
@@clientName(DryrunResource, "LinkerDryrun", "csharp");
@@clientName(DryrunResources, "ConnectorDryruns", "csharp");
@@clientName(
  EasyAuthMicrosoftEntraIDAuthInfo,
  "EasyAuthMicrosoftEntraIdAuthInfo",
  "csharp"
);
@@clientName(FabricPlatform, "FabricPlatformTargetService", "csharp");
@@clientName(FirewallRules, "LinkerFirewallRules", "csharp");
@@clientName(Linker, "LinkerResources", "csharp");
@@clientName(LinkerPatch, "LinkerResourcePatch", "csharp");
@@clientName(LinkerResources, "LinkerConnectors", "csharp");
@@clientName(Linkers, "LinkerDryruns", "csharp");
@@clientName(PublicNetworkSolution, "LinkerPublicNetworkSolution", "csharp");
@@clientName(SecretInfoBase, "SecretBaseInfo", "csharp");
@@clientName(SecretSourceType, "LinkerSecretSourceType", "csharp");
@@clientName(SecretStore.keyVaultId, "SecretStoreKeyVaultId", "csharp");
@@clientName(SecretStore, "LinkerSecretStore", "csharp");
@@clientName(SecretType, "LinkerSecretType", "csharp");
@@clientName(SelfHostedServer, "SelfHostedServerTargetService", "csharp");
@@clientName(TargetServiceBase, "TargetServiceBaseInfo", "csharp");
@@clientName(
  ValidateOperationResult,
  "LinkerValidateOperationResult",
  "csharp"
);
@@clientName(ValidateResult.reportEndTimeUtc, "ReportEndOn", "csharp");
@@clientName(ValidateResult.reportStartTimeUtc, "ReportStartOn", "csharp");
@@clientName(ValidationResultItem, "LinkerValidationResultItemInfo", "csharp");
@@clientName(ValidationResultStatus, "LinkerValidationResultStatus", "csharp");
@@clientName(ValueSecretInfo, "RawValueSecretInfo", "csharp");
@@clientName(VNetSolution, "VnetSolution", "csharp");
@@clientName(VNetSolution.type, "SolutionType", "csharp");
@@clientName(VNetSolutionType, "VnetSolutionType", "csharp");

@@alternateType(AzureResource.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(
  SecretStore.keyVaultId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ValidateOperationResult.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ValidateResult.sourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ValidateResult.targetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  LinkerProperties.secretStore,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  LinkerProperties.vNetSolution,
  "csharp"
);
