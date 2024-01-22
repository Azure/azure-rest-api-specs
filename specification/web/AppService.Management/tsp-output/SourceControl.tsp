import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * The source control OAuth token.
 */
@tenantResource
model SourceControl is ProxyResource<SourceControlProperties> {
  /**
   * Type of source control
   */
  @path
  @key("sourceControlType")
  @segment("sourcecontrols")
  name: string;
}

@armResourceOperations
interface SourceControls {
  /**
   * Description for Gets source control token
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GetSourceControl")
  getSourceControl is ArmResourceRead<SourceControl>;

  /**
   * Description for Updates source control token
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("UpdateSourceControl")
  updateSourceControl is ArmResourceCreateOrReplaceSync<SourceControl>;

  /**
   * Description for Gets the source controls available for Azure websites.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ListSourceControls")
  listSourceControls is ArmResourceListByParent<SourceControl>;
}

@@projectedName(SourceControls.updateSourceControl::parameters.resource,
  "json",
  "requestMessage"
);
@@extension(SourceControls.updateSourceControl::parameters.resource,
  "x-ms-client-name",
  "requestMessage"
);
@@doc(SourceControls.updateSourceControl::parameters.resource,
  "Source control token information"
);
