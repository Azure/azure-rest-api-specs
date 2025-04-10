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

namespace Microsoft.DBforPostgreSQL;
/**
 * Represents a Configuration.
 */
@parentResource(Server)
model Configuration
  is Azure.ResourceManager.ProxyResource<ConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = Configuration,
    KeyName = "configurationName",
    SegmentName = "configurations",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface Configurations {
  /**
   * Gets information about a configuration of server.
   */
  get is ArmResourceRead<Configuration>;

  /**
   * Updates a configuration of a server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  put is ArmResourceCreateOrReplaceAsync<
    Configuration,
    Response = ArmResourceUpdatedResponse<Configuration> | ArmResourceCreatedResponse<
      Configuration,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Updates a configuration of a server.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Configuration,
    PatchModel = ConfigurationForUpdate,
    Response = ArmResponse<Configuration> | ArmResourceCreatedResponse<Configuration> | ArmAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * List all the configurations in a given server.
   */
  listByServer is ArmResourceListByParent<Configuration>;
}

@@minLength(Configuration.name, 1);
@@doc(Configuration.name, "The name of the server configuration.");
@@doc(Configuration.properties, "The properties of a configuration.");
@@doc(Configurations.put::parameters.resource,
  "The required parameters for updating a server configuration."
);
@@doc(Configurations.update::parameters.properties,
  "The required parameters for updating a server configuration."
);
