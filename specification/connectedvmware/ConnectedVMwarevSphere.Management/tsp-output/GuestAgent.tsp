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

namespace Microsoft.ConnectedVMwarevSphere;
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
  @operationId("VMInstanceGuestAgents_Get")
  get is ArmResourceRead<GuestAgent>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create Or Update GuestAgent.")
  @operationId("VMInstanceGuestAgents_Create")
  create is ArmResourceCreateOrUpdateAsync<
    GuestAgent,
    BaseParameters<GuestAgent>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Implements GuestAgent DELETE method.")
  @operationId("VMInstanceGuestAgents_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<GuestAgent>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the list of GuestAgent of the given vm.")
  @operationId("VMInstanceGuestAgents_List")
  list is ArmResourceListByParent<GuestAgent>;
}

@@projectedName(GuestAgents.create::parameters.resource, "json", "body");
@@extension(GuestAgents.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(GuestAgents.create::parameters.resource, "Request payload.");
