import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ScVmm;
/** The AvailabilitySets resource definition. */
model AvailabilitySet is TrackedResource<AvailabilitySetProperties> {
  /** Name of the AvailabilitySet. */
  @maxLength(54)
  @minLength(1)
  @pattern("[a-zA-Z0-9-_\\.]")
  @path
  @key("availabilitySetResourceName")
  @segment("availabilitySets")
  name: string;

  /** The extended location. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This property is allowed but not recognized by the linter"
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface AvailabilitySets {
  /** Implements AvailabilitySet GET method. */
  get is ArmResourceRead<AvailabilitySet>;
  /** Onboards the ScVmm availability set as an Azure resource. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AvailabilitySet,
    LroHeaders = ArmAsyncOperationHeader
  >;
  /** Updates the AvailabilitySets resource. */
  update is ArmTagsPatchAsync<AvailabilitySet>;
  /** Deregisters the ScVmm availability set from Azure. */
  delete is ArmResourceDeleteWithoutOkAsync<
    AvailabilitySet,
    {
      ...BaseParameters<AvailabilitySet>;
      ...QueryForceDelete;
    },
    LroHeaders = ArmAsyncOperationHeader & ArmLroLocationHeader
  >;
  /** List of AvailabilitySets in a resource group. */
  listByResourceGroup is ArmResourceListByParent<AvailabilitySet>;
  /** List of AvailabilitySets in a subscription. */
  listBySubscription is ArmListBySubscription<AvailabilitySet>;
}
