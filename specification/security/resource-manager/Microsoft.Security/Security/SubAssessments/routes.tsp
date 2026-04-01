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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SubAssessmentsOperationGroup {
  /**
   * Get security sub-assessments on all your scanned resources inside a subscription scope
   */
  @tag("SubAssessments")
  @autoRoute
  @get
  @list
  @action("subAssessments")
  listAll is ArmProviderActionSync<
    Response = SecuritySubAssessmentList,
    Scope = ExtensionActionScope,
    Error = CloudError
  >;
}
