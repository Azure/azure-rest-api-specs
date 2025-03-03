import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using OpenAPI;

namespace Microsoft.ScVmm;
/** The VmmServers resource definition. */
model VmmServer is TrackedResource<VmmServerProperties> {
  /** Name of the VmmServer. */
  @maxLength(54)
  @minLength(1)
  @pattern("[a-zA-Z0-9-_\\.]")
  @path
  @key("vmmServerName")
  @segment("vmmServers")
  name: string;

  /** The extended location. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This property is allowed but not recognized by the linter"
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface VmmServers {
  /** Implements VmmServer GET method. */
  @summary("Gets a VMMServer.")
  get is ArmResourceRead<VmmServer>;
  /** Onboards the SCVmm fabric as an Azure VmmServer resource. */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @summary("Implements VmmServers PUT method.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    VmmServer,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  /** Updates the VmmServers resource. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
  @summary("Implements VmmServers PATCH method.")
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  update is ArmTagsPatchAsync<VmmServer>;
  /** Removes the SCVmm fabric from Azure. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
  @summary("Implements VmmServers DELETE method.")
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  delete is ArmResourceDeleteWithoutOkAsync<
    VmmServer,
    {
      ...Foundations.BaseParameters<VmmServer>;
      ...QueryForceDelete;
    }
  >;
  /** List of VmmServers in a resource group. */
  @summary("Implements GET VmmServers in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VmmServer>;
  /** List of VmmServers in a subscription. */
  @summary("Implements GET VmmServers in a subscription.")
  listBySubscription is ArmListBySubscription<VmmServer>;
}
