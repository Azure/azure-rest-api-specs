import "../../Common/StandardizedContracts/CommonEnums.tsp";
import "../../Common/StandardizedContracts/Scope.tsp";
import "../../Common/StandardizedContracts/CommonModels.tsp";
import "../../Common/StandardizedContracts/AssessmentProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;
namespace Microsoft.Migrate;
@doc("WebApp assessment resource.")
@parentResource(AssessmentProject)
model WebAppAssessmentV3 is ProxyResource<WebAppAssessmentV3Properties> {
  @doc("WebApp Assessment ARM name")
  @key("assessmentName")
  @segment("webAppAssessments")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

@doc("WebApp assessment resource properties.")
model WebAppAssessmentV3Properties
  is AssessmentProperties<Scope, WebAppAssessmentSettings, AssessmentDetails> {
  @doc("Gets or sets the machine assessment ARM ID for VM fallback.")
  fallbackMachineAssessmentArmId?: string;
}

@doc("Web app assessment settings class.")
model WebAppAssessmentSettings is AssessmentSettings {
  @doc("App Service native settings.")
  appSvcNativeSettings: AppSvcNativeSettings;

  @doc("App Service container settings.")
  appSvcContainerSettings: AppSvcContainerSettings;

  @doc("Azure security offering type.")
  azureSecurityOfferingType: AzureSecurityOfferingType;
}
