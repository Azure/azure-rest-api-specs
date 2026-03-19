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

namespace Microsoft.Authorization;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ClassicAdministratorsOperationGroup {
  /**
   * Gets service administrator, account administrator, and co-administrators for the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ClassicAdministrators")
  @operationId("ClassicAdministrators_List")
  @autoRoute
  @list
  @get
  @action("classicAdministrators")
  list is ArmProviderActionSync<
    Response = ResourceListResult<ClassicAdministrator>,
    Scope = SubscriptionActionScope
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface GlobalAdministratorOperationGroup {
  /**
   * Elevates access for a Global Administrator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ElevateAccess")
  @operationId("GlobalAdministrator_ElevateAccess")
  @autoRoute
  elevateAccess is ArmProviderActionSync<Response = OkResponse>;
}
