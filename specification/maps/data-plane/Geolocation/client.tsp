import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;
using MapsGeolocation;

namespace Customizations;

@@clientName(getIpToLocation, "getLocation");
@@clientName(getIpToLocation, "getCountryCode", "python");

model MapsGeolocationClientOptions {
  /**
   * Indicates the account intended for use with the Microsoft Entra ID security
   * model. This unique ID for the Azure Maps account can be obtained from the
   * [Azure Maps management plane Account API](/rest/api/maps-management/accounts).
   * For more information on using Microsoft Entra ID security in Azure Maps, see
   * [Manage authentication in Azure
   * Maps](/azure/azure-maps/how-to-manage-authentication).
   */
  @header("x-ms-client-id")
  clientId?: string;
}

@@clientInitialization(MapsGeolocation,
  {
    parameters: MapsGeolocationClientOptions,
  }
);
