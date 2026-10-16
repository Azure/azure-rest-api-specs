import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

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
@armResourceOperations(#{ omitTags: true })
interface SourceControls {
  /**
   * Description for Gets source control token
   */
  @summary("Gets source control token")
  getSourceControl is ArmResourceRead<
    SourceControl,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Updates source control token
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates source control token")
  updateSourceControl is ArmResourceCreateOrReplaceSync<
    SourceControl,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResourceUpdatedResponse<SourceControl>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets the source controls available for Azure websites.
   */
  @summary("Gets the source controls available for Azure websites.")
  listSourceControls is ArmResourceListByParent<
    SourceControl,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<SourceControlCollection>,
    Error = DefaultErrorResponse
  >;
}

@@doc(SourceControl.name, "Type of source control");
@@doc(SourceControl.properties, "SourceControl resource specific properties");
@@doc(
  SourceControls.updateSourceControl::parameters.resource,
  "Source control token information"
);
