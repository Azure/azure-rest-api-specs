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

namespace Workspaces;
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
  get is ArmResourceRead<AzureADOnlyAuthentication>;

  /**
   * Create or Update a Azure Active Directory only authentication property for the workspaces
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceAsync<
    AzureADOnlyAuthentication,
    Response =
      | ArmResourceUpdatedResponse<AzureADOnlyAuthentication>
      | ArmResourceCreatedResponse<
          AzureADOnlyAuthentication,
          ArmLroLocationHeader<FinalResult = AzureADOnlyAuthentication> &
            Azure.Core.Foundations.RetryAfterHeader
        >
      | ArmAcceptedLroResponse
  >;

  /**
   * Gets a list of Azure Active Directory only authentication property for a workspace
   */
  list is ArmResourceListByParent<
    AzureADOnlyAuthentication,
    Response = ArmResponse<AzureADOnlyAuthenticationListResult>
  >;
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
