import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;

namespace MapsGeolocation;

/**
 *
 *
 * The `Get IP To Location` API is an HTTP `GET` request that returns the ISO
 * country/region code for a given IP address. Developers can use this information
 * to block or modify content based on the geographical location from which the
 * application is accessed.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
@summary("Use to get the ISO country/region code for a given IP address.")
@route("/geolocation/ip/{format}")
@get
op getIpToLocation is Azure.Core.Foundations.Operation<
  {
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

    /**
     * Desired format of the response. Only `json` format is supported.
     */
    @path
    format: JsonFormat;

    /**
     * The IP address. Both IPv4 and IPv6 are allowed.
     */
    @query("ip")
    ipAddress: string;
  },
  IpAddressToLocationResult,
  {},
  ErrorResponse
>;
