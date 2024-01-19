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

namespace Microsoft.ServiceLinker;
@doc("Linker of source and target resource")
model LinkerResource is ExtensionResource<LinkerProperties> {
  @doc("The name Linker resource.")
  @path
  @key("linkerName")
  @segment("linkers")
  name: string;
}

@armResourceOperations
interface LinkerResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns Linker resource for a given name.")
  @operationId("Linker_Get")
  get is ArmResourceRead<LinkerResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update linker resource.")
  @operationId("Linker_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    LinkerResource,
    BaseParameters<LinkerResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to update an existing link.")
  @operationId("Linker_Update")
  update is ArmCustomPatchAsync<
    LinkerResource,
    LinkerPatch,
    BaseParameters<LinkerResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a link.")
  @operationId("Linker_Delete")
  delete is ArmResourceDeleteAsync<
    LinkerResource,
    BaseParameters<LinkerResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns list of Linkers which connects to the resource.")
  @operationId("Linker_List")
  list is ArmResourceListByParent<LinkerResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Validate a link.")
  @operationId("Linker_Validate")
  validate is ArmResourceActionAsync<
    LinkerResource,
    void,
    ValidateOperationResult,
    BaseParameters<LinkerResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("list source configurations for a linker.")
  @operationId("Linker_ListConfigurations")
  listConfigurations is ArmResourceActionSync<
    LinkerResource,
    void,
    SourceConfigurationResult
  >;
}

@@projectedName(LinkerResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(LinkerResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(LinkerResources.createOrUpdate::parameters.resource, "Linker details.");
@@projectedName(LinkerResources.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(LinkerResources.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(LinkerResources.update::parameters.properties, "Linker details.");
