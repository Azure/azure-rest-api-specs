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

namespace Microsoft.Web;
/**
 * Public certificate object
 */
@parentResource(Site)
model PublicCertificate
  is Azure.ResourceManager.ProxyResource<PublicCertificateProperties> {
  ...ResourceNameParameter<
    Resource = PublicCertificate,
    KeyName = "publicCertificateName",
    SegmentName = "publicCertificates",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PublicCertificateOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** Public certificate name. */
        @path
        @segment("publicCertificates")
        @key
        publicCertificateName: string,
      }
    > {}

@armResourceOperations
interface PublicCertificates {
  /**
   * Description for Get the named public certificate for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetPublicCertificate")
  getPublicCertificate is PublicCertificateOps.Read<
    PublicCertificate, 
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a hostname binding for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdatePublicCertificate")
  createOrUpdatePublicCertificate is PublicCertificateOps.CreateOrUpdateSync<
    PublicCertificate,
    Response = ArmResourceUpdatedResponse<PublicCertificate>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a hostname binding for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeletePublicCertificate")
  deletePublicCertificate is PublicCertificateOps.DeleteSync<
    PublicCertificate, 
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get public certificates for an app or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListPublicCertificates")
  listPublicCertificates is PublicCertificateOps.List<
    PublicCertificate,
    Response = ArmResponse<PublicCertificateCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface PublicCertificateOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API the named binding for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Public certificate name. */
        @path
        @segment("publicCertificates")
        @key
        publicCertificateName: string,
      }
    > {}

@armResourceOperations
interface PublicCertificateOperationGroup {
  /**
   * Description for Get the named public certificate for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetPublicCertificateSlot")
  getPublicCertificateSlot is PublicCertificateOperationGroupOps.Read<
    PublicCertificate,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a hostname binding for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdatePublicCertificateSlot")
  createOrUpdatePublicCertificateSlot is PublicCertificateOperationGroupOps.CreateOrUpdateSync<
    PublicCertificate,
    Response = ArmResourceUpdatedResponse<PublicCertificate>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a hostname binding for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeletePublicCertificateSlot")
  deletePublicCertificateSlot is PublicCertificateOperationGroupOps.DeleteSync<
    PublicCertificate,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get public certificates for an app or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListPublicCertificatesSlot")
  listPublicCertificatesSlot is PublicCertificateOperationGroupOps.List<
    PublicCertificate,
    Response = ArmResponse<PublicCertificateCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(PublicCertificate.name, "Public certificate name.");
@@doc(PublicCertificate.properties,
  "PublicCertificate resource specific properties"
);
@@doc(PublicCertificates.createOrUpdatePublicCertificate::parameters.resource,
  "Public certificate details. This is the JSON representation of a PublicCertificate object."
);
@@doc(PublicCertificateOperationGroup.createOrUpdatePublicCertificateSlot::parameters.resource,
  "Public certificate details. This is the JSON representation of a PublicCertificate object."
);
