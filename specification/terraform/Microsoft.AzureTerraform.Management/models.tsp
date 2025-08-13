import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;

namespace Microsoft.AzureTerraform;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The parameter type")
union Type {
  string,
  ExportResource: "ExportResource",
  ExportResourceGroup: "ExportResourceGroup",
  ExportQuery: "ExportQuery",
}

@doc("The target Azure Terraform Provider")
union targetProvider {
  string,

  @doc("https://registry.terraform.io/providers/hashicorp/azurerm/latest")
  azurerm: "azurerm",

  @doc("https://registry.terraform.io/providers/Azure/azapi/latest")
  azapi: "azapi",
}

@doc("The Azure Resource Graph Authorization Scope Filter parameter")
union authorizationScopeFilter {
  string,

  @doc("Returns assignments for the given scope and all child scopes.")
  AtScopeAndBelow: "AtScopeAndBelow",

  @doc("Returns assignments for the given scope and all parent scopes, but not child scopes.")
  AtScopeAndAbove: "AtScopeAndAbove",

  @doc("Returns assignments for the given scope, all parent scopes, and all child scopes.")
  AtScopeAboveAndBelow: "AtScopeAboveAndBelow",

  @doc("Returns assignments only for the given scope; no parent or child scopes are included.")
  AtScopeExact: "AtScopeExact",
}

@doc("The base export parameter")
@discriminator("type")
model BaseExportModel {
  @doc("The parameter type")
  type: Type;

  @doc("The target Azure Terraform provider. Defaults to `azurerm`.")
  targetProvider?: targetProvider = targetProvider.azurerm;

  // What does this do when it's false?
  @doc("Whether to output all non-computed properties in the generated Terraform configuration. Defaults to `true`.")
  fullProperties?: boolean = true;

  @doc("Mask sensitive attributes in the Terraform configuration. Defaults to `true`.")
  maskSensitive?: boolean = true;

  @added(Versions.v2025_09_01_preview)
  @doc("Whether to include RBAC role assignments assigned to the resources exported. Only resource-scoped role assignments are supported. Defaults to `false`.")
  includeRoleAssignment?: boolean = false;

  @added(Versions.v2025_09_01_preview)
  @doc("Whether to include internal resources managed by Azure in the exported configuration. Defaults to `false`.")
  includeManagedResource?: boolean = false;

  // TODO is this and and or or?
  @added(Versions.v2025_06_01_preview)
  @doc("Exclude resources from being exported based on the Azure resource ID pattern (case-insensitive regexp)")
  excludeAzureResource?: string[];

  // TODO what are example values, is this and and or or?
  @added(Versions.v2025_06_01_preview)
  @doc("Exclude resources from being exported based on the Terraform resource type")
  excludeTerraformResource?: string[];
}

@doc("Uses ARG (Azure Resource Graph) query to choose resources to be exported.")
model ExportQuery extends BaseExportModel {
  @doc("The ARG where predicate. Multiple conditions can be combined in one `where` predicate, for example: `resourceGroup =~ \"my-rg\" and type =~ \"microsoft.network/virtualnetworks\"`.")
  query: string;

  @doc("The id prefix for the exported Terraform resources. Defaults to `res-`.")
  namePattern?: string = "res-";

  @doc("Recursively includes child resources. Defaults to `false`.")
  recursive?: boolean = false;

  @doc("Has to be `ExportQuery` to distinguish from other types.")
  type: Type.ExportQuery;

  // What if resource are spread across multiple RGs?
  @added(Versions.v2025_09_01_preview)
  @doc("Includes the resource group in the exported Terraform resources. Defaults to `false`.")
  includeResourceGroup?: boolean = false;

  @doc("The ARG table name. Defaults to 'Resources'.")
  table?: string = "Resources";

  // What is the default?
  @doc("The ARG Scope Filter parameter.")
  authorizationScopeFilter?: authorizationScopeFilter;
}

@doc("Specified resources to be exported by their ids.")
model ExportResource extends BaseExportModel {
  // Add Maximum number of resource
  @doc("The id(s) of the resource to be exported. Example: `[\"/subscriptions/12345678-1234-1234-1234-1234567890ab/resourceGroups/my-rg\"].")
  resourceIds: armResourceIdentifier[];

  @doc("The Terraform id of the exported resource. Only effective when `resourceIds` contains only one item. Defaults to `res-0`.")
  resourceName?: string = "res-0";

  // Does this work like an override?
  @doc("The Terraform resource type. Only works when `resourceIds` contains only one item.")
  resourceType?: string;

  @doc("The id prefix for the exported Terraform resources. Defaults to `res-`.")
  namePattern?: string = "res-";

  @doc("Has to be `ExportResource` to distinguish from other types.")
  type: Type.ExportResource;

  @added(Versions.v2025_09_01_preview)
  @doc("Recursively includes child resources. Defaults to `false`.")
  recursive?: boolean = false;

  @added(Versions.v2025_09_01_preview)
  @doc("Includes the resource group in the exported Terraform resources. Defaults to `false`.")
  includeResourceGroup?: boolean = false;
}

@doc("Export parameter for a resource group")
model ExportResourceGroup extends BaseExportModel {
  @doc("The name of the resource group to be exported.")
  resourceGroupName: string;

  @doc("The id prefix for the exported Terraform resources. Defaults to `res-`.")
  namePattern?: string = "res-";

  @doc("Has to be `ExportResourceGroup` to distinguish from other types.")
  type: Type.ExportResourceGroup;
}

@doc("The status of the LRO (Long Running Operation) and the export result.")
model TerraformOperationStatus is ArmOperationStatus<ExportResult>;

@doc("The Terraform export result")
model ExportResult {
  @doc("The exported Terraform HCL configuration.")
  configuration?: string;

  @doc("The Terraform import blocks for the configuration, necessary for managing existing Azure resources in Terraform.")
  `import`?: string;

  @doc("A list of Azure resources which could not be exported to Terraform. The most common cause is lack of Terraform provider support. Change the provider type to `azapi` for bigger set of supported resources.")
  skippedResources?: armResourceIdentifier[];

  @doc("A list of errors encountered during export operation.")
  @identifiers(#[])
  errors?: ErrorDetail[];
}
