import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforMySQL;
/**
 * Represents a Administrator.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Server)
model AzureADAdministrator
  is Azure.ResourceManager.ProxyResource<AdministratorProperties> {
  ...ResourceNameParameter<
    Resource = AzureADAdministrator,
    KeyName = "administratorName",
    SegmentName = "administrators",
    NamePattern = "",
    Type = AdministratorName
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface AzureADAdministrators {
  /**
   * Gets information about an azure ad administrator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<AzureADAdministrator>;

  /**
   * Creates or updates an existing Azure Active Directory administrator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AzureADAdministrator,
    Response = ArmResourceUpdatedResponse<AzureADAdministrator> | ArmResourceCreatedResponse<
      AzureADAdministrator,
      ArmLroLocationHeader<FinalResult = AzureADAdministrator> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes an Azure AD Administrator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    AzureADAdministrator,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the AAD administrators in a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listByServer is ArmResourceListByParent<
    AzureADAdministrator,
    Response = ArmResponse<AdministratorListResult>
  >;
}

@@doc(AzureADAdministrator.name, "The name of the Azure AD Administrator.");
@@doc(AzureADAdministrator.properties, "The properties of an administrator.");
@@doc(AzureADAdministrators.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating an aad administrator."
);
