import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachine.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * Console represents the console of an on-premises Network Cloud virtual machine.
 */
@parentResource(VirtualMachine)
model Console
  is Azure.ResourceManager.TrackedResource<ConsoleProperties, false> {
  ...ResourceNameParameter<
    Resource = Console,
    KeyName = "consoleName",
    SegmentName = "consoles",
    NamePattern = "^default$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;

  /**
   * The extended location of the cluster manager associated with the cluster this virtual machine is created on.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation: ExtendedLocation;
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
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    }
  >;

  /**
   * Patch the properties of the provided virtual machine console, or update the tags associated with the virtual machine console. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    Console,
    PatchModel = ConsolePatchParameters,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    },
    Response = ArmResponse<Console> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = Console> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: Console;

      /**
       * The URL to retrieve the status of the asynchronous operation.
       */
      @header("Location")
      location: string;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided virtual machine console.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Console,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of consoles for the provided virtual machine.
   */
  listByVirtualMachine is ArmResourceListByParent<
    Console,
    Response = ArmResponse<ConsoleList>
  >;
}

@@doc(Console.name, "The name of the virtual machine console.");
@@encodedName(Console.eTag, "application/json", "etag");
@@doc(Console.properties, "The list of the resource properties.");
@@doc(Consoles.createOrUpdate::parameters.resource, "The request body.");
@@doc(Consoles.update::parameters.properties, "The request body.");
