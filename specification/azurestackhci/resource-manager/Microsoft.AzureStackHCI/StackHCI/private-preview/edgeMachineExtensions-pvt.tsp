import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";

using Azure.ClientGenerator.Core;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Details of a particular extension in EdgeMachine.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
@parentResource(EdgeMachine)
model EdgeMachineExtension
  is Azure.ResourceManager.ProxyResource<ExtensionProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineExtension,
    KeyName = "extensionName",
    SegmentName = "extensions",
    NamePattern = ""
  >;
}

@@clientName(EdgeMachineExtensions.create::parameters.resource, "extension");
/**
 * CRUD + List operations for Edge Machine Extensions.
 */
@armResourceOperations
interface EdgeMachineExtensions {
  /**
   * Get a specific Extension on an Edge Machine.
   */
  get is ArmResourceRead<EdgeMachineExtension>;

  /**
   * Create or replace an Extension on an Edge Machine.
   */
  create is ArmResourceCreateOrReplaceAsync<EdgeMachineExtension>;

  /**
   * Delete Extension on an Edge Machine.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    EdgeMachineExtension,
    Response = ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List all Extensions on an Edge Machine.
   */
  listByEdgeMachine is ArmResourceListByParent<
    EdgeMachineExtension,
    Response = ArmResponse<EdgeMachineExtensionList>
  >;
}

// Model

/**
 * List of Extensions in Edge Machine.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model EdgeMachineExtensionList is Azure.Core.Page<EdgeMachineExtension>;
