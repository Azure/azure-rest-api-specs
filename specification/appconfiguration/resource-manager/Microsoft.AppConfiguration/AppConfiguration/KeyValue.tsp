import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConfigurationStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppConfiguration;
/**
 * The key-value resource along with all resource properties.
 */
@parentResource(ConfigurationStore)
model KeyValue is Azure.ResourceManager.ProxyResource<KeyValueProperties> {
  ...ResourceNameParameter<
    Resource = KeyValue,
    KeyName = "keyValueName",
    SegmentName = "keyValues",
    NamePattern = ""
  >;
}

@armResourceOperations
interface KeyValues {
  /**
   * Gets the properties of the specified key-value. NOTE: This operation is intended for use in ARM Template deployments. For all other scenarios involving App Configuration key-values the data plane API should be used instead.
   */
  get is ArmResourceRead<KeyValue>;

  /**
   * Creates a key-value. NOTE: This operation is intended for use in ARM Template deployments. For all other scenarios involving App Configuration key-values the data plane API should be used instead.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    KeyValue,
    Response = ArmResourceUpdatedResponse<KeyValue>
  >;

  /**
   * Deletes a key-value. NOTE: This operation is intended for use in ARM Template deployments. For all other scenarios involving App Configuration key-values the data plane API should be used instead.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    KeyValue,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;
}

@@doc(KeyValue.name,
  "Identifier of key and label combination. Key and label are joined by $ character. Label is optional."
);
@@doc(KeyValue.properties, "All key-value properties.");
@@doc(KeyValues.createOrUpdate::parameters.resource,
  "The parameters for creating a key-value."
);
