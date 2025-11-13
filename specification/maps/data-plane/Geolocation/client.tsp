import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace Customizations;

@@clientName(Geolocation.GeolocationOperationGroup.getIPToLocation,
  "getLocation"
);
