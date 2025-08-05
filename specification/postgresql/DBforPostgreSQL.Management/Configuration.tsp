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
 * Configuration (also known as server parameter).
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
   * Gets information about a specific configuration (also known as server parameter) of a server.
   */
  get is ArmResourceRead<Configuration>;

  /**
   * Updates, using Put verb, the value assigned to a specific modifiable configuration (also known as server parameter) of a server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  put is ArmResourceCreateOrReplaceAsync<
    Configuration,
    Response = ArmAcceptedLroResponse
  >;

  /**
   * Updates the value assigned to a specific modifiable configuration (also known as server parameter) of a server.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Configuration,
    PatchModel = ConfigurationForUpdate,
    Response = ArmAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Lists all configurations (also known as server parameters) of a server.
   */
  listByServer is ArmResourceListByParent<
    Configuration,
    Response = ArmResponse<ConfigurationList>
  >;
}

@@maxLength(Configuration.name, 256);
@@minLength(Configuration.name, 1);
@@doc(Configuration.name,
  "Name of the configuration (also known as server parameter)."
);
@@doc(Configuration.properties,
  "Properties of a configuration (also known as server parameter)."
);
@@doc(Configurations.put::parameters.resource,
  "Parameters required to update the value of a specific modifiable configuration (also known as server parameter)."
);
@@doc(Configurations.update::parameters.properties,
  "Parameters required to update the value of a specific modifiable configuration (also known as server parameter)."
);
