import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./Console_models.tsp";
import "./VirtualMachine.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.NetworkCloud;
/**
 * The name of the virtual machine console.
 */
model ConsoleNameParameter
  is ResourceNameParameter<
    Resource = Console,
    KeyName = "consoleName",
    SegmentName = "consoles",
    NamePattern = "^default$"
  >;

/**
 * Console represents the console of an on-premises Network Cloud virtual machine.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
@parentResource(VirtualMachine)
model Console
  is Azure.ResourceManager.TrackedResource<ConsoleProperties, false> {
  ...ConsoleNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...RequiredExtendedLocationProperty;
}

@armResourceOperations
interface Consoles {
  /**
   * Get properties of the provided virtual machine console.
   */
  get is ArmResourceRead<Console>;

  /**
   * Create a new virtual machine console or update the properties of the existing virtual machine console.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Console,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Console>
  >;

  /**
   * Patch the properties of the provided virtual machine console, or update the tags associated with the virtual machine console. Properties and tag updates can be done independently.
   */
  @patch(#{ implicitOptionality: false })
  /* Note: It is preferred to use Azure.ResourceManager.ArmCustomPatchAsync, for existing resources the patch body is (nonsensically) "optional", and this is the only way to achieve it. */
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    Console,
    PatchModel = ConsolePatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Console> &
      ArmLroLocationHeader<FinalResult = Console>,
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided virtual machine console.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Console,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of consoles for the provided virtual machine.
   */
  listByVirtualMachine is ArmResourceListByParent<
    Console,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<ConsoleList>
  >;
}

@@doc(Console.name, "The name of the virtual machine console.");
@@doc(Console.properties, "The list of the resource properties.");
@@doc(Consoles.createOrUpdate::parameters.resource, "The request body.");
@@doc(Consoles.update::parameters.properties, "The request body.");
