import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;

namespace MapsTraffic;

interface Traffic {
  /**
   *
   *
   * The API provides a GeoJSON feature collection of traffic incidents. Each
   * incident includes two point features: the location where you encounter the
   * incident and the end location of a traffic incident like the end of a
   * construction zone. For traffic incident coverage by country/region, see
   * [traffic
   * coverage](https://learn.microsoft.com/azure/azure-maps/traffic-coverage?pivots=latest).
   *
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Non-standard operation."
  @summary("""
    The Traffic Incident API provides traffic incidents like construction, traffic
    congestion and accidents, etc. within a bounding box. It also provides traffic
    metadata for detailed information about each incident.
    """)
  @route("/traffic/incident")
  @get
  getTrafficIncident is Azure.Core.Foundations.Operation<
    {
      /**
       * Specifies which account is intended for usage in conjunction with the Azure AD
       * security model.  It represents a unique ID for the Azure Maps account and can
       * be retrieved from the Azure Maps management plane Account API. For more
       * information on using Microsoft Entra ID security in Azure Maps, see [Manage
       * authentication in Azure Maps](/azure/azure-maps/how-to-manage-authentication).
       */
      @header("x-ms-client-id")
      clientId?: string;

      /**
       * Specifies the type of traffic incident to be returned. Multiple incident types
       * within a single request are supported. If not specified, the results will
       * include all incident types within the provided bounding box.
       *
       * Example, '&incidentType=Accident' or '&incidentType=Accident,Construction'.
       */
      @query("incidentType")
      incidentType?: IncidentType;

      /**
       * Defines a rectangular area of interest on the Earth's surface. The sides of the
       * rectangle are specified by longitude and latitude values and must adhere to the
       * GeoJSON format: [minLon, minLat, maxLon, maxLat]. For more information, see
       * [RFC 7946, Section 5](https://www.rfc-editor.org/rfc/rfc7946#section-5).
       * <ul><li>**Minimum Dimensions**: The height or width of the bounding box must be
       * at least 12 meters.</li><li>**Maximum Area**: The bounding box can cover an
       * area up to 10,000 square kilometers.</li><li>**Incident Inclusion**: Traffic
       * incidents will be included in the response if they overlap with the bounding
       * box, or if their start, end, or any part of the incident passes through the
       * bounding box. The start and end locations of the incident can be outside the
       * bounding box.</li></ul>**Example**: `bbox=-105,37,-94,45`
       */
      @query("bbox")
      bbox: float64[];

      /**
       * Language in which traffic incident results should be returned.
       *
       * For more information, see [Supported
       * Languages](https://docs.microsoft.com/azure/azure-maps/supported-languages) for
       * reference.
       */
      @header("Accept-Language")
      acceptLanguage?: string;
    },
    TrafficIncidentResponse,
    {},
    ErrorResponse
  >;
}
