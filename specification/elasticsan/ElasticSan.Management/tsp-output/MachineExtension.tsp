import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Machine.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridCompute;
@doc("Describes a Machine Extension.")
@parentResource(Machine)
model MachineExtension is TrackedResource<MachineExtensionProperties> {
  @doc("The name of the machine extension.")
  @path
  @key("extensionName")
  @segment("extensions")
  name: string;
}

@armResourceOperations
interface MachineExtensions {
  @doc("The operation to get the extension.")
  get is ArmResourceRead<MachineExtension>;

  @doc("The operation to create or update the extension.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MachineExtension>;

  @doc("The operation to create or update the extension.")
  update is ArmCustomPatchAsync<MachineExtension, MachineExtensionUpdate>;

  @doc("The operation to delete the extension.")
  delete is ArmResourceDeleteAsync<MachineExtension>;

  @doc("The operation to get all extensions of a non-Azure machine")
  list is ArmResourceListByParent<
    MachineExtension,
    {
      ...BaseParameters<MachineExtension>;

      @doc("The expand expression to apply on the operation.")
      @query("$expand")
      $expand?: string;
    }
  >;
}

@@projectedName(MachineExtensions.createOrUpdate::parameters.resource,
  "json",
  "extensionParameters"
);
@@extension(MachineExtensions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "extensionParameters"
);
@@doc(MachineExtensions.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create Machine Extension operation."
);
@@projectedName(MachineExtensions.update::parameters.properties,
  "json",
  "extensionParameters"
);
@@extension(MachineExtensions.update::parameters.properties,
  "x-ms-client-name",
  "extensionParameters"
);
@@doc(MachineExtensions.update::parameters.properties,
  "Parameters supplied to the Create Machine Extension operation."
);
