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

  @doc("The target Azure Terraform Provider")
  targetProvider?: targetProvider = targetProvider.azurerm;

  @doc("Whether to output all non-computed properties in the generated Terraform configuration? This probably needs manual modifications to make it valid")
  fullProperties?: boolean = true;

  @doc("Mask sensitive attributes in the Terraform configuration")
  maskSensitive?: boolean = true;

  @added(Versions.v2025_06_01_preview)
  @doc("Exclude resources from being exported based on the Azure resource ID pattern (case-insensitive regexp)")
  excludeAzureResource?: string[];

  @added(Versions.v2025_06_01_preview)
  @doc("Exclude resources from being exported based on the Terraform resource type")
  excludeTerraformResource?: string[];
}

@doc("Export parameter for resources queried by ARG (Azure Resource Graph)")
model ExportQuery extends BaseExportModel {
  @doc("The ARG where predicate. Note that you can combine multiple conditions in one `where` predicate, e.g. `resourceGroup =~ \"my-rg\" and type =~ \"microsoft.network/virtualnetworks\"`")
  query: string;

  @doc("The name pattern of the Terraform resources")
  namePattern?: string = "res-";

  @doc("Whether to recursively list child resources of the query result")
  recursive?: boolean = false;

  @doc("The parameter type")
  type: "ExportQuery";

  @doc("The ARG table name")
  table?: string = "Resources";

  @doc("The ARG Scope Filter parameter")
  authorizationScopeFilter?: authorizationScopeFilter;
}

@doc("Export parameter for individual resources.")
model ExportResource extends BaseExportModel {
  @doc("The id of the resource to be exported")
  resourceIds: armResourceIdentifier[];

  @doc("The Terraform resource name. Only works when `resourceIds` contains only one item.")
  resourceName?: string = "res-0";

  @doc("The Terraform resource type. Only works when `resourceIds` contains only one item.")
  resourceType?: string;

  @doc("The name pattern of the Terraform resources")
  namePattern?: string = "res-";

  @doc("The parameter type")
  type: "ExportResource";
}

@doc("Export parameter for a resource group")
model ExportResourceGroup extends BaseExportModel {
  @doc("The name of the resource group to be exported")
  resourceGroupName: string;

  @doc("The name pattern of the Terraform resources")
  namePattern?: string = "res-";

  @doc("The parameter type")
  type: "ExportResourceGroup";
}

@doc("The status of the LRO operation.")
model TerraformOperationStatus is ArmOperationStatus<ExportResult>;

@doc("The Terraform export result")
model ExportResult {
  @doc("The Terraform configuration content")
  configuration?: string;

  @doc("The Terraform import blocks for the current export, which users can use to run \"terraform plan\" with to import the resources")
  `import`?: string;

  @doc("A list of Azure resources which are not exported to Terraform due to there is no corresponding resources in Terraform")
  skippedResources?: armResourceIdentifier[];

  @doc("A list of errors derived during exporting each resource")
  @identifiers(#[])
  errors?: ErrorDetail[];
}
