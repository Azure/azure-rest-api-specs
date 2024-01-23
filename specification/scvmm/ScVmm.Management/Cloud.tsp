import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ScVmm;
/** The Clouds resource definition. */
model Cloud is TrackedResource<CloudProperties> {
  /** Name of the Cloud. */
  @maxLength(54)
  @minLength(1)
  @pattern("[a-zA-Z0-9-_\\.]")
  @path
  @key("cloudResourceName")
  @segment("clouds")
  name: string;

  /** The extended location. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This property is allowed but not recognized by the linter"
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Clouds {
  /** Implements Cloud GET method. */
  get is ArmResourceRead<Cloud>;
  /** Onboards the ScVmm fabric cloud as an Azure cloud resource. */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Cloud>;
  /** Updates the Clouds resource. */
  update is ArmTagsPatchAsync<Cloud>;
  /** Deregisters the ScVmm fabric cloud from Azure. */
  delete is ArmResourceDeleteWithoutOkAsync<
    Cloud,
    {
      ...BaseParameters<Cloud>;
      ...QueryForceDelete;
    }
  >;
  /** List of Clouds in a resource group. */
  listByResourceGroup is ArmResourceListByParent<Cloud>;
  /** List of Clouds in a subscription. */
  listBySubscription is ArmListBySubscription<Cloud>;
}
