import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KubernetesConfiguration;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PatchExtension.properties);

@@clientName(Extensions.create::parameters.resource, "extension");
@@clientName(Extensions.update::parameters.properties, "patchExtension");
@@clientLocation(Extensions.operationStatusGet, "OperationStatus");
@@clientName(Extensions.operationStatusGet, "Get");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Extension.properties);
