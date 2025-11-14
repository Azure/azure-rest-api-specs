import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace Customizations;

@@clientName(MapsGeolocation.Geolocation.getIpToLocation, "getLocation");
