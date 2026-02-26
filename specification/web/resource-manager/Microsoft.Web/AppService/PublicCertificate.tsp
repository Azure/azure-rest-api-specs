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

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
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
  @summary("Get the named public certificate for an app (or deployment slot, if specified).")
  getPublicCertificate is PublicCertificateOps.Read<
    PublicCertificate,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a hostname binding for an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a hostname binding for an app.")
  createOrUpdatePublicCertificate is PublicCertificateOps.CreateOrUpdateSync<
    PublicCertificate,
    Response = ArmResourceUpdatedResponse<PublicCertificate>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a hostname binding for an app.
   */
  @summary("Deletes a hostname binding for an app.")
  deletePublicCertificate is PublicCertificateOps.DeleteSync<
    PublicCertificate,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get public certificates for an app or a deployment slot.
   */
  @summary("Get public certificates for an app or a deployment slot.")
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
  @summary("Get the named public certificate for an app (or deployment slot, if specified).")
  getPublicCertificateSlot is PublicCertificateOperationGroupOps.Read<
    PublicCertificate,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a hostname binding for an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a hostname binding for an app.")
  createOrUpdatePublicCertificateSlot is PublicCertificateOperationGroupOps.CreateOrUpdateSync<
    PublicCertificate,
    Response = ArmResourceUpdatedResponse<PublicCertificate>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a hostname binding for an app.
   */
  @summary("Deletes a hostname binding for an app.")
  deletePublicCertificateSlot is PublicCertificateOperationGroupOps.DeleteSync<
    PublicCertificate,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get public certificates for an app or a deployment slot.
   */
  @summary("Get public certificates for an app or a deployment slot.")
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
