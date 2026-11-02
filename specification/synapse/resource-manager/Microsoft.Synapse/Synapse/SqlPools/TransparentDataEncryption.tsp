import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * Represents a Sql pool transparent data encryption configuration.
 */
@parentResource(SqlPool)
model TransparentDataEncryption
  is Azure.ResourceManager.ProxyResource<TransparentDataEncryptionProperties> {
  ...ResourceNameParameter<
    Resource = TransparentDataEncryption,
    KeyName = "transparentDataEncryptionName",
    SegmentName = "transparentDataEncryption",
    NamePattern = "",
    Type = TransparentDataEncryptionName
  >;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface TransparentDataEncryptions {
  /**
   * Get a SQL pool's transparent data encryption configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolTransparentDataEncryptions_Get")
  get is ArmResourceRead<TransparentDataEncryption>;

  /**
   * Creates or updates a Sql pool's transparent data encryption configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolTransparentDataEncryptions_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<TransparentDataEncryption>;

  /**
   * Get list of SQL pool's transparent data encryption configurations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolTransparentDataEncryptions_List")
  list is ArmResourceListByParent<TransparentDataEncryption>;
}

@@doc(
  TransparentDataEncryption.name,
  "The name of the transparent data encryption configuration."
);
@@doc(
  TransparentDataEncryption.properties,
  "Represents the properties of the resource."
);
@@doc(
  TransparentDataEncryptions.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating transparent data encryption."
);
