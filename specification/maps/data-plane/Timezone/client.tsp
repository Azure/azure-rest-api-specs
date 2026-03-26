import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using MapsTimezone;

namespace Customizations;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Legacy.clientDefaultValue(ResponseFormatParameters.format, "json");

// Flatten operations onto client instead of having an operation group attribute
@client({
  name: "MapsTimezoneClient",
  service: MapsTimezone,
})
interface MapsTimezoneClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getTimezoneById is Timezone.getTimezoneById;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getTimezoneByCoordinates is Timezone.getTimezoneByCoordinates;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getWindowsTimezoneIds is Timezone.getWindowsTimezoneIds;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getIanaTimezoneIds is Timezone.getIanaTimezoneIds;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getIanaVersion is Timezone.getIanaVersion;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Backwards compatibility"
  convertWindowsTimezoneToIana is Timezone.getWindowsToIana;
}
