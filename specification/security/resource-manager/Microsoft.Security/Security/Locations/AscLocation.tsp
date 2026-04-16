import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace LocationsAPI;
/**
 * The ASC location of the subscription is in the "name" field
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
@Http.Private.includeInapplicableMetadataInPayload(false)
@subscriptionResource
model AscLocation extends Foundations.ProxyResource {
  ...ResourceNameParameter<
    Resource = AscLocation,
    KeyName = "ascLocation",
    SegmentName = "locations",
    NamePattern = ""
  >;
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: unknown;
}

@armResourceOperations(#{ omitTags: true })
interface AscLocations {
  /**
   * Details of a specific location
   */
  @tag("Locations")
  get is ArmResourceRead<
    AscLocation,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * The location of the responsible ASC of the specific subscription (home region). For each subscription there is only one responsible location. The location in the response should be used to read or write other resources in ASC according to their ID.
   */
  @tag("Locations")
  list is ArmResourceListByParent<
    AscLocation,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<AscLocationList>,
    Error = CloudError
  >;
}

@@doc(AscLocation.name,
  "The location where ASC stores the data of the subscription. can be retrieved from Get locations"
);
@@doc(AscLocation.properties, "An empty set of properties");
