import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using OpenAPI;

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
  @summary("Gets an AvailabilitySet.")
  get is ArmResourceRead<AvailabilitySet>;
  /** Onboards the ScVmm availability set as an Azure resource. */
  @summary("Implements AvailabilitySets PUT method.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AvailabilitySet,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
  /** Updates the AvailabilitySets resource. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
  @summary("Implements the AvailabilitySets PATCH method.")
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  update is ArmTagsPatchAsync<AvailabilitySet>;
  /** Deregisters the ScVmm availability set from Azure. */
  @summary("Implements AvailabilitySet DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<
    AvailabilitySet,
    {
      ...Foundations.BaseParameters<AvailabilitySet>;
      ...QueryForceDelete;
    },
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
  /** List of AvailabilitySets in a resource group. */
  @summary("Implements GET AvailabilitySets in a resource group.")
  listByResourceGroup is ArmResourceListByParent<AvailabilitySet>;
  /** List of AvailabilitySets in a subscription. */
  @summary("Implements GET AvailabilitySets in a subscription.")
  listBySubscription is ArmListBySubscription<AvailabilitySet>;
}
