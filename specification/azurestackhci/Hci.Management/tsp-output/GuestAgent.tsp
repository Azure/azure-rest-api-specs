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
/**
 * Defines the GuestAgent.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(VirtualMachineInstance)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(GuestAgentProperties)
model GuestAgent extends ProxyResourceBase {
  @key("guestAgent")
  @segment("guestAgents")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: GuestAgentProperties;
}

@armResourceOperations
interface GuestAgents {
  /**
   * Implements GuestAgent GET method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GuestAgent_Get")
  get is ArmResourceRead<GuestAgent>;

  /**
   * Create Or Update GuestAgent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GuestAgent_Create")
  create is ArmResourceCreateOrReplaceAsync<
    GuestAgent,
    BaseParameters<GuestAgent>,
    ArmAsyncOperationHeader
  >;

  /**
   * Implements GuestAgent DELETE method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GuestAgent_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<GuestAgent>;

  /**
   * Returns the list of GuestAgent of the given vm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GuestAgents_List")
  list is ArmResourceListByParent<GuestAgent>;
}

@@projectedName(GuestAgents.create::parameters.resource, "json", "body");
@@extension(GuestAgents.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(GuestAgents.create::parameters.resource, "Request payload.");
