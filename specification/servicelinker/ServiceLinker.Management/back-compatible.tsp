import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceLinker;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DryrunPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LinkerPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ValidateOperationResult.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConfigurationNameItem.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DaprConfigurationResource.properties);

@@clientName(DryrunResources.createDryrun::parameters.resource, "parameters");
@@clientName(DryrunResources.updateDryrun::parameters.properties, "parameters");
@@clientName(Linkers.createDryrun::parameters.resource, "parameters");
@@clientName(Linkers.updateDryrun::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DryrunResource.properties);

@@clientName(LinkerResources.createOrUpdate::parameters.resource, "parameters");
@@clientName(LinkerResources.update::parameters.properties, "parameters");
@@clientName(Linker.createOrUpdate::parameters.resource, "parameters");
@@clientName(Linker.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LinkerResource.properties);
