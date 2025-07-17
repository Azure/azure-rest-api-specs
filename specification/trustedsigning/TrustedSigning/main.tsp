import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://codesigning.azure.net/.default"],
    }
  ]>
)
@service(#{ title: "Azure Trusted Signing" })
@versioned(Azure.Developer.TrustedSigning.Versions)
@server(
  "{endpoint}",
  "Sign and retrieve relevant information pertaining signing process.",
  {
    @doc("The Azure Trusted signing service endpoint.")
    endpoint: string,
  }
)
@doc("Azure Trusted Signing is a service that provides managed artifact signing for all.")
namespace Azure.Developer.TrustedSigning;

@doc("Versions info.")
enum Versions {
  @doc("The 2023-06-15-preview version.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_06_15_preview: "2023-06-15-preview",
}

interface CertificateProfileOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is a custom operation status endpoint."
  @summary("Gets the status of a signing operation.")
  @doc("This status operation requires that a Sign request has been submitted and the operationId is known.")
  @route("/codesigningaccounts/{accountName}/certificateprofiles/{certificateProfile}/sign")
  getSigningStatus is Foundations.GetOperationStatus<
    SigningOptions,
    SignResult
  >;

  #suppress "@azure-tools/typespec-azure-core/rpc-operation-request-body" "no body included, bytesbody is the response object."
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Service needs rpc paths to follow pattern of other services."
  @summary("Gets the signing root certificate on the certificate chain for that account and profile name.")
  @doc("The root certificate is generated as part of the initial account creation and it is used to sign the bits for the profile provided.")
  @route("/codesigningaccounts/{accountName}/certificateprofiles/{certificateProfile}/sign/rootcert")
  getSignRootCertificate is RpcOperation<
    SigningOptions,
    BytesBody<"application/x-x509-ca-cert">
  >;

  @summary("Gets a list of extended key usage object identifiers that are allowed for this account and profile combination.")
  @doc("The list of extended key usages are used to determine the purpose of the certificate usage as part of the signing operation.")
  listExtendedKeyUsages is StandardResourceOperations.ResourceList<ExtendedKeyUsage>;

  @summary("Submit a sign operation.")
  @doc("Submit a sign operation under the created account and profile name provided.")
  @pollingOperation(CertificateProfileOperations.getSigningStatus)
  sign is StandardResourceOperations.LongRunningResourceAction<
    CertificateProfileName,
    BodyParameter<SigningPayloadOptions>,
    SignResult,
    Foundations.ErrorResponse,
    SigningRequestHeadersTraits
  >;
}

@doc("Algorithms supported for signing.")
union SignatureAlgorithm {
  string,

  @doc("RSASSA-PKCS1-v1_5 using SHA-256 hash algorithm.")
  "RS256",

  @doc("RSASSA-PKCS1-v1_5 using SHA-384 hash algorithm.")
  "RS384",

  @doc("RSASSA-PKCS1-v1_5 using SHA-512 hash algorithm.")
  "RS512",

  @doc("RSASSA-PSS using SHA-256 hash algorithm.")
  "PS256",

  @doc("RSASSA-PSS using SHA-384 hash algorithm.")
  "PS384",

  @doc("RSASSA-PSS using SHA-512 hash algorithm.")
  "PS512",

  @doc("ECDSA using P-256 and SHA-256 hash algorithm.")
  "ES256",

  @doc("ECDSA using P-384 and SHA-384 hash algorithm.")
  "ES384",

  @doc("ECDSA using P-521 and SHA-512 hash algorithm.")
  "ES512",

  @doc("ECDSA using secp256k1 and SHA-256 hash algorithm.")
  "ES256K",
}

@doc("Azure Trusted Signing customer account created upon registration on the service.")
@resource("codesigningaccounts")
model SigningAccount {
  @key("accountName")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  @doc("Azure Trusted Signing account name.")
  accountName: string;
}

@doc("Azure Trusted Signing certificate profile configured on an account.")
@resource("certificateprofiles")
@parentResource(SigningAccount)
model CertificateProfileName {
  @key("certificateProfile")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  @doc("Azure Trusted Signing certificate profile name under an account.")
  certificateProfile: string;
}

@doc("The artifact request information to be signed by the service.")
model SigningPayloadOptions {
  @doc("The supported signature algorithm identifiers.")
  signatureAlgorithm: SignatureAlgorithm;

  @doc("Content digest to sign.")
  digest: bytes;

  @doc("List of full file digital signatures.")
  fileHashList?: bytes[];

  @doc("List of authenticode digital signatures.")
  authenticodeHashList?: bytes[];
}

@doc("The sign status model.")
model SignResult {
  @doc("Digital signature of the requested content digest.")
  signature?: bytes;

  @doc("""
    Signing certificate corresponding to the private key used to sign the requested 
    digest.
    """)
  signingCertificate?: bytes;
}

@doc("Signing option parameters corresponding to the account and certificate profile name.")
model SigningOptions {
  @doc("Signing account name.")
  @path
  accountName: string;

  @doc("Signing Certificate profile name.")
  @path
  certificateProfile: string;
}

@doc("Extended key usage object identifier that are allowable.")
@resource("sign/eku")
@parentResource(CertificateProfileName)
model ExtendedKeyUsage {
  @key("eku")
  @visibility(Lifecycle.Read)
  @doc("An oid string that represents an eku.")
  eku: string;
}

@doc("Public root certificate from the certificate chain.")
model BytesBody<ContentType> {
  @doc("The root certificate of the certificate chain of this profile.")
  @bodyRoot
  body: bytes;

  @doc("The content type of the x509 cert.")
  @header
  contentType: ContentType;
}

alias BodyParameter<
  T,
  TName extends valueof string = "body",
  TDoc extends valueof string = "Body parameter."
> = {
  #suppress "@azure-tools/typespec-azure-core/friendly-name" "Legacy"
  @doc(TDoc)
  @friendlyName(TName)
  @bodyRoot
  body: T;
};

alias SigningRequestHeadersTraits = Azure.Core.Traits.RequestHeadersTrait<{
  @doc("An optional client version.")
  @header
  clientVersion?: string;

  @doc("An identifier used to batch multiple requests.")
  @header
  xCorrelationId?: string;
}>;
