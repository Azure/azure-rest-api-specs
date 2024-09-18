import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using OpenAPI;

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
}

@doc("Export parameter for individual resources.")
model ExportResource extends BaseExportModel {
  @doc("The id of the resource to be exported")
  resourceIds: string[];

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
model OperationStatus {
  @doc("The operation status resource id.")
  id?: string;

  @doc("The fully qualified resource id of the resource for which the operation was performed.")
  @visibility("read")
  resourceId?: string;

  @doc("The operation name.")
  name?: string;

  @doc("The start time of the operation.")
  @visibility("read")
  startTime?: utcDateTime;

  @doc("The end time of the operation.")
  @visibility("read")
  endTime?: utcDateTime;

  @doc("The status of the operation.")
  status?: string;

  @doc("The progress percentage of the operation, ranges from 0 to 100")
  percentComplete?: float64;

  @doc("The Terraform export result")
  properties?: ExportResult;

  ...ErrorResponse;
}

model InProgressOperationStatus
  is ArmAcceptedResponse<
    "InProgress operation status",
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  > {
  ...OperationStatus;
}

@doc("The Terraform export result")
model ExportResult {
  @doc("The Terraform configuration content")
  configuration?: string;

  @doc("A list of Azure resources which are not exported to Terraform due to there is no corresponding resources in Terraform")
  skippedResources?: string[];

  @doc("A list of errors derived during exporting each resource")
  @extension("x-ms-identifiers", [])
  errors?: ErrorDetail[];
}
