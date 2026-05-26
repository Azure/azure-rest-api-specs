import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Time Zone property.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@subscriptionResource
@Azure.ResourceManager.Legacy.feature(Features.TimeZones)
model TimeZone is Azure.ResourceManager.ProxyResource<TimeZoneProperties> {
  ...ResourceNameParameter<
    Resource = TimeZone,
    KeyName = "timeZoneId",
    SegmentName = "timeZones",
    NamePattern = ""
  >;
}

alias TimeZonesOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The location of the database. */
    @path
    @segment("locations")
    @key
    locationName: string;
  },
  {
    /** The time zone ID. */
    @path
    @segment("timeZones")
    @key
    timeZoneId: string;
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(Features.TimeZones)
interface TimeZones {
  /**
   * Gets a managed instance time zone.
   */
  get is TimeZonesOps.Read<TimeZone>;

  /**
   * Gets a list of managed instance time zones by location.
   */
  listByLocation is TimeZonesOps.List<TimeZone>;
}

@@doc(TimeZone.name, "");
@@doc(TimeZone.properties, "Resource properties.");
