import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * The source control OAuth token.
 */
@tenantResource
model SourceControl
  is Azure.ResourceManager.ProxyResource<SourceControlProperties> {
  ...ResourceNameParameter<
    Resource = SourceControl,
    KeyName = "sourceControlType",
    SegmentName = "sourcecontrols",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SourceControls {
  /**
   * Description for Gets source control token
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets source control token")
  @operationId("GetSourceControl")
  getSourceControl is ArmResourceRead<
    SourceControl,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Updates source control token
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates source control token")
  @operationId("UpdateSourceControl")
  updateSourceControl is ArmResourceCreateOrReplaceSync<
    SourceControl,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResourceUpdatedResponse<SourceControl>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets the source controls available for Azure websites.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the source controls available for Azure websites.")
  @operationId("ListSourceControls")
  listSourceControls is ArmResourceListByParent<
    SourceControl,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<SourceControlCollection>,
    Error = DefaultErrorResponse
  >;
}

@@doc(SourceControl.name, "Type of source control");
@@doc(SourceControl.properties, "SourceControl resource specific properties");
@@doc(SourceControls.updateSourceControl::parameters.resource,
  "Source control token information"
);
