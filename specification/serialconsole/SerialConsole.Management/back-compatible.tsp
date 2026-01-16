import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.SerialConsole;

@@clientName(SerialPorts.create::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SerialPort.properties);

@@doc(Operations.list, "Gets a list of Serial Console API operations.");
#suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME"
@@TypeSpec.OpenAPI.operationId(Operations.list, "ListOperations");
