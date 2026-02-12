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
@subscriptionResource
model TimeZone is Azure.ResourceManager.ProxyResource<TimeZoneProperties> {
  ...ResourceNameParameter<
    Resource = TimeZone,
    KeyName = "timeZoneId",
    SegmentName = "timeZones",
    NamePattern = ""
  >;
}

@armResourceOperations
interface TimeZones {
  /**
   * Gets a managed instance time zone.
   */
  get is ArmResourceRead<
    TimeZone,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Gets a list of managed instance time zones by location.
   */
  listByLocation is ArmResourceListByParent<
    TimeZone,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(TimeZone.name, "");
@@doc(TimeZone.properties, "Resource properties.");
