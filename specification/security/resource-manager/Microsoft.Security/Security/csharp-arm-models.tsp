import "@azure-tools/typespec-azure-resource-manager";

// This model is defined in the ARM Models namespace so C# maps it to
// Azure.ResourceManager.Resources.Models.SubResource via @@alternateType.
namespace Azure.ResourceManager.Models {
  /** Represents a reference to an existing resource by its id. */
  model SubResource {
    /** The resource id. */
    id?: Azure.Core.armResourceIdentifier;
  }
}
