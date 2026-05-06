import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SapMonitor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HanaOnAzure;
/**
 * A provider instance associated with a SAP monitor.
 */
@parentResource(SapMonitor)
model ProviderInstance
  is Azure.ResourceManager.ProxyResource<ProviderInstanceProperties> {
  ...ResourceNameParameter<
    Resource = ProviderInstance,
    KeyName = "providerInstanceName",
    SegmentName = "providerInstances",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ProviderInstances {
  /**
   * The product Microsoft.Workloads/sapMonitors (AMS Classic) is officially retired as of May 31, 2023.
   */
  #deprecated "deprecated on origin swagger"
  @tag("HanaOnAzure")
  @summary("Gets properties of a provider instance.")
  get is ArmResourceRead<ProviderInstance, Error = ErrorResponse>;

  /**
   * The product Microsoft.Workloads/sapMonitors (AMS Classic) is officially retired as of May 31, 2023.
   */
  #deprecated "deprecated on origin swagger"
  @tag("HanaOnAzure")
  @summary("Creates a provider instance.")
  create is ArmResourceCreateOrReplaceAsync<
    ProviderInstance,
    LroHeaders = ArmLroLocationHeader<FinalResult = ProviderInstance> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;

  /**
   * The product Microsoft.Workloads/sapMonitors (AMS Classic) is officially retired as of May 31, 2023.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #deprecated "deprecated on origin swagger"
  @tag("HanaOnAzure")
  @summary("Deletes a provider instance.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ProviderInstance,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * The product Microsoft.Workloads/sapMonitors (AMS Classic) is officially retired as of May 31, 2023.
   */
  #deprecated "deprecated on origin swagger"
  @tag("HanaOnAzure")
  @summary("Gets a list of provider instances in the specified SAP monitor.")
  list is ArmResourceListByParent<ProviderInstance, Error = ErrorResponse>;
}

@@doc(ProviderInstance.name, "Name of the provider instance.");
@@doc(ProviderInstance.properties, "Provider Instance properties");
@@doc(ProviderInstances.create::parameters.resource,
  "Request body representing a provider instance"
);
