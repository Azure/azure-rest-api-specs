import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Site.tsp";
import "./FunctionAppVersion.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

@added(Versions.v2026_10_01_preview)
@doc("The properties of a Function App label.")
model FunctionAppLabelProperties {
  /** The name of the retained Function App version to assign, within this Function App. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  targetVersionName: string;

  /** The committed name of the Function App version currently assigned to this label. */
  @visibility(Lifecycle.Read)
  activeVersionName?: string;

  /** The status of the resource provisioning operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@added(Versions.v2026_10_01_preview)
@parentResource(Site)
@doc("A Function App label. The preview supports only the platform-reserved production Function App label.")
model FunctionAppLabel
  is Azure.ResourceManager.ProxyResource<FunctionAppLabelProperties> {
  ...ResourceNameParameter<
    Resource = FunctionAppLabel,
    KeyName = "labelName",
    SegmentName = "functionAppLabels",
    NamePattern = "^production$"
  >;
}

@added(Versions.v2026_10_01_preview)
@tag("FunctionAppLabels")
@armResourceOperations
@doc("Operations for Function App labels.")
interface FunctionAppLabels {
  /** Gets a Function App label. The preview supports only the production label. */
  get is ArmResourceRead<FunctionAppLabel>;

  /**
   * Assigns a retained Function App version to production, including rollback.
   * Completion means the serving pointer and invalidation generation are durable,
   * not that all previous workers have drained. Assigning the same target is a no-op.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The label-assignment contract returns 202 with an empty body and a site-scoped status monitor, followed by GET of the final resource."
  @Azure.Core.pollingOperation(FunctionAppOperationResults.get)
  @Azure.Core.finalOperation(FunctionAppLabels.get)
  @Azure.Core.useFinalStateVia("location")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FunctionAppLabel,
    Response =
      | ArmResponse<FunctionAppLabel>
      | ArmAcceptedLroResponse<
          "Production assignment accepted.",
          ArmCombinedLroHeaders<
            FunctionAppOperationResult,
            FunctionAppLabel,
            string
          > &
            Azure.Core.Foundations.RetryAfterHeader
        >
  >;

  /**
   * Restores equivalent legacy serving state before deleting the production label
   * and re-enabling direct publishing. Retained versions are not deleted.
   */
  @Azure.Core.pollingOperation(FunctionAppOperationResults.get)
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    FunctionAppLabel,
    LroHeaders = ArmCombinedLroHeaders<
      FunctionAppOperationResult,
      void,
      string
    > &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}
