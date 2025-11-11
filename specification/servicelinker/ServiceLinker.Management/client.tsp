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
@@clientName(Microsoft.ServiceLinker,
  "ServiceLinkerManagementClient",
  "javascript"
);
@@clientName(Microsoft.ServiceLinker,
  "ServiceLinkerManagementClient",
  "python"
);

// Go SDK Breaking Changes Resolution for TypeSpec conversion
@@clientName(DatabaseAadAuthInfo, "DatabaseAADAuthInfo", "go");

@@clientName(ActionType, "ActionTypeFlag");

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

@@override(LinkerResources.generateConfigurations,
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
