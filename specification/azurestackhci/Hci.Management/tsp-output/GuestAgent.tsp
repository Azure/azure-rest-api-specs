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
@doc("Defines the GuestAgent.")
@singleton("default")
@parentResource(VirtualMachineInstance)
model GuestAgent is ProxyResource<GuestAgentProperties> {
  @key("guestAgent")
  @segment("guestAgents")
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
  create is ArmResourceCreateOrUpdateAsync<
    GuestAgent,
    BaseParameters<GuestAgent>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Implements GuestAgent DELETE method.")
  @operationId("GuestAgent_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<GuestAgent>;

  @doc("Returns the list of GuestAgent of the given vm.")
  list is ArmResourceListByParent<GuestAgent>;
}

@@projectedName(GuestAgents.create::parameters.resource, "json", "body");
@@extension(GuestAgents.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(GuestAgents.create::parameters.resource, "Request payload.");
