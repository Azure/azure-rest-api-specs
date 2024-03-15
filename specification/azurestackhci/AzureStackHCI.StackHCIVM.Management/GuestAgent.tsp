import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachineInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("Defines the GuestAgent.")
@singleton("default")
@parentResource(VirtualMachineInstance)
@includeInapplicableMetadataInPayload(false)
model GuestAgent is ProxyResource<GuestAgentProperties> {
  @doc("guestAgent name")
  @key("guestAgent")
  @segment("guestAgents")
  @visibility("read")
  @path
  name: string;
}

@armResourceOperations
interface GuestAgents {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Implements GuestAgent GET method.")
  @operationId("GuestAgent_Get")
  get is ArmResourceRead<GuestAgent>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create Or Update GuestAgent.")
  @operationId("GuestAgent_Create")
  create is ArmResourceCreateOrReplaceAsync<
    GuestAgent,
    LroHeaders = ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Implements GuestAgent DELETE method.")
  @operationId("GuestAgent_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<GuestAgent>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the list of GuestAgent of the given vm.")
  @operationId("GuestAgents_List")
  list is ArmResourceListByParent<GuestAgent>;
}
