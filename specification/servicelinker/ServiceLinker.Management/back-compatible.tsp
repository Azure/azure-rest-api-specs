import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceLinker;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DryrunPatch.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(LinkerPatch.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ValidateOperationResult.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ConfigurationNameItem.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DaprConfigurationResource.properties);

@@clientName(DryrunResources.createDryrun::parameters.resource, "parameters");
@@clientName(DryrunResources.updateDryrun::parameters.properties, "parameters");
@@clientName(Linkers.createDryrun::parameters.resource, "parameters");
@@clientName(Linkers.updateDryrun::parameters.properties, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DryrunResource.properties);

@@clientName(LinkerResources.createOrUpdate::parameters.resource, "parameters");
@@clientName(LinkerResources.update::parameters.properties, "parameters");
@@clientName(Linker.createOrUpdate::parameters.resource, "parameters");
@@clientName(Linker.update::parameters.properties, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(LinkerResource.properties);

// @@clientLocation decorators for operations with custom @operationId
// These ensure consistent operationId generation in the output

// LinkerResources interface operations with Connector_ prefix
@@clientLocation(LinkerResources.get, "Connector");
@@clientLocation(LinkerResources.createOrUpdate, "Connector");
@@clientLocation(LinkerResources.update, "Connector");
@@clientLocation(LinkerResources.delete, "Connector");
@@clientLocation(LinkerResources.list, "Connector");
@@clientLocation(LinkerResources.validate, "Connector");
@@clientLocation(LinkerResources.generateConfigurations, "Connector");

// DryrunResources interface operations with Connector_ prefix
@@clientLocation(DryrunResources.getDryrun, "Connector");
@@clientLocation(DryrunResources.createDryrun, "Connector");
@@clientLocation(DryrunResources.updateDryrun, "Connector");
@@clientLocation(DryrunResources.deleteDryrun, "Connector");
@@clientLocation(DryrunResources.listDryrun, "Connector");

// Linker interface operations with Linkers_ prefix
@@clientLocation(Linker.generateConfigurations, Linkers);

// LinkersOperationGroup operations with Linkers_ prefix
@@clientLocation(LinkersOperationGroup.listDaprConfigurations, Linkers);

// ConfigurationNamesOperationGroup operations with ConfigurationNames_ prefix
@@clientLocation(ConfigurationNamesOperationGroup.list, "ConfigurationNames");
