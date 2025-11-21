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
