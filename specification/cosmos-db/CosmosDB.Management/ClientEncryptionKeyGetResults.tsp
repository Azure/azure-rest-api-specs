import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlDatabaseGetResults.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * Client Encryption Key.
 */
@parentResource(SqlDatabaseGetResults)
model ClientEncryptionKeyGetResults
  is Azure.ResourceManager.ProxyResource<ClientEncryptionKeyGetProperties> {
  ...ResourceNameParameter<
    Resource = ClientEncryptionKeyGetResults,
    KeyName = "clientEncryptionKeyName",
    SegmentName = "clientEncryptionKeys",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ClientEncryptionKeyGetResultsOperationGroup {
  /**
   * Gets the ClientEncryptionKey under an existing Azure Cosmos DB SQL database.
   */
  getClientEncryptionKey is ArmResourceRead<ClientEncryptionKeyGetResults>;

  /**
   * Create or update a ClientEncryptionKey. This API is meant to be invoked via tools such as the Azure Powershell (instead of directly).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateClientEncryptionKey is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    ClientEncryptionKeyGetResults,
    Request = ClientEncryptionKeyCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<ClientEncryptionKeyGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ClientEncryptionKeyGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Lists the ClientEncryptionKeys under an existing Azure Cosmos DB SQL database.
   */
  listClientEncryptionKeys is ArmResourceListByParent<
    ClientEncryptionKeyGetResults,
    Response = ArmResponse<ClientEncryptionKeysListResult>
  >;
}

@@doc(ClientEncryptionKeyGetResults.name,
  "Cosmos DB ClientEncryptionKey name."
);
@@doc(ClientEncryptionKeyGetResults.properties,
  "The properties of a ClientEncryptionKey"
);
@@doc(ClientEncryptionKeyGetResultsOperationGroup.createUpdateClientEncryptionKey::parameters.resource,
  "The parameters to provide for the client encryption key."
);
