import "@azure-tools/typespec-client-generator-core";
import "../Common/main.tsp";

using Azure.ClientGenerator.Core;
using LocationsAPI;
using Common;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CloudError.error);

@@clientLocation(AscLocations.get, "Locations");
@@clientLocation(AscLocations.list, "Locations");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AscLocation.properties);
