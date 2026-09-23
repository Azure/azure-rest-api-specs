import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

namespace Microsoft.ComputeBulkActions;

@doc("Defines a virtual machine extension.")
model VirtualMachineExtension {
  @doc("The name of the virtual machine extension.")
  name: string;

  @doc("Properties of the virtual machine extension.")
  properties: VirtualMachineExtensionProperties;
}

@doc("Describes the properties of a Virtual Machine Extension.")
model VirtualMachineExtensionProperties {
  @doc("How the extension handler should be forced to update even if the extension configuration has not changed.")
  forceUpdateTag?: string;

  @doc("The name of the extension handler publisher.")
  publisher?: string;

  @doc("Specifies the type of the extension; an example is 'CustomScriptExtension'.")
  type?: string;

  @doc("Specifies the version of the script handler.")
  typeHandlerVersion?: string;

  @doc("Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true.")
  autoUpgradeMinorVersion?: boolean;

  @doc("Indicates whether the extension should be automatically upgraded by the platform if there is a newer version of the extension available.")
  enableAutomaticUpgrade?: boolean;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This field is using the existing compute context for settings where this field is a free-form JSON object."
  @doc("JSON formatted public settings for the extension.")
  settings?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This field is using the existing compute context for protectedSettings where this field is a free-form JSON object."
  @doc("The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all.")
  protectedSettings?: Record<unknown>;

  @doc("Indicates whether failures stemming from the extension will be suppressed (Operational failures such as not connecting to the VM will not be suppressed regardless of this value). The default is false.")
  suppressFailures?: boolean;

  @doc("The extensions protected settings that are passed by reference, and consumed from key vault")
  protectedSettingsFromKeyVault?: KeyVaultSecretReference;

  @doc("Collection of extension names after which this extension needs to be provisioned.")
  provisionAfterExtensions?: string[];
}
