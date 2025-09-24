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
model Target is Azure.ResourceManager.ProxyResource<Record<unknown>, false> {
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
}

alias TargetParentResourceParameters = BaseParameters<Target> &
  ParentResourceParameters;

/**
 * Model that represents a list of Target resources and a link for pagination.
 */
model TargetListResult is Azure.Core.Page<Target>;
