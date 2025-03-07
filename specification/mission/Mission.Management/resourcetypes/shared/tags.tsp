import "@azure-tools/typespec-azure-resource-manager";

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

using Azure.ResourceManager;

@doc("Tags associated with the resource.")
model TagsProperty {
  @doc("Tags associated with the resource.")
  tags?: Azure.ResourceManager.Foundations.ArmTagsProperty;
}
