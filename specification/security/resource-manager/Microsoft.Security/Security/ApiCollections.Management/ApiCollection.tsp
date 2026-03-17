import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * An API collection as represented by Microsoft Defender for APIs.
 */
model ApiCollection
  is Azure.ResourceManager.ProxyResource<ApiCollectionProperties> {
  ...ResourceNameParameter<
    Resource = ApiCollection,
    KeyName = "apiId",
    SegmentName = "apiCollections",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

alias serviceExternalResource = Extension.ExternalResource<
  "Microsoft.ApiManagement",
  "service",
  "{serviceName}"
>;

@armResourceOperations
interface ApiCollections {
  /**
   * Gets an Azure API Management API if it has been onboarded to Microsoft Defender for APIs. If an Azure API Management API is onboarded to Microsoft Defender for APIs, the system will monitor the operations within the Azure API Management API for intrusive behaviors and provide alerts for attacks that have been detected.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("APICollections_GetByAzureApiManagementService")
  getByAzureApiManagementService is ArmResourceRead<ApiCollection>;

  /**
   * Onboard an Azure API Management API to Microsoft Defender for APIs. The system will start monitoring the operations within the Azure Management API for intrusive behaviors and provide alerts for attacks that have been detected.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("APICollections_OnboardAzureApiManagementApi")
  onboardAzureApiManagementApi is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    ApiCollection,
    Request = void,
    LroHeaders = ArmLroLocationHeader<FinalResult = ApiCollection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Offboard an Azure API Management API from Microsoft Defender for APIs. The system will stop monitoring the operations within the Azure API Management API for intrusive behaviors.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("APICollections_OffboardAzureApiManagementApi")
  offboardAzureApiManagementApi is ArmResourceDeleteSync<ApiCollection>;

  /**
   * Gets a list of Azure API Management APIs that have been onboarded to Microsoft Defender for APIs. If an Azure API Management API is onboarded to Microsoft Defender for APIs, the system will monitor the operations within the Azure API Management API for intrusive behaviors and provide alerts for attacks that have been detected.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("APICollections_ListByAzureApiManagementService")
  listByAzureApiManagementService is ArmResourceListByParent<
    ApiCollection,
    Response = ArmResponse<ApiCollectionList>
  >;

  /**
   * Gets a list of API collections within a subscription that have been onboarded to Microsoft Defender for APIs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("APICollections_ListBySubscription")
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
