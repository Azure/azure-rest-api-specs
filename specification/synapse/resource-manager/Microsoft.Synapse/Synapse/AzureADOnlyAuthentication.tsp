import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * Azure Active Directory Only Authentication Info
 */
@parentResource(Workspace)
model AzureADOnlyAuthentication
  is Azure.ResourceManager.ProxyResource<AzureADOnlyAuthenticationProperties> {
  ...ResourceNameParameter<
    Resource = AzureADOnlyAuthentication,
    KeyName = "azureADOnlyAuthenticationName",
    SegmentName = "azureADOnlyAuthentications",
    NamePattern = "",
    Type = AzureADOnlyAuthenticationName
  >;
}

@armResourceOperations
interface AzureADOnlyAuthentications {
  /**
   * Gets a Azure Active Directory only authentication property
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AzureADOnlyAuthentications_Get")
  get is ArmResourceRead<AzureADOnlyAuthentication>;

  /**
   * Create or Update a Azure Active Directory only authentication property for the workspaces
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("AzureADOnlyAuthentications_Create")
  create is ArmResourceCreateOrReplaceAsync<
    AzureADOnlyAuthentication,
    Response =
      | ArmResourceUpdatedResponse<AzureADOnlyAuthentication>
      | ArmResourceCreatedResponse<
          AzureADOnlyAuthentication,
          ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
        >
      | ArmAcceptedLroResponse
  >;

  /**
   * Gets a list of Azure Active Directory only authentication property for a workspace
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AzureADOnlyAuthentications_List")
  list is ArmResourceListByParent<AzureADOnlyAuthentication>;
}

@@doc(AzureADOnlyAuthentication.name, "name of the property");
@@doc(
  AzureADOnlyAuthentication.properties,
  "azureADOnlyAuthentication resource properties"
);
@@doc(
  AzureADOnlyAuthentications.create::parameters.resource,
  "Azure Active Directory Property"
);
