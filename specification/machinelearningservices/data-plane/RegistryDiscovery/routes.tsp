import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices.RegistryDiscovery;

interface AsyncOperations {
  /** Get the status of an async operation. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/registrymanagement/v1.0/operations/{operationId}")
  @get
  getStatus is Azure.Core.Foundations.Operation<
    {
      /** The operation ID. */
      @path operationId: string;
    },
    void
  >;
}

interface RegistryManagementNonWorkspace {
  /** Get registry discovery information. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing non-standard API."
  @route("/registrymanagement/v1.0/registries/{registryName}/discovery")
  @get
  getRegistryManagementNonWorkspace is Azure.Core.Foundations.Operation<
    {
      /** The registry name. */
      @path registryName: string;
    },
    RegistryDiscoveryDto
  >;
}
