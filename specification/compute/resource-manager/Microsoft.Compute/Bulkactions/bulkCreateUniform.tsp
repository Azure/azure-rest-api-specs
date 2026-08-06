import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./models.tsp";
import "./bulkCreateCustom.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Compute;

alias BulkCreateUniformOperationStatusId = {
  /** The identifier of the BulkCreateUniform operation. */
  @path
  @minLength(1)
  @segment("bulkCreateUniform")
  @key
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  bulkOperationId: string;
};

@added(Versions.`2026-08-06-preview`)
@armResourceOperations
interface BulkCreateUniform {
  @doc("Gets the operation status for virtual machines in a BulkCreateUniform operation.")
  virtualMachinesGetOperationStatus is ArmResourceActionSync<
    Resource = LocationBasedBulkCreateCustom,
    Request = void,
    Response = ArmResponse<GetOperationStatusResponse>,
    Parameters = BulkCreateUniformOperationStatusId
  >;
}
