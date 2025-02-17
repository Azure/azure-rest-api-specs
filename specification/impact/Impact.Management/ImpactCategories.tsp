import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Impact;

@doc("ImpactCategory resource")
@subscriptionResource
model ImpactCategory
  is Azure.ResourceManager.ProxyResource<ImpactCategoryProperties> {
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9.]*[a-zA-Z0-9]{3,180}$")
  @key("impactCategoryName")
  @segment("impactCategories")
  @doc("Name of the impact category")
  @visibility("Read")
  @path
  name: string;
}

@doc("Impact category properties.")
model ImpactCategoryProperties is ResourceProperties {
  @doc("Unique ID of the category")
  @pattern("[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}")
  categoryId: string;

  @doc("Unique ID of the parent category")
  @pattern("[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}")
  parentCategoryId?: string;

  @doc("Description of the category")
  description?: string;

  @doc("The workloadImpact properties which are required when reporting with the impact category")
  @extension("x-ms-identifiers", [])
  requiredImpactProperties?: RequiredImpactProperties[];
}

@doc("Required impact properties")
model RequiredImpactProperties {
  @doc("Name of the property")
  name: string;

  @doc("Allowed values values for the property")
  allowedValues?: string[];
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-uses-templates" "Using subscription scope building blocks"
@armResourceOperations
interface ImpactCategories {
  get is ArmResourceRead<ImpactCategory>;

  //listBySubscription is ArmListBySubscription<ImpactCategory>;

  listBySubscription is ArmResourceListByParent<
    ImpactCategory,
    BaseParameters<ImpactCategory> & CustomParameters
  >;
}

@doc("Custom query params")
model CustomParameters {
  @query
  @minLength(1)
  @doc("Filter by category name ")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9.]*[a-zA-Z0-9]{3,180}$")
  categoryName?: string;

  @query
  @minLength(1)
  @doc("Filter by resource type")
  resourceType: string;
}
