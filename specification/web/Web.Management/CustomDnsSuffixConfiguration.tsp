import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceEnvironmentResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Full view of the custom domain suffix configuration for ASEv3.
 */
@singleton("customdnssuffix")
@parentResource(AppServiceEnvironmentResource)
model CustomDnsSuffixConfiguration
  is Azure.ResourceManager.ProxyResource<CustomDnsSuffixConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = CustomDnsSuffixConfiguration,
    KeyName = "configuration",
    SegmentName = "configurations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CustomDnsSuffixConfigurations {
  /**
   * Get Custom Dns Suffix configuration of an App Service Environment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServiceEnvironments_GetAseCustomDnsSuffixConfiguration")
  getAseCustomDnsSuffixConfiguration is ArmResourceRead<
    CustomDnsSuffixConfiguration,
    Error = DefaultErrorResponse
  >;

  /**
   * Update Custom Dns Suffix configuration of an App Service Environment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("AppServiceEnvironments_UpdateAseCustomDnsSuffixConfiguration")
  updateAseCustomDnsSuffixConfiguration is ArmResourceCreateOrReplaceSync<
    CustomDnsSuffixConfiguration,
    Response = ArmResourceUpdatedResponse<CustomDnsSuffixConfiguration>,
    Error = DefaultErrorResponse
  >;

  /**
   * Delete Custom Dns Suffix configuration of an App Service Environment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" ""
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("AppServiceEnvironments_DeleteAseCustomDnsSuffixConfiguration")
  deleteAseCustomDnsSuffixConfiguration is ArmResourceDeleteSync<
    CustomDnsSuffixConfiguration,
    Response = ArmResponse<unknown> | (ArmDeletedNoContentResponse & {
      @body _: unknown;
    }),
    Error = DefaultErrorResponse
  >;
}

@@doc(CustomDnsSuffixConfiguration.name, "");
@@doc(CustomDnsSuffixConfiguration.properties,
  "CustomDnsSuffixConfiguration resource specific properties"
);
@@doc(CustomDnsSuffixConfigurations.updateAseCustomDnsSuffixConfiguration::parameters.resource,
  ""
);
