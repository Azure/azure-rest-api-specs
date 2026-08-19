// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using Common;

namespace SecureScoreAPI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@tag("Secure Score Controls")
interface SecureScoreControlsOperationGroup {
  /**
   * Get all security controls within a scope
   */
  @autoRoute
  @get
  @list
  @action("secureScoreControls")
  list is ArmProviderActionSync<
    Response = SecureScoreControlList,
    Scope = SubscriptionActionScope,
    Error = CloudError,
    Parameters = {
      /**
       * OData expand. Optional.
       */
      @query("$expand")
      $expand?: ExpandControlsEnum;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@tag("Secure Score Control Definitions")
interface SecureScoreControlDefinitionsOperationGroup {
  /**
   * List the available security controls, their assessments, and the max score
   */
  @autoRoute
  @get
  @list
  @action("secureScoreControlDefinitions")
  list is ArmProviderActionSync<
    Response = secureScoreControlDefinitionList,
    Error = CloudError
  >;
  /**
   * For a specified subscription, list the available security controls, their assessments, and the max score
   */
  @autoRoute
  @get
  @list
  @action("secureScoreControlDefinitions")
  listBySubscription is ArmProviderActionSync<
    Response = secureScoreControlDefinitionList,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
}
