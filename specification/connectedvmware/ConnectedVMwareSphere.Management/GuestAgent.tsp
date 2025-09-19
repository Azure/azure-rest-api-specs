import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachineInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConnectedVMwarevSphere;
/**
 * Defines the GuestAgent.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@singleton("default")
@extensionResource
@parentResource(VirtualMachineInstance)
model GuestAgent
  is Azure.ResourceManager.ExtensionResource<GuestAgentProperties, false> {
  ...ResourceNameParameter<
    Resource = GuestAgent,
    KeyName = "guestAgent",
    SegmentName = "guestAgents",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GuestAgentsOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,

        /**
         * The fully qualified Azure Resource manager identifier of the resource.
         */
        @path(#{ allowReserved: true })
        resourceUri: string,
      },
      {},
      {
        ...Extension.ExtensionProviderNamespace<GuestAgent>,
        ...KeysOf<GuestAgent>,
      }
    > {}

@armResourceOperations
interface GuestAgents {
  /**
   * Implements GuestAgent GET method.
   */
  get is ArmResourceRead<
    GuestAgent,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters
  >;

  /**
   * Create Or Update GuestAgent.
   */
  create is GuestAgentsOps.CreateOrUpdateAsync<
    GuestAgent,
    OptionalRequestBody = true
  >;

  /**
   * Implements GuestAgent DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    GuestAgent,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters
  >;

  /**
   * Returns the list of GuestAgent of the given vm.
   */
  list is ArmResourceListByParent<
    GuestAgent,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Response = ArmResponse<GuestAgentList>
  >;
}

@@doc(GuestAgent.name, "");
@@doc(GuestAgent.properties, "Resource properties.");
@@doc(GuestAgents.create::parameters.resource, "Request payload.");
