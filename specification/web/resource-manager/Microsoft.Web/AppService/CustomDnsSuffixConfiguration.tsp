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

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface CustomDnsSuffixConfigurations {
  /**
   * Get Custom Dns Suffix configuration of an App Service Environment
   */
  @summary("Get Custom Dns Suffix configuration of an App Service Environment")
  getAseCustomDnsSuffixConfiguration is ArmResourceRead<
    CustomDnsSuffixConfiguration,
    Error = DefaultErrorResponse
  >;

  /**
   * Update Custom Dns Suffix configuration of an App Service Environment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Update Custom Dns Suffix configuration of an App Service Environment")
  updateAseCustomDnsSuffixConfiguration is ArmResourceCreateOrReplaceSync<
    CustomDnsSuffixConfiguration,
    Response = ArmResourceUpdatedResponse<CustomDnsSuffixConfiguration>,
    Error = DefaultErrorResponse
  >;

  /**
   * Delete Custom Dns Suffix configuration of an App Service Environment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete Custom Dns Suffix configuration of an App Service Environment")
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
