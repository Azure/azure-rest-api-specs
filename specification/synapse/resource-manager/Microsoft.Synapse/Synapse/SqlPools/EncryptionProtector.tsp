import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace SqlPools;
/**
 * The server encryption protector.
 */
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

alias EncryptionProtectorOps = Azure.ResourceManager.Legacy.LegacyOperations<
  WorkspaceParentParameters,
  {
    /** The name of the encryption protector. */
    @segment("encryptionProtector")
    @key
    @path
    encryptionProtectorName: EncryptionProtectorName;
  }
>;

@armResourceOperations
interface EncryptionProtectors {
  /**
   * Get workspace managed sql server's encryption protector.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagedSqlServerEncryptionProtector_Get")
  get is EncryptionProtectorOps.Read<EncryptionProtector>;

  /**
   * Updates workspace managed sql server's encryption protector.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WorkspaceManagedSqlServerEncryptionProtector_CreateOrUpdate")
  createOrUpdate is EncryptionProtectorOps.CreateOrUpdateAsync<
    EncryptionProtector,
    Response =
      | ArmResourceUpdatedResponse<EncryptionProtector>
      | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = EncryptionProtector> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Get list of encryption protectors for workspace managed sql server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagedSqlServerEncryptionProtector_List")
  list is EncryptionProtectorOps.List<
    EncryptionProtector,
    Response = ArmResponse<EncryptionProtectorListResult>
  >;

  /**
   * Revalidates workspace managed sql server's existing encryption protector.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagedSqlServerEncryptionProtector_Revalidate")
  revalidate is EncryptionProtectorOps.ActionAsync<
    EncryptionProtector,
    void,
    OkResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(EncryptionProtector.name, "The name of the encryption protector.");
@@doc(EncryptionProtector.properties, "Resource properties.");
@@doc(
  EncryptionProtectors.createOrUpdate::parameters.resource,
  "The requested encryption protector resource state."
);
