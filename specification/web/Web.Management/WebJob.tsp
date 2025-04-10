import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Web Job Information.
 */
@parentResource(Site)
model WebJob is Azure.ResourceManager.ProxyResource<WebJobProperties> {
  ...ResourceNameParameter<
    Resource = WebJob,
    KeyName = "webJobName",
    SegmentName = "webjobs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WebJobOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "slot",
          SegmentName = "slots",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = WebJob,
        KeyName = "webJobName",
        SegmentName = "webjobs",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface WebJobs {
  /**
   * Description for Get webjob information for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetWebJobSlot")
  getWebJobSlot is WebJobOps.Read<WebJob>;

  /**
   * Description for List webjobs for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListWebJobsSlot")
  listWebJobsSlot is WebJobOps.List<
    WebJob,
    Response = ArmResponse<WebJobCollection>
  >;
}
@armResourceOperations
interface WebJobOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = WebJob,
        KeyName = "webJobName",
        SegmentName = "webjobs",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface WebJobOperationGroup {
  /**
   * Description for Get webjob information for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetWebJob")
  getWebJob is WebJobOperationGroupOps.Read<WebJob>;

  /**
   * Description for List webjobs for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListWebJobs")
  listWebJobs is WebJobOperationGroupOps.List<
    WebJob,
    Response = ArmResponse<WebJobCollection>
  >;
}

@@doc(WebJob.name, "Name of the web job.");
@@doc(WebJob.properties, "WebJob resource specific properties");
