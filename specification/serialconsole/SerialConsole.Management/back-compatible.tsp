import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.SerialConsole;

@@clientName(SerialPorts.create::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SerialPort.properties);

@@doc(Operations.list, "Gets a list of Serial Console API operations.");
@@clientName(Operations.list, "ListOperations");
@@clientLocation(Operations.list, Microsoft.SerialConsole);
