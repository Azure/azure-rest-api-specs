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
 * A server key.
 */
@parentResource(Server)
model ServerKey is Azure.ResourceManager.ProxyResource<ServerKeyProperties> {
  ...ResourceNameParameter<
    Resource = ServerKey,
    KeyName = "keyName",
    SegmentName = "keys",
    NamePattern = ""
  >;

  /**
   * Kind of encryption protector. This is metadata used for the Azure portal experience.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  kind?: string;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface ServerKeys {
  /**
   * Gets a server key.
   */
  get is ArmResourceRead<ServerKey>;

  /**
   * Creates or updates a server key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerKey,
    Response = ArmResourceUpdatedResponse<ServerKey> | ArmResourceCreatedResponse<
      ServerKey,
      ArmLroLocationHeader<FinalResult = ServerKey> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes the server key with the given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ServerKey,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of server keys.
   */
  listByServer is ArmResourceListByParent<ServerKey>;
}

@@doc(ServerKey.name, "The name of the server key to be retrieved.");
@@doc(ServerKey.properties, "Resource properties.");
@@doc(ServerKeys.createOrUpdate::parameters.resource,
  "The requested server key resource state."
);
