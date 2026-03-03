import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * The managed instance encryption protector.
 */
@parentResource(ManagedInstance)
model ManagedInstanceEncryptionProtector
  is Azure.ResourceManager.ProxyResource<ManagedInstanceEncryptionProtectorProperties> {
  ...ResourceNameParameter<
    Resource = ManagedInstanceEncryptionProtector,
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
}

@armResourceOperations
interface ManagedInstanceEncryptionProtectors {
  /**
   * Gets a managed instance encryption protector.
   */
  get is ArmResourceRead<ManagedInstanceEncryptionProtector>;

  /**
   * Updates an existing encryption protector.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedInstanceEncryptionProtector,
    Response = ArmResourceUpdatedResponse<ManagedInstanceEncryptionProtector> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ManagedInstanceEncryptionProtector> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of managed instance encryption protectors
   */
  listByInstance is ArmResourceListByParent<ManagedInstanceEncryptionProtector>;

  /**
   * Revalidates an existing encryption protector.
   */
  revalidate is ArmResourceActionAsync<
    ManagedInstanceEncryptionProtector,
    void,
    OkResponse
  >;
}

@@doc(ManagedInstanceEncryptionProtector.name,
  "The name of the encryption protector to be retrieved."
);
@@doc(ManagedInstanceEncryptionProtector.properties, "Resource properties.");
@@doc(ManagedInstanceEncryptionProtectors.createOrUpdate::parameters.resource,
  "The requested encryption protector resource state."
);
