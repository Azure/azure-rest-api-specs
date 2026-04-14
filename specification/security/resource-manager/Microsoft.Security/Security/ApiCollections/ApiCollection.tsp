import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace ApiCollectionsAPI;

@minLength(1)
@maxLength(50)
scalar ApiManagementServiceName extends string;

alias serviceExternalResource = Azure.ResourceManager.Extension.ExternalResource<
  "Microsoft.ApiManagement",
  "service",
  "serviceName",
  "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$",
  ApiManagementServiceName,
  "The name of the API Management service."
>;

/**
 * An API collection as represented by Microsoft Defender for APIs.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model ApiCollection
  is Azure.ResourceManager.ExtensionResource<ApiCollectionProperties> {
  ...ResourceNameParameter<
    Resource = ApiCollection,
    KeyName = "apiId",
    SegmentName = "apiCollections",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ApiCollections {
  /**
   * Gets an Azure API Management API if it has been onboarded to Microsoft Defender for APIs. If an Azure API Management API is onboarded to Microsoft Defender for APIs, the system will monitor the operations within the Azure API Management API for intrusive behaviors and provide alerts for attacks that have been detected.
   */
  @summary("Gets an onboarded Azure API Management API")
  @tag("D4APICollection")
  @tag("APIMConfig")
  getByAzureApiManagementService is Azure.ResourceManager.Extension.Read<
    serviceExternalResource,
    ApiCollection
  >;

  /**
   * Onboard an Azure API Management API to Microsoft Defender for APIs. The system will start monitoring the operations within the Azure Management API for intrusive behaviors and provide alerts for attacks that have been detected.
   */
  @summary("Onboard an Azure API Management API to Microsoft Defender for APIs")
  @tag("OnboardToD4API")
  @tag("APIMConfig")
  onboardAzureApiManagementApi is Azure.ResourceManager.Legacy.Extension.CreateOrUpdateAsync<
    serviceExternalResource,
    ApiCollection,
    Request = void,
    OptionalRequestBody = true,
    LroHeaders = ArmLroLocationHeader<FinalResult = ApiCollection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Offboard an Azure API Management API from Microsoft Defender for APIs. The system will stop monitoring the operations within the Azure API Management API for intrusive behaviors.
   */
  @summary("Offboard an Azure API Management API from Microsoft Defender for APIs")
  @tag("OffboardFromD4API")
  @tag("APIMConfig")
  offboardAzureApiManagementApi is Azure.ResourceManager.Extension.DeleteSync<
    serviceExternalResource,
    ApiCollection
  >;

  /**
   * Gets a list of Azure API Management APIs that have been onboarded to Microsoft Defender for APIs. If an Azure API Management API is onboarded to Microsoft Defender for APIs, the system will monitor the operations within the Azure API Management API for intrusive behaviors and provide alerts for attacks that have been detected.
   */
  @summary("Gets a list of onboarded Azure API Management APIs")
  @tag("D4APICollectionList")
  @tag("APIMConfig")
  listByAzureApiManagementService is Azure.ResourceManager.Extension.ListByTarget<
    serviceExternalResource,
    ApiCollection,
    Response = ArmResponse<ApiCollectionList>
  >;

  /**
   * Gets a list of API collections within a subscription that have been onboarded to Microsoft Defender for APIs.
   */
  @summary("Gets a list of API collections within a subscription")
  @tag("D4APICollectionList")
  listBySubscription is ArmListBySubscription<
    ApiCollection,
    Response = ArmResponse<ApiCollectionList>
  >;
}

@@maxLength(ApiCollection.name, 256);
@@minLength(ApiCollection.name, 1);
@@doc(ApiCollection.name,
  "API revision identifier. Must be unique in the API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number."
);
@@doc(ApiCollection.properties,
  "Describes the properties of an API collection."
);
