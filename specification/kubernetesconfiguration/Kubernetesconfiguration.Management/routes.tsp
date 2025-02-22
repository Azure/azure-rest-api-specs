import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.KubernetesConfiguration;

model OperationModel is ProxyResource<OperationsParameter> {
  /**
   * Name of the Extension.
   */
  @path
  @key("operationName")
  @segment("operations")
  @visibility("read")
  @pattern("/^[a-zA-Z0-9-]{3,24}$/")
  name: string;
}

@armResourceOperations
interface OperationStatus {
  /**
   * List all operations in the cluster.
   */
  list is ArmResourceListByParent<
    OperationModel,
    BaseParameters = CustomBaseParameters<OperationModel>
  >;
}
