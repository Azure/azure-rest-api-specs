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

namespace Microsoft.Sql;
/**
 * A server DNS alias.
 */
@parentResource(Server)
model ServerDnsAlias
  is Azure.ResourceManager.ProxyResource<ServerDnsAliasProperties> {
  ...ResourceNameParameter<
    Resource = ServerDnsAlias,
    KeyName = "dnsAliasName",
    SegmentName = "dnsAliases",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ServerDnsAliases {
  /**
   * Gets a server DNS alias.
   */
  get is ArmResourceRead<ServerDnsAlias>;

  /**
   * Creates a server DNS alias.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    ServerDnsAlias,
    Request = void,
    Response = ArmResourceUpdatedResponse<ServerDnsAlias> | ArmResourceCreatedResponse<
      ServerDnsAlias,
      ArmLroLocationHeader<FinalResult = ServerDnsAlias> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes the server DNS alias with the given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ServerDnsAlias,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of server DNS aliases for a server.
   */
  listByServer is ArmResourceListByParent<ServerDnsAlias>;

  /**
   * Acquires server DNS alias from another server.
   */
  acquire is ArmResourceActionAsync<
    ServerDnsAlias,
    ServerDnsAliasAcquisition,
    Response = ServerDnsAlias
  >;
}

@@doc(ServerDnsAlias.name, "The name of the server dns alias.");
@@doc(ServerDnsAlias.properties, "Resource properties.");
@@doc(ServerDnsAliases.acquire::parameters.body, "");
