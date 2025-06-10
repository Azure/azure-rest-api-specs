import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./hub.tsp";
import "./connectors/storageAccountConnector.tsp";
import "./connectors/oneLakeConnector.tsp";
import "./connectors/hl7Connector.tsp";
import "./connectors/dicomConnector.tsp";
import "./channels/dicomDirectChannel.tsp";
import "./channels/fhirQueryEventBatchChannel.tsp";
import "./channels/fhirQueryFlatFileBatchChannel.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@doc("Microsoft HealthcareInterop Cloud resources management API.")
@armProviderNamespace("Microsoft.HealthcareInterop")
@service(#{ title: "Microsoft HealthcareInterop Cloud service" })
@versioned(Versions)
namespace Microsoft.HealthcareInterop;

@doc("HealthcareInterop Cloud service API versions")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("The 2025-05-01-preview version.")
  v2025_05_01_preview: "2025-05-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("The 2025-06-01-preview version.")
  v2025_06_01_preview: "2025-06-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface OperationStatus {
  @doc("Returns the current status of an async operation.")
  @autoRoute
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @path
    @segment("providers")
    @doc("The provider namespace.")
    provider: "Microsoft.HealthcareInterop",

    ...LocationParameter,
    ...Azure.ResourceManager.Foundations.OperationIdParameter,
  ): ArmResponse<OperationStatusResult> | ErrorResponse;
}

@@segment(OperationStatus.get::parameters.operationId, "operationStatuses");
