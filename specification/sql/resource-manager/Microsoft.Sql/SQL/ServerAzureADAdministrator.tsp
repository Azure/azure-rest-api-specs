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
using TypeSpec.Versioning;

namespace Microsoft.Sql;
/**
 * Azure Active Directory administrator.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Server)
@Azure.ResourceManager.Legacy.feature(Features.ServerAzureADAdministrators)
model ServerAzureADAdministrator
  is Azure.ResourceManager.ProxyResource<AdministratorProperties> {
  ...ResourceNameParameter<
    Resource = ServerAzureADAdministrator,
    KeyName = "administratorName",
    SegmentName = "administrators",
    NamePattern = "",
    Type = AdministratorName
  >;
}

/**
 * A server administrator action with SQL server-name validation.
 * @template Description The description of the accepted response.
 */
@autoRoute
@armResourceAction(ServerAzureADAdministrator)
@post
op ServerAzureAdAdministratorAction<Description extends valueof string>(
  ...OmitProperties<
    ResourceInstanceParameters<ServerAzureADAdministrator>,
    "serverName" | "administratorName"
  >,

  /** The name of the server. */
  @path
  @segment("servers")
  @pattern("^[a-z0-9]([a-z0-9-]{0,61}[a-z0-9])?$")
  serverName: string,

  ...PickProperties<
    ResourceInstanceParameters<ServerAzureADAdministrator>,
    "administratorName"
  >,
): ServerAzureAdAdministratorActionResponse<Description> | ErrorResponse;

alias ServerAzureAdAdministratorActionResponse<Description extends valueof string> =
  | ArmResponse<ServerAzureADAdministrator>
  | ArmAcceptedLroResponse<
      Description = Description,
      LroHeaders = ArmLroLocationHeader<FinalResult = ServerAzureADAdministrator> &
        Azure.Core.Foundations.RetryAfterHeader
    >;

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(Features.ServerAzureADAdministrators)
interface ServerAzureADAdministrators {
  /**
   * Gets a Azure Active Directory administrator.
   */
  get is ArmResourceRead<ServerAzureADAdministrator>;

  /**
   * Creates or updates an existing Azure Active Directory administrator.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerAzureADAdministrator,
    Response =
      | ArmResourceUpdatedResponse<ServerAzureADAdministrator>
      | ArmResourceCreatedResponse<
          ServerAzureADAdministrator,
          ArmLroLocationHeader<FinalResult = ServerAzureADAdministrator> &
            Azure.Core.Foundations.RetryAfterHeader
        >
      | ArmAcceptedLroResponse
  >;

  /**
   * Deletes the Azure Active Directory administrator with the given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ServerAzureADAdministrator,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of Azure Active Directory administrators in a server.
   */
  listByServer is ArmResourceListByParent<
    ServerAzureADAdministrator,
    Response = AdministratorListResult
  >;

  /**
   * Enables the Azure Active Directory administrator on the server.
   */
  @added(Versions.v2026_11_01_preview)
  @action("enable")
  enable is ServerAzureAdAdministratorAction<"Enabling the Azure Active Directory administrator is in progress.">;

  /**
   * Disables the Azure Active Directory administrator on the server.
   */
  @added(Versions.v2026_11_01_preview)
  @action("disable")
  disable is ServerAzureAdAdministratorAction<"Disabling the Azure Active Directory administrator is in progress.">;
}

@@doc(
  ServerAzureADAdministrator.name,
  "The name of server active directory administrator."
);
@@doc(ServerAzureADAdministrator.properties, "Resource properties.");
@@doc(
  ServerAzureADAdministrators.createOrUpdate::parameters.resource,
  "The requested Azure Active Directory administrator Resource state."
);
