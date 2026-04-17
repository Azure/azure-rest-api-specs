import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HanaOnAzure;
/**
 * SAP monitor info on Azure (ARM properties and SAP monitor properties)
 */
model SapMonitor
  is Azure.ResourceManager.TrackedResource<SapMonitorProperties> {
  ...ResourceNameParameter<
    Resource = SapMonitor,
    KeyName = "sapMonitorName",
    SegmentName = "sapMonitors",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface SapMonitors {
  /**
   * The product Microsoft.Workloads/sapMonitors (AMS Classic) is officially retired as of May 31, 2023.
   */
  #deprecated "deprecated on origin swagger"
  @tag("HanaOnAzure")
  @summary("Gets properties of a SAP monitor.")
  get is ArmResourceRead<SapMonitor, Error = ErrorResponse>;

  /**
   * The product Microsoft.Workloads/sapMonitors (AMS Classic) is officially retired as of May 31, 2023.
   */
  #deprecated "deprecated on origin swagger"
  @tag("HanaOnAzure")
  @summary("Creates a SAP monitor.")
  create is ArmResourceCreateOrReplaceAsync<
    SapMonitor,
    LroHeaders = ArmLroLocationHeader<FinalResult = SapMonitor> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;

  /**
   * The product Microsoft.Workloads/sapMonitors (AMS Classic) is officially retired as of May 31, 2023.
   */
  #deprecated "deprecated on origin swagger"
  @tag("HanaOnAzure")
  @summary("Patches the Tags field of a SAP monitor.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    SapMonitor,
    PatchModel = Tags,
    Error = ErrorResponse
  >;

  /**
   * The product Microsoft.Workloads/sapMonitors (AMS Classic) is officially retired as of May 31, 2023.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #deprecated "deprecated on origin swagger"
  @tag("HanaOnAzure")
  @summary("Deletes a SAP monitor.")
  delete is ArmResourceDeleteWithoutOkAsync<
    SapMonitor,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * The product Microsoft.Workloads/sapMonitors (AMS Classic) is officially retired as of May 31, 2023.
   */
  #deprecated "deprecated on origin swagger"
  @tag("HanaOnAzure")
  @summary("Gets a list of SAP monitors in the specified subscription.")
  list is ArmListBySubscription<SapMonitor, Error = ErrorResponse>;
}

@@doc(SapMonitor.name, "Name of the SAP monitor resource.");
@@doc(SapMonitor.properties, "SAP monitor properties");
@@doc(SapMonitors.create::parameters.resource,
  "Request body representing a SAP Monitor"
);
@@doc(SapMonitors.update::parameters.properties,
  "Request body that only contains the new Tags field"
);
