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
 * The server encryption protector.
 */
@parentResource(Server)
model EncryptionProtector
  is Azure.ResourceManager.ProxyResource<EncryptionProtectorProperties> {
  ...ResourceNameParameter<
    Resource = EncryptionProtector,
    KeyName = "encryptionProtectorName",
    SegmentName = "encryptionProtector",
    NamePattern = "",
    Type = EncryptionProtectorName
  >;

  /**
   * Kind of encryption protector. This is metadata used for the Azure portal experience.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  kind?: string;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface EncryptionProtectors {
  /**
   * Gets a server encryption protector.
   */
  get is ArmResourceRead<EncryptionProtector>;

  /**
   * Updates an existing encryption protector.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    EncryptionProtector,
    Response = ArmResourceUpdatedResponse<EncryptionProtector> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = EncryptionProtector> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of server encryption protectors
   */
  listByServer is ArmResourceListByParent<EncryptionProtector>;

  /**
   * Revalidates an existing encryption protector.
   */
  revalidate is ArmResourceActionAsync<EncryptionProtector, void, OkResponse>;
}

@@doc(EncryptionProtector.name,
  "The name of the encryption protector to be retrieved."
);
@@doc(EncryptionProtector.properties, "Resource properties.");
@@doc(EncryptionProtectors.createOrUpdate::parameters.resource,
  "The requested encryption protector resource state."
);
