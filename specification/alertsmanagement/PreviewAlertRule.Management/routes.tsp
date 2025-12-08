// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.AlertsManagement;

/**
 * Retrieves the results of a simulated historical execution of an alert rule
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@autoRoute
op previewAlertRule is ArmProviderActionSync<
  Request = PreviewAlertRuleRequest,
  Response = PreviewAlertRuleResponse,
  Parameters = {
    /**
     * The identifier of the resource.
     */
    @path
    @segment("")
    resourceId: string;
  }
>;
