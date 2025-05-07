import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./experiment.models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;

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
}

/**
 * Model that represents the base Target Type properties model.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only metadata resource."
model TargetTypeProperties {
  /**
   * Localized string of the display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Localized string of the description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * URL to retrieve JSON schema of the Target Type properties.
   */
  @visibility(Lifecycle.Read)
  @maxLength(2048)
  propertiesSchema?: string;

  /**
   * List of resource types this Target Type can extend.
   */
  @visibility(Lifecycle.Read)
  resourceTypes?: string[];
}

/**
 * Model that represents a list of Target Type resources and a link for pagination.
 */
model TargetTypeListResult is Azure.Core.Page<TargetType>;
