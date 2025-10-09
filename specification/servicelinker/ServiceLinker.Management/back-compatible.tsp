import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceLinker;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DryrunPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(LinkerPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ValidateOperationResult.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ConfigurationNameItem.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DaprConfigurationResource.properties
);

@@clientName(DryrunResources.createDryrun::parameters.resource, "parameters");
@@clientName(DryrunResources.updateDryrun::parameters.properties, "parameters");
@@clientName(Linkers.createDryrun::parameters.resource, "parameters");
@@clientName(Linkers.updateDryrun::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DryrunResource.properties);

@@clientName(LinkerResources.createOrUpdate::parameters.resource, "parameters");
@@clientName(LinkerResources.update::parameters.properties, "parameters");
@@clientName(Linker.createOrUpdate::parameters.resource, "parameters");
@@clientName(Linker.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(LinkerResource.properties);

// @@clientLocation decorators for operations with custom @operationId
// These ensure consistent operationId generation in the output

// LinkerResources interface operations with Connector_ prefix
@@clientLocation(LinkerResources.get, "Connector");
@@clientName(LinkerResources.get, "Get");
@@clientLocation(LinkerResources.createOrUpdate, "Connector");
@@clientName(LinkerResources.createOrUpdate, "CreateOrUpdate");
@@clientLocation(LinkerResources.update, "Connector");
@@clientName(LinkerResources.update, "Update");
@@clientLocation(LinkerResources.delete, "Connector");
@@clientName(LinkerResources.delete, "Delete");
@@clientLocation(LinkerResources.list, "Connector");
@@clientName(LinkerResources.list, "List");
@@clientLocation(LinkerResources.validate, "Connector");
@@clientName(LinkerResources.validate, "Validate");
@@clientLocation(LinkerResources.generateConfigurations, "Connector");
@@clientName(LinkerResources.generateConfigurations, "GenerateConfigurations");

// DryrunResources interface operations with Connector_ prefix
@@clientLocation(DryrunResources.getDryrun, "Connector");
@@clientName(DryrunResources.getDryrun, "GetDryrun");
@@clientLocation(DryrunResources.createDryrun, "Connector");
@@clientName(DryrunResources.createDryrun, "CreateDryrun");
@@clientLocation(DryrunResources.updateDryrun, "Connector");
@@clientName(DryrunResources.updateDryrun, "UpdateDryrun");
@@clientLocation(DryrunResources.deleteDryrun, "Connector");
@@clientName(DryrunResources.deleteDryrun, "DeleteDryrun");
@@clientLocation(DryrunResources.listDryrun, "Connector");
@@clientName(DryrunResources.listDryrun, "ListDryrun");

// Linker interface operations with Linkers_ prefix
@@clientLocation(Linker.generateConfigurations, Linkers);
@@clientName(Linker.generateConfigurations, "GenerateConfigurations");

// LinkersOperationGroup operations with Linkers_ prefix
@@clientLocation(LinkersOperationGroup.listDaprConfigurations, Linkers);
@@clientName(LinkersOperationGroup.listDaprConfigurations,
  "ListDaprConfigurations"
);

// ConfigurationNamesOperationGroup operations with ConfigurationNames_ prefix
@@clientLocation(ConfigurationNamesOperationGroup.list, "ConfigurationNames");
@@clientName(ConfigurationNamesOperationGroup.list, "List");
@@clientName(LinkerResources.generateConfigurations::parameters.body,
  "parameters"
);
@@clientName(Linker.generateConfigurations::parameters.body, "parameters");

@@doc(Azure.ResourceManager.Extension.ScopeParameter.scope,
  "The fully qualified Azure Resource manager identifier of the resource to be connected."
);
@@key(Azure.ResourceManager.Extension.ScopeParameter.scope, "resourceUri");

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
  resource: LinkerResource,
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
  properties: LinkerPatch,
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
  body?: ConfigurationInfo,
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
  @body resource: DryrunResource,
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
  @body properties: DryrunPatch,
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
