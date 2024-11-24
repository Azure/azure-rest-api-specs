import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.Chaos;
/**
 * Model that represents a Target Type resource.
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model TargetType
  is Azure.ResourceManager.ProxyResource<TargetTypeProperties, false> {
  ...ResourceNameParameter<
    Resource = TargetType,
    KeyName = "targetTypeName",
    SegmentName = "targetTypes",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;

  /**
   * Azure resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Required to avoid SDK breaking change."
  @visibility("read")
  location?: azureLocation;

  /**
   * System data.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Required to avoid SDK breaking change."
  systemData: Azure.ResourceManager.CommonTypes.SystemData;
}

@armResourceOperations
interface TargetTypes {
  /**
   * Get a Target Type resources for given location.
   */
  get is ArmResourceRead<
    TargetType,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Get a list of Target Type resources for given location.
   */
  list is ArmResourceListByParent<
    TargetType,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    },
    Response = TargetTypeListResult
  >;
}

@@doc(TargetType.name, "String that represents a Target Type resource name.");
@@doc(TargetType.properties, "The properties of the target type resource.");
