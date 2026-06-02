import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using MapsTraffic;

namespace Customizations;

// Flatten operations onto client instead of having an operation group attribute
@client({
  name: "MapsTrafficClient",
  service: MapsTraffic,
})
interface MapsTrafficClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getTrafficIncident is Traffic.getTrafficIncident;
}
