import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Rest;
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

  @doc("Whether to output all non-computed properties in the generated Terraform configuration. If set to `false` empty-valued properties will be omitted from the configuration. Defaults to `true`.")
  fullProperties?: boolean = true;

  @doc("Mask sensitive attributes in the Terraform configuration. Defaults to `true`.")
  maskSensitive?: boolean = true;

  @added(Versions.v2025_09_01_preview)
  @doc("Whether to include RBAC role assignments assigned to the resources exported. Only resource-scoped role assignments are supported. Defaults to `false`.")
  includeRoleAssignment?: boolean = false;

  @added(Versions.v2025_09_01_preview)
  @doc("Whether to include internal resources managed by Azure in the exported configuration. Defaults to `false`.")
  includeManagedResource?: boolean = false;

  @added(Versions.v2025_06_01_preview)
  @doc("Excludes specified Azure Resource Ids. Case-insensitive Azure Resource ID regular expression. Example: `[\"/subscriptions/[0-9a-f-]+/resourceGroups/my-rg.*\"]`.")
  excludeAzureResource?: string[];

  @added(Versions.v2025_06_01_preview)
  @doc("Excludes specified Terraform resource types. Example: `[\"azurerm_virtual_network\"]`.")
  excludeTerraformResource?: string[];
}

@doc("Uses ARG (Azure Resource Graph) query to choose resources to be exported.")
model ExportQuery extends BaseExportModel {
  @doc("The ARG where predicate. Multiple predicates can be combined using `and` operator. Example: `resourceGroup =~ \"my-rg\" and type =~ \"microsoft.network/virtualnetworks\"`. The default ARG table is `Resources`, use 'table' property to query a different table.")
  query: string;

  @doc("The id prefix for the exported Terraform resources. Defaults to `res-`.")
  namePattern?: string = "res-";

  @doc("Recursively includes child resources. Defaults to `false`.")
  recursive?: boolean = false;

  @doc("Has to be `ExportQuery` to distinguish from other types.")
  type: Type.ExportQuery;

  @added(Versions.v2025_09_01_preview)
  @doc("Includes the resource group in the exported Terraform resources. Defaults to `false`.")
  includeResourceGroup?: boolean = false;

  @doc("The ARG table name. Defaults to 'Resources'.")
  table?: string = "Resources";

  @doc("The ARG Scope Filter parameter.")
  authorizationScopeFilter?: authorizationScopeFilter;
}

@doc("Specified resources to be exported by their ids.")
model ExportResource extends BaseExportModel {
  @doc("The id(s) of the resource to be exported. Example: `[\"/subscriptions/12345678-1234-1234-1234-1234567890ab/resourceGroups/my-rg\"].")
  resourceIds: armResourceIdentifier[];

  @doc("The Terraform id of the exported resource. Only effective when `resourceIds` contains only one item. Defaults to `res-0`.")
  resourceName?: string = "res-0";

  @doc("The Terraform resource type to map to. Only effective when `resourceIds` has one item. Example: `azurerm_virtual_network`. Automatic type mapping will be performed if not provided.")
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

// Not using .. is ArmOperationStatus<ExportResult> due to https://github.com/Azure/autorest.go/issues/1680
@doc("The status of the LRO (Long Running Operation) and the export result.")
model TerraformOperationStatus {
  @doc("RP-specific properties for the operationStatus resource, only appears when operation ended with Succeeded status")
  @visibility(Lifecycle.Read)
  properties?: ExportResult;

  @doc("The operation status")
  @Azure.Core.lroStatus
  status: ResourceProvisioningState;

  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "Not adding @visibility decorator so we can use ArmOperationStatus again once https://github.com/Azure/autorest.go/issues/1680 is fixed"
  @doc("The unique identifier for the operationStatus resource")
  @key
  @segment("operationStatuses")
  id: string;

  @doc("The name of the  operationStatus resource")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Operation start time")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("Operation complete time")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  @doc("The progress made toward completing the operation")
  @visibility(Lifecycle.Read)
  percentComplete?: float64;

  @doc("Errors that occurred if the operation ended with Canceled or Failed status")
  @visibility(Lifecycle.Read)
  error?: ErrorDetail;
}

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
