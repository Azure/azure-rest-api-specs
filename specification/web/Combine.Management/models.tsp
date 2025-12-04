import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Web;

/**
 * Certificate product type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CertificateProductType {
  StandardDomainValidatedSsl,
  StandardDomainValidatedWildCardSsl,
}


/**
 * Current order status.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CertificateOrderStatus {
  Pendingissuance,
  Issued,
  Revoked,
  Canceled,
  Denied,
  Pendingrevocation,
  PendingRekey,
  Unused,
  Expired,
  NotSubmitted,
}

/**
 * Action type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CertificateOrderActionType {
  CertificateIssued,
  CertificateOrderCanceled,
  CertificateOrderCreated,
  CertificateRevoked,
  DomainValidationComplete,
  FraudDetected,
  OrgNameChange,
  OrgValidationComplete,
  SanDrop,
  FraudCleared,
  CertificateExpired,
  CertificateExpirationWarning,
  FraudDocumentationRequired,
  Unknown,
}

/**
 * Collection of certificate orders.
 */
model AppServiceCertificateOrderCollection
  is Azure.Core.Page<AppServiceCertificateOrder>;

@@doc(AppServiceCertificateOrderCollection.value, "Collection of resources.");
@@doc(AppServiceCertificateOrderCollection.nextLink,
  "Link to next page of resources."
);
/**
 * AppServiceCertificateOrder resource specific properties
 */
model AppServiceCertificateOrderProperties {
  /**
   * State of the Key Vault secret.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  certificates?: Record<AppServiceCertificate>;

  /**
   * Certificate distinguished name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  distinguishedName?: string;

  /**
   * Domain verification token.
   */
  @visibility(Lifecycle.Read)
  domainVerificationToken?: string;

  /**
   * Duration in years (must be 1).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  validityInYears?: int32 = 1;

  /**
   * Certificate key size.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  keySize?: int32 = 2048;

  /**
   * Certificate product type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  productType: CertificateProductType;

  /**
   * <code>true</code> if the certificate should be automatically renewed when it expires; otherwise, <code>false</code>.
   */
  autoRenew?: boolean = true;

  /**
   * Status of certificate order.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Current order status.
   */
  @visibility(Lifecycle.Read)
  status?: CertificateOrderStatus;

  /**
   * Signed certificate.
   */
  @visibility(Lifecycle.Read)
  signedCertificate?: CertificateDetails;

  /**
   * Last CSR that was created for this order.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  csr?: string;

  /**
   * Intermediate certificate.
   */
  @visibility(Lifecycle.Read)
  intermediate?: CertificateDetails;

  /**
   * Root certificate.
   */
  @visibility(Lifecycle.Read)
  root?: CertificateDetails;

  /**
   * Current serial number of the certificate.
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * Certificate last issuance time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCertificateIssuanceTime?: utcDateTime;

  /**
   * Certificate expiration time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * <code>true</code> if private key is external; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isPrivateKeyExternal?: boolean;

  /**
   * Reasons why App Service Certificate is not renewable at the current moment.
   */
  @visibility(Lifecycle.Read)
  appServiceCertificateNotRenewableReasons?: ResourceNotRenewableReason[];

  /**
   * Time stamp when the certificate would be auto renewed next
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextAutoRenewalTimeStamp?: utcDateTime;

  /**
   * Contact info
   */
  @visibility(Lifecycle.Read)
  contact?: CertificateOrderContact;
}

/**
 * Key Vault container for a certificate that is purchased through Azure.
 */
