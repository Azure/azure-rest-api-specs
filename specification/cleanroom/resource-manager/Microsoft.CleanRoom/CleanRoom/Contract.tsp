import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Collaboration.tsp";
import "./ConsortiumView.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.CleanRoom;
/**
 * Defines the contract.
 */
@parentResource(Collaboration)
@removed(Versions.v2025_10_31_preview)
model Contract
  is Azure.ResourceManager.ProxyResource<ContractProperties, false> {
  ...ResourceNameParameter<
    Resource = Contract,
    KeyName = "contractName",
    SegmentName = "contracts",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^[-\\w\\._,\\(\\)]+$")
  kind?: string;
}

@armResourceOperations
@removed(Versions.v2025_10_31_preview)
interface Contracts {
  /**
   * Get a contract.
   */
  get is ArmResourceRead<Contract>;

  /**
   * List contracts in a collaboration.
   */
  listByCollaboration is ArmResourceListByParent<
    Contract,
    Response = ArmResponse<ContractsList>
  >;

  /**
   * Generates and proposes contract template.
   */
  proposeTemplate is ArmResourceActionAsync<
    Contract,
    void,
    ArmResponse<Contract>,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(Contract.name, "Name of the contract.");
@@doc(Contract.properties, "Resource properties.");
