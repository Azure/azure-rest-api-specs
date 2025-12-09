import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedGrafana.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Dashboard;
/**
 * The integration fabric resource type.
 */
@parentResource(ManagedGrafana)
model IntegrationFabric
  is Azure.ResourceManager.TrackedResource<IntegrationFabricProperties> {
  ...ResourceNameParameter<
    Resource = IntegrationFabric,
    KeyName = "integrationFabricName",
    SegmentName = "integrationFabrics",
    NamePattern = "^[a-zA-Z][a-z0-9A-Z-]{0,18}[a-z0-9A-Z]$"
  >;
}

@armResourceOperations
interface IntegrationFabrics {
  get is ArmResourceRead<IntegrationFabric>;

  create is ArmResourceCreateOrReplaceAsync<IntegrationFabric>;

  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    IntegrationFabric,
    PatchModel = IntegrationFabricUpdateParameters,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = IntegrationFabric> &
      Azure.Core.Foundations.RetryAfterHeader &
      LocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    IntegrationFabric,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = IntegrationFabric> &
      Azure.Core.Foundations.RetryAfterHeader &
      LocationHeader
  >;

  list is ArmResourceListByParent<
    IntegrationFabric,
    Response = ArmResponse<IntegrationFabricListResponse>
  >;
}

@@doc(IntegrationFabric.name,
  "The integration fabric name of Azure Managed Grafana."
);
@@doc(IntegrationFabric.properties, "");
@@doc(IntegrationFabrics.create::parameters.resource, "");
@@doc(IntegrationFabrics.update::parameters.properties, "");
