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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
op linkerResourcesGet(
  ...ApiVersionParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  @clientLocation(linkerResourcesGet, "java,python,go,javascript")
  @typeChangedFrom(Azure.ResourceManager.CommonTypes.Versions.v4, string)
  subscriptionId: Azure.Core.uuid,

  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  ...LocationParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  connectorName: string,
): LinkerResource;

@@override(LinkerResources.get, linkerResourcesGet);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
op linkerResourcesCreateOrUpdate(
  ...ApiVersionParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  @clientLocation(linkerResourcesCreateOrUpdate, "java,python,go,javascript")
  @typeChangedFrom(Azure.ResourceManager.CommonTypes.Versions.v4, string)
  subscriptionId: Azure.Core.uuid,

  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  ...LocationParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  connectorName: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  parameters: LinkerResource,
): LinkerResource;

@@override(LinkerResources.createOrUpdate, linkerResourcesCreateOrUpdate);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
op linkerResourcesUpdate(
  ...ApiVersionParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  @clientLocation(linkerResourcesUpdate, "java,python,go,javascript")
  @typeChangedFrom(Azure.ResourceManager.CommonTypes.Versions.v4, string)
  subscriptionId: Azure.Core.uuid,

  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  ...LocationParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  connectorName: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  parameters: LinkerPatch,
): LinkerResource;

@@override(LinkerResources.update, linkerResourcesUpdate);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
op linkerResourcesDelete(
  ...ApiVersionParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  @clientLocation(linkerResourcesDelete, "java,python,go,javascript")
  @typeChangedFrom(Azure.ResourceManager.CommonTypes.Versions.v4, string)
  subscriptionId: Azure.Core.uuid,

  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  ...LocationParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  connectorName: string,
): ArmDeletedNoContentResponse;

@@override(LinkerResources.delete, linkerResourcesDelete);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
op linkerResourcesList(
  ...ApiVersionParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  @clientLocation(linkerResourcesList, "java,python,go,javascript")
  @typeChangedFrom(Azure.ResourceManager.CommonTypes.Versions.v4, string)
  subscriptionId: Azure.Core.uuid,

  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  ...LocationParameter,
): ResourceList;

@@override(LinkerResources.list, linkerResourcesList);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
op linkerResourcesValidate(
  ...ApiVersionParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  @clientLocation(linkerResourcesValidate, "java,python,go,javascript")
  @typeChangedFrom(Azure.ResourceManager.CommonTypes.Versions.v4, string)
  subscriptionId: Azure.Core.uuid,

  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  ...LocationParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  connectorName: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  body: void,
): ValidateOperationResult;

@@override(LinkerResources.validate, linkerResourcesValidate);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
op linkerResourcesGenerateConfigurations(
  ...ApiVersionParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  @clientLocation(
    linkerResourcesGenerateConfigurations,
    "java,python,go,javascript"
  )
  @typeChangedFrom(Azure.ResourceManager.CommonTypes.Versions.v4, string)
  subscriptionId: Azure.Core.uuid,

  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  ...LocationParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  connectorName: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  parameters?: ConfigurationInfo,
): ConfigurationResult;

@@override(
  LinkerResources.generateConfigurations,
  linkerResourcesGenerateConfigurations
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
op dryrunResourcesGetDryrun(
  ...ApiVersionParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  @clientLocation(dryrunResourcesGetDryrun, "java,python,go,javascript")
  @typeChangedFrom(Azure.ResourceManager.CommonTypes.Versions.v4, string)
  subscriptionId: Azure.Core.uuid,

  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  ...LocationParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  dryrunName: string,
): DryrunResource;

@@override(DryrunResources.getDryrun, dryrunResourcesGetDryrun);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
op dryrunResourcesCreateDryrun(
  ...ApiVersionParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  @clientLocation(dryrunResourcesCreateDryrun, "java,python,go,javascript")
  @typeChangedFrom(Azure.ResourceManager.CommonTypes.Versions.v4, string)
  subscriptionId: Azure.Core.uuid,

  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  ...LocationParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  dryrunName: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  @body parameters: DryrunResource,
): DryrunResource;

@@override(DryrunResources.createDryrun, dryrunResourcesCreateDryrun);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
op dryrunResourcesUpdateDryrun(
  ...ApiVersionParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  @clientLocation(dryrunResourcesUpdateDryrun, "java,python,go,javascript")
  @typeChangedFrom(Azure.ResourceManager.CommonTypes.Versions.v4, string)
  subscriptionId: Azure.Core.uuid,

  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  ...LocationParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  dryrunName: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  @body parameters: DryrunPatch,
): DryrunResource;

@@override(DryrunResources.updateDryrun, dryrunResourcesUpdateDryrun);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
op dryrunResourcesDeleteDryrun(
  ...ApiVersionParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  @clientLocation(dryrunResourcesDeleteDryrun, "java,python,go,javascript")
  @typeChangedFrom(Azure.ResourceManager.CommonTypes.Versions.v4, string)
  subscriptionId: Azure.Core.uuid,

  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  ...LocationParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  dryrunName: string,
): ArmDeletedResponse;

@@override(DryrunResources.deleteDryrun, dryrunResourcesDeleteDryrun);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
op dryrunResourcesListDryrun(
  ...ApiVersionParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "customization"
  @clientLocation(dryrunResourcesListDryrun, "java,python,go,javascript")
  @typeChangedFrom(Azure.ResourceManager.CommonTypes.Versions.v4, string)
  subscriptionId: Azure.Core.uuid,

  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  ...LocationParameter,
): DryrunList;

@@override(DryrunResources.listDryrun, dryrunResourcesListDryrun);

// C# customizations preserve the shipped SDK surface and disambiguate dry-run resources.
@@clientName(AuthInfoBase, "AuthBaseInfo", "csharp");
@@clientName(Microsoft.ServiceLinker.AuthType, "LinkerAuthType", "csharp");
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
@@clientName(DryrunParameters, "DryrunContent", "csharp");
@@clientName(Linker, "LinkerResources", "csharp");
@@clientName(LinkerPatch, "LinkerResourcePatch", "csharp");
@@clientName(LinkerResources, "ConnectorResources", "csharp");
@@clientName(Linkers, "Dryruns", "csharp");
@@clientName(SecretInfoBase, "SecretBaseInfo", "csharp");
@@clientName(SecretStore.keyVaultId, "SecretStoreKeyVaultId", "csharp");
@@clientName(SecretStore, "LinkerSecretStore", "csharp");
@@clientName(SecretType, "LinkerSecretType", "csharp");
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

@@clientLocation(DryrunResources.createDryrun, "ConnectorDryrun", "csharp");
@@clientLocation(DryrunResources.deleteDryrun, "ConnectorDryrun", "csharp");
@@clientLocation(DryrunResources.getDryrun, "ConnectorDryrun", "csharp");
@@clientLocation(DryrunResources.listDryrun, "ConnectorDryrun", "csharp");
@@clientLocation(DryrunResources.updateDryrun, "ConnectorDryrun", "csharp");

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

@@usage(ConfigurationResult, Usage.output, "csharp");
@@usage(ValidateResult, Usage.output, "csharp");
@@usage(ValidationResultItem, Usage.output, "csharp");