model AppServiceCertificate {
  /**
   * Key Vault resource Id.
   */
  keyVaultId?: string;

  /**
   * Key Vault secret name.
   */
  keyVaultSecretName?: string;

  /**
   * Status of the Key Vault secret.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: KeyVaultSecretStatus;
}

/**
 * SSL certificate details.
 */
model CertificateDetails {
  /**
   * Certificate Version.
   */
  @visibility(Lifecycle.Read)
  version?: int32;

  /**
   * Certificate Serial Number.
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * Certificate Thumbprint.
   */
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  /**
   * Certificate Subject.
   */
  @visibility(Lifecycle.Read)
  subject?: string;

  /**
   * Date Certificate is valid from.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  notBefore?: utcDateTime;

  /**
   * Date Certificate is valid to.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  notAfter?: utcDateTime;

  /**
   * Certificate Signature algorithm.
   */
  @visibility(Lifecycle.Read)
  signatureAlgorithm?: string;

  /**
   * Certificate Issuer.
   */
  @visibility(Lifecycle.Read)
  issuer?: string;

  /**
   * Raw certificate data.
   */
  @visibility(Lifecycle.Read)
  rawData?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CertificateOrderContact {
  email?: string;
  nameFirst?: string;
  nameLast?: string;
  phone?: string;
}

/**
 * ARM resource for a certificate order that is purchased through Azure.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AppServiceCertificateOrderPatchResource extends ProxyOnlyResource {
  /**
   * AppServiceCertificateOrderPatchResource resource specific properties
   */
  properties?: AppServiceCertificateOrderPatchResourceProperties;
}

/**
 * AppServiceCertificateOrderPatchResource resource specific properties
 */
model AppServiceCertificateOrderPatchResourceProperties {
  /**
   * State of the Key Vault secret.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  certificates?: Record<AppServiceCertificate>;

  /**
   * Certificate distinguished name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  distinguishedName?: string;

  /**
   * Domain verification token.
   */
  @visibility(Lifecycle.Read)
  domainVerificationToken?: string;

  /**
   * Duration in years (must be 1).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  validityInYears?: int32 = 1;

  /**
   * Certificate key size.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  keySize?: int32 = 2048;

  /**
   * Certificate product type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  productType: CertificateProductType;

  /**
   * <code>true</code> if the certificate should be automatically renewed when it expires; otherwise, <code>false</code>.
   */
  autoRenew?: boolean = true;

  /**
   * Status of certificate order.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Current order status.
   */
  @visibility(Lifecycle.Read)
  status?: CertificateOrderStatus;

  /**
   * Signed certificate.
   */
  @visibility(Lifecycle.Read)
  signedCertificate?: CertificateDetails;

  /**
   * Last CSR that was created for this order.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  csr?: string;

  /**
   * Intermediate certificate.
   */
  @visibility(Lifecycle.Read)
  intermediate?: CertificateDetails;

  /**
   * Root certificate.
   */
  @visibility(Lifecycle.Read)
  root?: CertificateDetails;

  /**
   * Current serial number of the certificate.
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * Certificate last issuance time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCertificateIssuanceTime?: utcDateTime;

  /**
   * Certificate expiration time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * <code>true</code> if private key is external; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isPrivateKeyExternal?: boolean;

  /**
   * Reasons why App Service Certificate is not renewable at the current moment.
   */
  @visibility(Lifecycle.Read)
  appServiceCertificateNotRenewableReasons?: ResourceNotRenewableReason[];

  /**
   * Time stamp when the certificate would be auto renewed next
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextAutoRenewalTimeStamp?: utcDateTime;

  /**
   * Contact info
   */
  @visibility(Lifecycle.Read)
  contact?: CertificateOrderContact;
}

/**
 * Collection of certificate order certificates.
 */
model AppServiceCertificateCollection
  is Azure.Core.Page<AppServiceCertificateResource>;

/**
 * Key Vault container ARM resource for a certificate that is purchased through Azure.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AppServiceCertificatePatchResource extends ProxyOnlyResource {
  /**
   * Core resource properties
   */
  properties?: AppServiceCertificate;
}

/**
 * Class representing certificate reissue request.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ReissueCertificateOrderRequest extends ProxyOnlyResource {
  /**
   * ReissueCertificateOrderRequest resource specific properties
   */
  properties?: ReissueCertificateOrderRequestProperties;
}

/**
 * ReissueCertificateOrderRequest resource specific properties
 */
model ReissueCertificateOrderRequestProperties {
  /**
   * Certificate Key Size.
   */
  keySize?: int32;

  /**
   * Delay in hours to revoke existing certificate after the new certificate is issued.
   */
  delayExistingRevokeInHours?: int32;

  /**
   * Csr to be used for re-key operation.
   */
  csr?: string;

  /**
   * Should we change the ASC type (from managed private key to external private key and vice versa).
   */
  isPrivateKeyExternal?: boolean;
}

/**
 * Class representing certificate renew request.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RenewCertificateOrderRequest extends ProxyOnlyResource {
  /**
   * RenewCertificateOrderRequest resource specific properties
   */
  properties?: RenewCertificateOrderRequestProperties;
}

/**
 * RenewCertificateOrderRequest resource specific properties
 */
model RenewCertificateOrderRequestProperties {
  /**
   * Certificate Key Size.
   */
  keySize?: int32;

  /**
   * Csr to be used for re-key operation.
   */
  csr?: string;

  /**
   * Should we change the ASC type (from managed private key to external private key and vice versa).
   */
  isPrivateKeyExternal?: boolean;
}

/**
 * Site seal request.
 */
model SiteSealRequest {
  /**
   * If <code>true</code> use the light color theme for site seal; otherwise, use the default color theme.
   */
  lightTheme?: boolean;

  /**
   * Locale of site seal.
   */
  locale?: string;
}

/**
 * Site seal
 */
model SiteSeal {
  /**
   * HTML snippet
   */
  html: string;
}

/**
 * Certificate order action.
 */
model CertificateOrderAction {
  /**
   * Action type.
   */
  @visibility(Lifecycle.Read)
  actionType?: CertificateOrderActionType;

  /**
   * Time at which the certificate action was performed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;
}

/**
 * SSL certificate email.
 */
model CertificateEmail {
  /**
   * Email id.
   */
  emailId?: string;

  /**
   * Time stamp.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStamp?: utcDateTime;
}
