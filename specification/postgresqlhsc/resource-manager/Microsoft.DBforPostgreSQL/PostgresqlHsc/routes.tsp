// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ClustersOperationGroup {
  /**
   * Checks availability of a cluster name. Cluster names should be globally unique; at least 3 characters and at most 40 characters long; they must only contain lowercase letters, numbers, and hyphens; and must not start or end with a hyphen.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = NameAvailabilityRequest,
    Response = NameAvailability,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
