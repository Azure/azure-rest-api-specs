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

namespace Microsoft.DBforMySQL;
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
    NamePattern = ""
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Configuration,
    Response = ArmResourceUpdatedResponse<Configuration> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a configuration of a server.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Configuration, PatchModel = Configuration>;

  /**
   * List all the configurations in a given server.
   */
  listByServer is ArmResourceListByParent<
    Configuration,
    Parameters = {
      /**
       * The tags of the server configuration.
       */
      @query("tags")
      tags?: string;

      /**
       * The keyword of the server configuration.
       */
      @query("keyword")
      keyword?: string;

      /**
       * The page of the server configuration.
       */
      @query("page")
      page?: int32;

      /**
       * The pageSize of the server configuration.
       */
      @query("pageSize")
      pageSize?: int32;
    },
    Response = ArmResponse<ConfigurationListResult>
  >;

  /**
   * Update a list of configurations in a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("updateConfigurations")
  @operationId("Configurations_BatchUpdate")
  batchUpdate is ArmResourceActionAsync<
    Server,
    ConfigurationListForBatchUpdate,
    ArmResponse<Configuration>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(Configuration.name, "The name of the server configuration.");
@@doc(Configuration.properties, "The properties of a configuration.");
@@doc(Configurations.createOrUpdate::parameters.resource,
  "The required parameters for updating a server configuration."
);
@@doc(Configurations.update::parameters.properties,
  "The required parameters for updating a server configuration."
);
@@doc(Configurations.batchUpdate::parameters.body,
  "The parameters for updating a list of server configuration."
);
