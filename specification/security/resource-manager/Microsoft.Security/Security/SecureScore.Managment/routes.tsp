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

namespace Microsoft.Security;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SecureScoreControlsOperationGroup {
  /**
   * Get all security controls within a scope
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SecureScoreControls_List")
  @autoRoute
  @get
  @action("secureScoreControls")
  list is ArmProviderActionSync<
    Response = SecureScoreControlList,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * OData expand. Optional.
       */
      @query("$expand")
      $expand?: ExpandControlsEnum;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SecureScoreControlDefinitionsOperationGroup {
  /**
   * List the available security controls, their assessments, and the max score
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SecureScoreControlDefinitions_List")
  @autoRoute
  @get
  @action("secureScoreControlDefinitions")
  list is ArmProviderActionSync<Response = SecureScoreControlDefinitionList>;
  /**
   * For a specified subscription, list the available security controls, their assessments, and the max score
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SecureScoreControlDefinitions_ListBySubscription")
  @autoRoute
  @get
  @action("secureScoreControlDefinitions")
  listBySubscription is ArmProviderActionSync<
    Response = SecureScoreControlDefinitionList,
    Scope = SubscriptionActionScope
  >;
}
