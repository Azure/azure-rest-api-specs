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
model ProvisionedMachineExtension
  is Azure.ResourceManager.ProxyResource<ExtensionProperties> {
  ...ResourceNameParameter<
    Resource = ProvisionedMachineExtension,
    KeyName = "extensionName",
    SegmentName = "extensions",
    NamePattern = ""
  >;
}

@@clientName(ProvisionedMachineExtensions.create::parameters.resource,
  "extension"
);
/**
 * CRUD + List operations for Provisioned Machine Extensions.
 */
@armResourceOperations
interface ProvisionedMachineExtensions {
  /**
   * Get a specific Extension on an Provisioned Machine.
   */
  get is ArmResourceRead<ProvisionedMachineExtension>;

  /**
   * Create or replace an Extension on an Provisioned Machine.
   */
  create is ArmResourceCreateOrReplaceAsync<ProvisionedMachineExtension>;

  /**
   * Delete Extension on an Provisioned Machine.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ProvisionedMachineExtension,
    Response = ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List all Extensions on an Provisioned Machine.
   */
  listByProvisionedMachine is ArmResourceListByParent<
    ProvisionedMachineExtension,
    Response = ArmResponse<ProvisionedMachineExtensionList>
  >;
}

// Model
/**
 * Describes the parameters for Extension upgrade.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model ProvisionedMachineExtensionUpgradeParameters {
  /**
   * Extension Upgrade Target Version.
   */
  targetVersion?: string;
}

/**
 * List of Extensions in Provisioned Machine.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model ProvisionedMachineExtensionList
  is Azure.Core.Page<ProvisionedMachineExtension>;
