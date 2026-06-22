import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "./common/common.tsp";

using TypeSpec.Http;

namespace MapsTimezone;

alias ResponseFormatParameters = {
  /**
   * Desired format of the response. Only `json` format is supported.
   */
  @path
  format: JsonFormat;
};

interface Timezone {
  /**
   *
   *
   * The `Get Timezone By ID` API is an HTTP `GET` request that returns current,
   * historical, and future time zone information for the specified IANA time zone
   * ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Matching the 'ID' casing of the original API contract."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use to get the current, historical, and future time zone information for the
    specified IANA time zone ID.
    """)
  @route("/timezone/byId/{format}")
  @OpenAPI.operationId("Timezone_GetTimezoneByID")
  @get
  getTimezoneById is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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
       * Specifies the language code in which the timezone names should be returned. If
       * no language code is provided, the response will be in "EN". Please refer to
       * [Supported
       * Languages](https://docs.microsoft.com/azure/azure-maps/supported-languages) for
       * details.
       */
      @header("Accept-Language")
      acceptLanguage?: string;

      /**
       * Alternatively, use alias "o". Options available for types of information
       * returned in the result.
       */
      @query("options")
      options?: TimezoneOptions;

      /**
       * Alternatively, use alias "stamp", or "s". Reference time, if omitted, the API
       * will use the machine time serving the request.
       */
      @query("timeStamp")
      timeStamp?: utcDateTime;

      /**
       * Alternatively, use alias "tf". The start date from which daylight savings time
       * (DST) transitions are requested, only applies when "options" = all or "options"
       * = transitions.
       */
      @query("transitionsFrom")
      daylightSavingsTimeFrom?: utcDateTime;

      /**
       * Alternatively, use alias "ty". The number of years from "transitionsFrom" for
       * which DST transitions are requested, only applies when "options" = all or
       * "options" = transitions.
       */
      @query("transitionsYears")
      daylightSavingsTimeLastingYears?: int32;

      /**
       * The IANA time zone ID.
       */
      @query("query")
      timezoneId: string;
    },
    TimezoneResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Timezone By Coordinates` API is an HTTP `GET` request that returns
   * current, historical, and future time zone information for a specified
   * latitude-longitude pair. In addition, the API provides sunset and sunrise times
   * for a given location, with the exception of regions that observe solar days.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    Use to get the current, historical, and future time zone information for the
    specified latitude-longitude pair.
    """)
  @route("/timezone/byCoordinates/{format}")
  @get
  getTimezoneByCoordinates is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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
       * Specifies the language code in which the timezone names should be returned. If
       * no language code is provided, the response will be in "EN". Please refer to
       * [Supported
       * Languages](https://docs.microsoft.com/azure/azure-maps/supported-languages) for
       * details.
       */
      @header("Accept-Language")
      acceptLanguage?: string;

      /**
       * Alternatively, use alias "o". Options available for types of information
       * returned in the result.
       */
      @query("options")
      options?: TimezoneOptions;

      /**
       * Alternatively, use alias "stamp", or "s". Reference time, if omitted, the API
       * will use the machine time serving the request.
       */
      @query("timeStamp")
      timeStamp?: utcDateTime;

      /**
       * Alternatively, use alias "tf". The start date from which daylight savings time
       * (DST) transitions are requested, only applies when "options" = all or "options"
       * = transitions.
       */
      @query("transitionsFrom")
      daylightSavingsTimeFrom?: utcDateTime;

      /**
       * Alternatively, use alias "ty". The number of years from "transitionsFrom" for
       * which DST transitions are requested, only applies when "options" = all or
       * "options" = transitions.
       */
      @query("transitionsYears")
      daylightSavingsTimeLastingYears?: int32;

      /**
       * Coordinates of the point for which time zone information is requested. This
       * parameter is a list of coordinates, containing a pair of coordinate(lat, long).
       * When this endpoint is called directly, coordinates are passed in as a single
       * string containing coordinates, separated by commas.
       */
      @query("query")
      coordinates: float64[];
    },
    TimezoneResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Windows Time Zones` API is an HTTP `GET` request that returns a full
   * list of Windows Time Zone IDs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Matching the operation ID of the original API contract."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("Use to get the list of Windows Time Zone IDs.")
  @route("/timezone/enumWindows/{format}")
  @OpenAPI.operationId("Timezone_GetTimezoneEnumWindows")
  @get
  getWindowsTimezoneIds is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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
    },
    TimezoneWindows[],
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get IANA Time Zones` API is an HTTP `GET` request that returns a full list
   * of Internet Assigned Numbers Authority (IANA) time zone IDs. Updates to the
   * IANA service are reflected in the system within one day.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Matching the operation ID of the original API contract."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("Use to get the list of IANA time zone IDs.")
  @route("/timezone/enumIana/{format}")
  @OpenAPI.operationId("Timezone_GetTimezoneEnumIANA")
  @get
  getIanaTimezoneIds is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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
    },
    IanaId[],
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Time Zone IANA Version` API is an HTTP `GET` request that returns the
   * current Internet Assigned Numbers Authority (IANA) version number as Metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Matching the operation ID of the original API contract."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("Use to get the current IANA version number.")
  @route("/timezone/ianaVersion/{format}")
  @OpenAPI.operationId("Timezone_GetTimezoneIANAVersion")
  @get
  getIanaVersion is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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
    },
    TimezoneIanaVersionResult,
    {},
    ErrorResponse
  >;

  /**
   *
   *
   * The `Get Windows to IANA Time Zone` API is an HTTP `GET` request that returns a
   * corresponding Internet Assigned Numbers Authority (IANA) ID, given a valid
   * Windows Time Zone ID. Multiple IANA IDs may be returned for a single Windows
   * ID. It is possible to narrow these results by adding an optional territory
   * parameter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Matching the IANA casing of the original API contract."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("Use to get the IANA ID.")
  @route("/timezone/windowsToIana/{format}")
  @OpenAPI.operationId("Timezone_GetTimezoneWindowsToIANA")
  @get
  getWindowsToIana is Azure.Core.Foundations.Operation<
    ResponseFormatParameters & {
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
       * The Windows time zone ID.
       */
      @query("query")
      windowsTimezoneId: string;

      /**
       * Windows Time Zone territory code.
       */
      @query("territory")
      windowsTerritoryCode?: string;
    },
    IanaId[],
    {},
    ErrorResponse
  >;
}
