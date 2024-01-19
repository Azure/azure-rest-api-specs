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
@doc("The source control OAuth token.")
@tenantResource
model SourceControl is ProxyResource<SourceControlProperties> {
  @doc("Type of source control")
  @path
  @key("sourceControlType")
  @segment("sourcecontrols")
  name: string;
}

@armResourceOperations
interface SourceControls {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets source control token")
  @operationId("GetSourceControl")
  getSourceControl is ArmResourceRead<SourceControl>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Updates source control token")
  @operationId("UpdateSourceControl")
  updateSourceControl is ArmResourceCreateOrReplaceSync<SourceControl>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets the source controls available for Azure websites.")
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
