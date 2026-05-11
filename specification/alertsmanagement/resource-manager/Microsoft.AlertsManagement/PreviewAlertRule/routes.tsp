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
 * Operations for Preview Alert Rule.
 */
// NOTE: The original Swagger had a single free-floating `previewAlertRule` op
// at the namespace level. The C# MPG generator needs every operation to belong
// to a stable operation group so it can emit a proper client / extension class;
// `@@clientLocation` in `client.tsp` also requires an interface target. We wrap
// the op in `interface PreviewAlertRules { ... }` purely to give it that group.
// The route, HTTP method, request/response bodies, and runtime behavior are
// unchanged. The only resulting wire change is `operationId`:
// `PreviewAlertRule` -> `PreviewAlertRules_PreviewAlertRule`, which follows the
// standard `Group_Operation` convention used across Azure RP specs.
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface PreviewAlertRules {
  /**
   * Retrieves the results of a simulated historical execution of an alert rule
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/{resourceId}/providers/microsoft.AlertsManagement/previewAlertRule")
  @post
  previewAlertRule(
    ...ApiVersionParameter,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path resourceId: string,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @body parameters: PreviewAlertRuleRequest,
  ): PreviewAlertRuleResponse | ErrorResponse;
}
