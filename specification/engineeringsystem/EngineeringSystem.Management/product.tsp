import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.EngineeringSystem;

/** Product resource. */
model Product is ProxyResource<ProductProperties> {
  ...ResourceNameParameter<Product>;
}

/** The properties of Product resource. */
model ProductProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Products {
  get is ArmResourceRead<Product>;
  listByResourceGroup is ArmResourceListByParent<Product>;
}
