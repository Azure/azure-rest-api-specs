import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./common.models.tsp";
import "./capabilityType.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.Chaos;

/**
 * Model that represents a Target resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required implementation to avoid breaking .NET SDK changes"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required implementation to avoid breaking .NET SDK changes"
@Azure.ResourceManager.Private.armResourceInternal(Record<unknown>)
@includeInapplicableMetadataInPayload(false)
model Target extends Azure.ResourceManager.Foundations.ProxyResource {
  ...ResourceNameParameter<
    Resource = Target,
    KeyName = "targetName",
    SegmentName = "targets",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;

  /**
   * Azure resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Required to avoid SDK breaking change."
  location?: azureLocation;

  /**
   * Target properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Required to avoid SDK breaking change."
  properties: TargetProperties;
}

/**
 * Target properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Required to avoid SDK breaking change."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Required to avoid SDK breaking change."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Required to avoid SDK breaking change."
model TargetProperties is Record<unknown>;

alias TargetParentResourceParameters = BaseParameters<Target> &
  ParentResourceParameters;

/**
 * Model that represents a list of Target resources and a link for pagination.
 */
model TargetListResult is Azure.Core.Page<Target>;
