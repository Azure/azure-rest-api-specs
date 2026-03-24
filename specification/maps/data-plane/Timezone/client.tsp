import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using MapsTimezone;

namespace Customizations;

@@clientName(getWindowsToIana, "convertWindowsTimezoneToIANA");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Legacy.clientDefaultValue(ResponseFormatParameters.format, "json");
