import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Continuous Web Job Information.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Site)
@Azure.ResourceManager.Private.armResourceInternal(ContinuousWebJobProperties)
@includeInapplicableMetadataInPayload(false)
model ContinuousWebJob extends ProxyOnlyResource {
  /**
   * Name of Web Job.
   */
  @path
  @key("webJobName")
  @segment("continuouswebjobs")
  name: string;

  /**
   * ContinuousWebJob resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ContinuousWebJobProperties;
}

@armResourceOperations
interface ContinuousWebJobs {
  /**
   * Description for Gets a continuous web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetContinuousWebJob")
  getContinuousWebJob is ArmResourceRead<ContinuousWebJob>;

  /**
   * Description for Delete a continuous web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_DeleteContinuousWebJob")
  deleteContinuousWebJob is ArmResourceDeleteSync<ContinuousWebJob>;

  /**
   * Description for List continuous web jobs for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListContinuousWebJobs")
  listContinuousWebJobs is ArmResourceListByParent<ContinuousWebJob>;

  /**
   * Description for Start a continuous web job for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_StartContinuousWebJob")
  startContinuousWebJob is ArmResourceActionSync<ContinuousWebJob, void, void>;

  /**
   * Description for Stop a continuous web job for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_StopContinuousWebJob")
  stopContinuousWebJob is ArmResourceActionSync<ContinuousWebJob, void, void>;
}
