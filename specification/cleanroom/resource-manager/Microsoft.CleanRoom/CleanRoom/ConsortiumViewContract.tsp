import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
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
@parentResource(ConsortiumView)
@added(Versions.v2025_10_31_preview)
model ConsortiumViewContract
  is Azure.ResourceManager.ProxyResource<ContractProperties, false> {
  ...ResourceNameParameter<
    Resource = ConsortiumViewContract,
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
@added(Versions.v2025_10_31_preview)
interface ConsortiumViewContracts {
  /**
   * Get a contract.
   */
  get is ArmResourceRead<ConsortiumViewContract>;

  /**
   * List contracts in a consortium view.
   */
  listByConsortiumView is ArmResourceListByParent<
    ConsortiumViewContract,
    Response = ArmResponse<ConsortiumViewContractsList>
  >;

  /**
   * Generates and proposes contract template.
   */
  proposeTemplate is ArmResourceActionAsync<
    ConsortiumViewContract,
    void,
    ArmResponse<ConsortiumViewContract>,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(ConsortiumViewContract.name, "Name of the contract.");
@@doc(ConsortiumViewContract.properties, "Resource properties.");
