import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-portal-core";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.Portal;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

/** Api versions */
enum Versions {
  /** 2024-12-01 api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-12-01`,
}

//---------------------------------------------- AcmCertificateSummaries ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "ACM Certificate Summary",
    plural: "ACM Certificate Summaries",
  },
  keywords: ["Microsoft.AwsConnector", "ACM", "Certificate", "Summary"],
})
@doc("A Microsoft.AwsConnector resource")
model AcmCertificateSummary
  is TrackedResource<AcmCertificateSummaryProperties> {
  @doc("Name of AcmCertificateSummary")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("acmCertificateSummaries")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AcmCertificateSummary")
model AcmCertificateSummaryProperties {
  @doc("AWS Properties")
  awsProperties?: AwsAcmCertificateSummaryProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsAcmCertificateSummary")
model AwsAcmCertificateSummaryProperties {
  @doc("<p>Amazon Resource Name (ARN) of the certificate. This is of the form:</p> <p> <code>arn:aws:acm:region:123456789012:certificate/12345678-1234-1234-1234-123456789012</code> </p> <p>For more information about ARNs, see <a href='https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html'>Amazon Resource Names (ARNs)</a>.</p>")
  certificateArn?: string;

  @doc("<p>The time at which the certificate was requested.</p>")
  createdAt?: utcDateTime;

  @doc("<p>Fully qualified domain name (FQDN), such as www.example.com or example.com, for the certificate.</p>")
  domainName?: string;

  @doc("<p>Indicates whether the certificate has been exported. This value exists only when the certificate type is <code>PRIVATE</code>.</p>")
  exported?: boolean;

  @doc("<p>Contains a list of Extended Key Usage X.509 v3 extension objects. Each object specifies a purpose for which the certificate public key can be used and consists of a name and an object identifier (OID). </p>")
  @extension("x-ms-identifiers", [])
  extendedKeyUsages?: ExtendedKeyUsageName[];

  @doc("<p>When called by <a href='https://docs.aws.amazon.com/acm/latestAPIReference/API_ListCertificates.html'>ListCertificates</a>, indicates whether the full list of subject alternative names has been included in the response. If false, the response includes all of the subject alternative names included in the certificate. If true, the response only includes the first 100 subject alternative names included in the certificate. To display the full list of subject alternative names, use <a href='https://docs.aws.amazon.com/acm/latestAPIReference/API_DescribeCertificate.html'>DescribeCertificate</a>.</p>")
  hasAdditionalSubjectAlternativeNames?: boolean;

  @doc("<p>The date and time when the certificate was imported. This value exists only when the certificate type is <code>IMPORTED</code>. </p>")
  importedAt?: utcDateTime;

  @doc("<p>Indicates whether the certificate is currently in use by any Amazon Web Services resources.</p>")
  inUse?: boolean;

  @doc("<p>The time at which the certificate was issued. This value exists only when the certificate type is <code>AMAZON_ISSUED</code>. </p>")
  issuedAt?: utcDateTime;

  @doc("<p>The algorithm that was used to generate the public-private key pair.</p>")
  keyAlgorithm?: KeyAlgorithmEnumValue;

  @doc("<p>A list of Key Usage X.509 v3 extension objects. Each object is a string value that identifies the purpose of the public key contained in the certificate. Possible extension values include DIGITAL_SIGNATURE, KEY_ENCHIPHERMENT, NON_REPUDIATION, and more.</p>")
  @extension("x-ms-identifiers", [])
  keyUsages?: KeyUsageName[];

  @doc("<p>The time after which the certificate is not valid.</p>")
  notAfter?: utcDateTime;

  @doc("<p>The time before which the certificate is not valid.</p>")
  notBefore?: utcDateTime;

  @doc("<p>Specifies whether the certificate is eligible for renewal. At this time, only exported private certificates can be renewed with the <a>RenewCertificate</a> command.</p>")
  renewalEligibility?: RenewalEligibilityEnumValue;

  @doc("<p>The time at which the certificate was revoked. This value exists only when the certificate status is <code>REVOKED</code>. </p>")
  revokedAt?: utcDateTime;

  @doc("<p>The status of the certificate.</p> <p>A certificate enters status PENDING_VALIDATION upon being requested, unless it fails for any of the reasons given in the troubleshooting topic <a href='https://docs.aws.amazon.com/acm/latest/userguide/troubleshooting-failed.html'>Certificate request fails</a>. ACM makes repeated attempts to validate a certificate for 72 hours and then times out. If a certificate shows status FAILED or VALIDATION_TIMED_OUT, delete the request, correct the issue with <a href='https://docs.aws.amazon.com/acm/latest/userguide/dns-validation.html'>DNS validation</a> or <a href='https://docs.aws.amazon.com/acm/latest/userguide/email-validation.html'>Email validation</a>, and try again. If validation succeeds, the certificate enters status ISSUED. </p>")
  status?: CertificateStatusEnumValue;

  @doc("<p>One or more domain names (subject alternative names) included in the certificate. This list contains the domain names that are bound to the public key that is contained in the certificate. The subject alternative names include the canonical domain name (CN) of the certificate and additional domain names that can be used to connect to the website. </p> <p>When called by <a href='https://docs.aws.amazon.com/acm/latestAPIReference/API_ListCertificates.html'>ListCertificates</a>, this parameter will only return the first 100 subject alternative names included in the certificate. To display the full list of subject alternative names, use <a href='https://docs.aws.amazon.com/acm/latestAPIReference/API_DescribeCertificate.html'>DescribeCertificate</a>.</p>")
  @extension("x-ms-identifiers", [])
  subjectAlternativeNameSummaries?: string[];

  @doc("<p>The source of the certificate. For certificates provided by ACM, this value is <code>AMAZON_ISSUED</code>. For certificates that you imported with <a>ImportCertificate</a>, this value is <code>IMPORTED</code>. ACM does not provide <a href='https://docs.aws.amazon.com/acm/latest/userguide/acm-renewal.html'>managed renewal</a> for imported certificates. For more information about the differences between certificates that you import and those that ACM provides, see <a href='https://docs.aws.amazon.com/acm/latest/userguide/import-certificate.html'>Importing Certificates</a> in the <i>Certificate Manager User Guide</i>. </p>")
  type?: CertificateTypeEnumValue;
}

@doc("ExtendedKeyUsageName enum")
union ExtendedKeyUsageName {
  @doc("ExtendedKeyUsageName enum ANY")
  ANY: "ANY",

  @doc("ExtendedKeyUsageName enum CODE_SIGNING")
  CODE_SIGNING: "CODE_SIGNING",

  @doc("ExtendedKeyUsageName enum CUSTOM")
  CUSTOM: "CUSTOM",

  @doc("ExtendedKeyUsageName enum EMAIL_PROTECTION")
  EMAIL_PROTECTION: "EMAIL_PROTECTION",

  @doc("ExtendedKeyUsageName enum IPSEC_END_SYSTEM")
  IPSEC_END_SYSTEM: "IPSEC_END_SYSTEM",

  @doc("ExtendedKeyUsageName enum IPSEC_TUNNEL")
  IPSEC_TUNNEL: "IPSEC_TUNNEL",

  @doc("ExtendedKeyUsageName enum IPSEC_USER")
  IPSEC_USER: "IPSEC_USER",

  @doc("ExtendedKeyUsageName enum NONE")
  NONE: "NONE",

  @doc("ExtendedKeyUsageName enum OCSP_SIGNING")
  OCSP_SIGNING: "OCSP_SIGNING",

  @doc("ExtendedKeyUsageName enum TIME_STAMPING")
  TIME_STAMPING: "TIME_STAMPING",

  @doc("ExtendedKeyUsageName enum TLS_WEB_CLIENT_AUTHENTICATION")
  TLS_WEB_CLIENT_AUTHENTICATION: "TLS_WEB_CLIENT_AUTHENTICATION",

  @doc("ExtendedKeyUsageName enum TLS_WEB_SERVER_AUTHENTICATION")
  TLS_WEB_SERVER_AUTHENTICATION: "TLS_WEB_SERVER_AUTHENTICATION",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ExtendedKeyUsageNameEnumValue")
model ExtendedKeyUsageNameEnumValue {
  @doc("Property value")
  value?: ExtendedKeyUsageName;
}

@doc("KeyUsageName enum")
union KeyUsageName {
  @doc("KeyUsageName enum ANY")
  ANY: "ANY",

  @doc("KeyUsageName enum CERTIFICATE_SIGNING")
  CERTIFICATE_SIGNING: "CERTIFICATE_SIGNING",

  @doc("KeyUsageName enum CRL_SIGNING")
  CRL_SIGNING: "CRL_SIGNING",

  @doc("KeyUsageName enum CUSTOM")
  CUSTOM: "CUSTOM",

  @doc("KeyUsageName enum DATA_ENCIPHERMENT")
  DATA_ENCIPHERMENT: "DATA_ENCIPHERMENT",

  @doc("KeyUsageName enum DECIPHER_ONLY")
  DECIPHER_ONLY: "DECIPHER_ONLY",

  @doc("KeyUsageName enum DIGITAL_SIGNATURE")
  DIGITAL_SIGNATURE: "DIGITAL_SIGNATURE",

  @doc("KeyUsageName enum ENCIPHER_ONLY")
  ENCIPHER_ONLY: "ENCIPHER_ONLY",

  @doc("KeyUsageName enum KEY_AGREEMENT")
  KEY_AGREEMENT: "KEY_AGREEMENT",

  @doc("KeyUsageName enum KEY_ENCIPHERMENT")
  KEY_ENCIPHERMENT: "KEY_ENCIPHERMENT",

  @doc("KeyUsageName enum NON_REPUDIATION")
  NON_REPUDIATION: "NON_REPUDIATION",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KeyUsageNameEnumValue")
model KeyUsageNameEnumValue {
  @doc("Property value")
  value?: KeyUsageName;
}

@doc("CertificateStatus enum")
union CertificateStatus {
  @doc("CertificateStatus enum EXPIRED")
  EXPIRED: "EXPIRED",

  @doc("CertificateStatus enum FAILED")
  FAILED: "FAILED",

  @doc("CertificateStatus enum INACTIVE")
  INACTIVE: "INACTIVE",

  @doc("CertificateStatus enum ISSUED")
  ISSUED: "ISSUED",

  @doc("CertificateStatus enum PENDING_VALIDATION")
  PENDING_VALIDATION: "PENDING_VALIDATION",

  @doc("CertificateStatus enum REVOKED")
  REVOKED: "REVOKED",

  @doc("CertificateStatus enum VALIDATION_TIMED_OUT")
  VALIDATION_TIMED_OUT: "VALIDATION_TIMED_OUT",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CertificateStatusEnumValue")
model CertificateStatusEnumValue {
  @doc("Property value")
  value?: CertificateStatus;
}

@doc("KeyAlgorithm enum")
union KeyAlgorithm {
  @doc("KeyAlgorithm enum EC_prime256v1")
  EC_prime256v1: "EC_prime256v1",

  @doc("KeyAlgorithm enum EC_secp384r1")
  EC_secp384r1: "EC_secp384r1",

  @doc("KeyAlgorithm enum EC_secp521r1")
  EC_secp521r1: "EC_secp521r1",

  @doc("KeyAlgorithm enum RSA_1024")
  RSA_1024: "RSA_1024",

  @doc("KeyAlgorithm enum RSA_2048")
  RSA_2048: "RSA_2048",

  @doc("KeyAlgorithm enum RSA_3072")
  RSA_3072: "RSA_3072",

  @doc("KeyAlgorithm enum RSA_4096")
  RSA_4096: "RSA_4096",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KeyAlgorithmEnumValue")
model KeyAlgorithmEnumValue {
  @doc("Property value")
  value?: KeyAlgorithm;
}

@doc("CertificateType enum")
union CertificateType {
  @doc("CertificateType enum AMAZON_ISSUED")
  AMAZON_ISSUED: "AMAZON_ISSUED",

  @doc("CertificateType enum IMPORTED")
  IMPORTED: "IMPORTED",

  @doc("CertificateType enum PRIVATE")
  PRIVATE: "PRIVATE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CertificateTypeEnumValue")
model CertificateTypeEnumValue {
  @doc("Property value")
  value?: CertificateType;
}

@doc("RenewalEligibility enum")
union RenewalEligibility {
  @doc("RenewalEligibility enum ELIGIBLE")
  ELIGIBLE: "ELIGIBLE",

  @doc("RenewalEligibility enum INELIGIBLE")
  INELIGIBLE: "INELIGIBLE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RenewalEligibilityEnumValue")
model RenewalEligibilityEnumValue {
  @doc("Property value")
  value?: RenewalEligibility;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface AcmCertificateSummaries {
  get is ArmResourceRead<AcmCertificateSummary>;
  @doc("Create a AcmCertificateSummary. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<AcmCertificateSummary>;
  update is ArmCustomPatchAsync<
    AcmCertificateSummary,
    Azure.ResourceManager.Foundations.TagsUpdateModel<AcmCertificateSummary>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<AcmCertificateSummary>;
  listByResourceGroup is ArmResourceListByParent<AcmCertificateSummary>;
  listBySubscription is ArmListBySubscription<AcmCertificateSummary>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\acm\acm-2015-12-08.normal.json
// AWS Shape: CertificateSummary
//
// Related information for backend service:
// AWS Servcie : ACM
// Product Version : 3.7.798.0
// SDK Version : 3.7.300.83
//--------------------------------------------------------------------------------------------
