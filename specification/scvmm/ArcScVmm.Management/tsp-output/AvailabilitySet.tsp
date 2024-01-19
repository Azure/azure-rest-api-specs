import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ScVmm;
@doc("The AvailabilitySets resource definition.")
model AvailabilitySet is TrackedResource<AvailabilitySetProperties> {
  @doc("Name of the AvailabilitySet.")
  @path
  @key("availabilitySetName")
  @segment("availabilitySets")
  name: string;

  @doc("The extended location.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface AvailabilitySets {
  @doc("Implements AvailabilitySet GET method.")
  get is ArmResourceRead<AvailabilitySet>;

  @doc("Onboards the ScVmm availability set as an Azure resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    AvailabilitySet,
    BaseParameters<AvailabilitySet>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates the AvailabilitySets resource.")
  update is ArmCustomPatchAsync<
    AvailabilitySet,
    ResourcePatch,
    BaseParameters<AvailabilitySet>,
    ArmAsyncOperationHeader
  >;

  @doc("Deregisters the ScVmm availability set from Azure.")
  delete is ArmResourceDeleteAsync<
    AvailabilitySet,
    {
      ...BaseParameters<AvailabilitySet>;

      @doc("Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.")
      @query("force")
      force?: boolean;
    }
  >;

  @doc("List of AvailabilitySets in a resource group.")
  listByResourceGroup is ArmResourceListByParent<AvailabilitySet>;

  @doc("List of AvailabilitySets in a subscription.")
  listBySubscription is ArmListBySubscription<AvailabilitySet>;
}

@@projectedName(AvailabilitySets.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(AvailabilitySets.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(AvailabilitySets.createOrUpdate::parameters.resource, "Request payload.");
@@projectedName(AvailabilitySets.update::parameters.properties, "json", "body");
@@extension(AvailabilitySets.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(AvailabilitySets.update::parameters.properties,
  "AvailabilitySets patch payload."
);
