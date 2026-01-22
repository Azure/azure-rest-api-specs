import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HDInsight;
/**
 * The HDInsight cluster application
 */
@parentResource(Cluster)
model Application
  is Azure.ResourceManager.ProxyResource<ApplicationProperties> {
  ...ResourceNameParameter<
    Resource = Application,
    KeyName = "applicationName",
    SegmentName = "applications",
    NamePattern = ""
  >;

  /**
   * The ETag for the application
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  /**
   * The tags for the application.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@armResourceOperations
interface Applications {
  /**
   * Gets properties of the specified application.
   */
  get is ArmResourceRead<Application, Error = ErrorResponse>;

  /**
   * Creates applications for the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceAsync<
    Application,
    Response = ArmResourceUpdatedResponse<Application> & {
      ...ArmLroLocationHeader<FinalResult = Application>;
      ...Azure.Core.Foundations.RetryAfterHeader;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = Application> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;

  /**
   * Deletes the specified application on the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Application,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * Lists all of the applications for the HDInsight cluster.
   */
  listByCluster is ArmResourceListByParent<Application, Error = ErrorResponse>;

  /**
   * Gets the async operation status.
   */
  getAzureAsyncOperationStatus is ArmResourceRead<
    Application,
    Response = ArmResponse<AsyncOperationResult>,
    Parameters = {
      /**
       * The long running operation id.
       */
      @path
      @segment("azureasyncoperations")
      @key
      operationId: string;
    },
    Error = ErrorResponse
  >;
}

@@doc(Application.name, "The constant value for the application name.");
@@doc(Application.properties, "The properties of the application.");
@@doc(Applications.create::parameters.resource,
  "The application create request."
);
