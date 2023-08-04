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
@service({
  title: "Azure CodeSigning",
  summary: "Azure CodeSigning is a service that provides managed code signing for all.",
})
@versioned(Azure.CodeSigning.Versions)
@server(
  "https://{region}.codesigning.azure.net/",
  "CodeSign and retrieve relevant information pertaining signing process.",
  {
    @doc("The Azure region wherein requests for signing will be sent.")
    region: string,
  }
)
@doc("Azure CodeSigning is a service that provides managed code signing for all.")
namespace Azure.CodeSigning;

@doc("Versions info.")
enum Versions {
  @doc("The 2023-06-15-preview version.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_06_15_preview: "2023-06-15-preview",
}

interface CertificateProfileOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is a custom operation status endpoint."
  @summary("Gets the status of a codesigning operation.")
  @doc("This status operation requires that a Sign request has been submitted and the operationId is known.")
  @route("/codesigningaccounts/{codeSigningAccountName}/certificateprofiles/{certificateProfileName}/sign/{operationId}")
  getCodeSigningStatus is Foundations.GetOperationStatus<
    CodeSigningOptions,
    CodeSignResult
  >;

  #suppress "@azure-tools/typespec-azure-core/rpc-operation-request-body" "no body included, bytesbody is the response object."
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Service needs rpc paths to follow pattern of other services."
  @summary("Gets the codesigning root certificate on the certificate chain for that account and profile name.")
  @doc("The root certificate is generated as part of the initial account creation and it is used to sign the bits for the profile provided.")
  @route("/codesigningaccounts/{codeSigningAccountName}/certificateprofiles/{certificateProfileName}/sign/rootcert")
  getSignRootCertificate is RpcOperation<
    CodeSigningOptions,
    BytesBody<"application/x-x509-ca-cert">
  >;

  @summary("Gets a list of extended key usage object identifiers that are allowed for this account and profile combination.")
  @doc("The list of extended key usages are used to determine the purpose of the certificate usage as part of the codesigning operation.")
  listSignEkus is StandardResourceOperations.ResourceList<ExtendedKeyUsage>;

  @summary("Submit a codesign operation.")
  @doc("Submit a codesign operation under the created codesign account and profile name provided.")
  @pollingOperation(CertificateProfileOperations.getCodeSigningStatus)
  sign is StandardResourceOperations.LongRunningResourceAction<
    CertificateProfile,
    CodeSigningSubmissionOptions,
    CodeSignOperationStatus
  >;
}

@doc("Algorithms supported for signing.")
enum SignatureAlgorithm {
  @doc("RSASSA-PKCS1-v1_5 using SHA-256 hash algorithm.")
  RS256,

  @doc("RSASSA-PKCS1-v1_5 using SHA-384 hash algorithm.")
  RS384,

  @doc("RSASSA-PKCS1-v1_5 using SHA-512 hash algorithm.")
  RS512,

  @doc("RSASSA-PSS using SHA-256 hash algorithm.")
  PS256,

  @doc("RSASSA-PSS using SHA-384 hash algorithm.")
  PS384,

  @doc("RSASSA-PSS using SHA-512 hash algorithm.")
  PS512,

  @doc("ECDSA using P-256 and SHA-256 hash algorithm.")
  ES256,

  @doc("ECDSA using P-384 and SHA-384 hash algorithm.")
  ES384,

  @doc("ECDSA using P-521 and SHA-512 hash algorithm.")
  ES512,

  @doc("ECDSA using secp256k1 and SHA-256 hash algorithm.")
  ES256K,
}

@doc("Azure CodeSigning customer account created upon registration on the service.")
@resource("codesigningaccounts")
model CodeSigningAccount {
  @key("codeSigningAccountName")
  @visibility("read", "update")
  @doc("Azure CodeSigning account name.")
  codeSigningAccountName: string;
}

@doc("Azure CodeSigning certificate profile configured on a codesign account.")
@resource("certificateprofiles")
@parentResource(CodeSigningAccount)
model CertificateProfile {
  @key("certificateProfileName")
  @visibility("read", "update")
  @doc("Azure Codesigning certificate profile name under a codesign account.")
  certificateProfileName: string;
}

@doc("The codesign request information to be signed by the service.")
model CodeSigningSubmissionOptions {
  @doc("The supported signature algorithm identifiers.")
  signatureAlgorithm: SignatureAlgorithm;

  @doc("Content digest to codesign.")
  digest: bytes;

  @doc("List of full file digital signatures.")
  fileHashList?: bytes[];

  @doc("List of authenticode digital signatures.")
  authenticodeHashList?: bytes[];
}

@doc("The codesign operation status response.")
model CodeSignOperationStatus {
  @doc("Unique Id of the operation.")
  id: string;

  @doc("The result of the codesign operation including the signature and signing certificate.")
  signResult?: CodeSignResult;
}

@doc("The sign status model.")
model CodeSignResult {
  @doc("Response Id of the codesign operation.")
  operationId: string;

  @doc("Digital signature of the requested content digest.")
  signature?: bytes;

  @doc("""
Signing certificate corresponding to the private key used to codesign the requested
digest.
""")
  signingCertificate?: bytes;
}

@doc("Codesigning option parameters corresponding to the account and certificate profile name.")
model CodeSigningOptions {
  @doc("CodeSigning account name.")
  @path
  codeSigningAccountName: string;

  @doc("Certificate profile name.")
  @path
  certificateProfileName: string;
}

@doc("Extended key usage object identifier that are allowed.")
@resource("sign/eku")
@parentResource(CertificateProfile)
model ExtendedKeyUsage {
  @key("ekus")
  @visibility("read", "update")
  @doc("An element of ekus.")
  ekus: string[];
}

@doc("Public root certificate from the certificate chain.")
model BytesBody<ContentType> {
  @doc("The root certificate of the certificate chain of this profile.")
  @body
  body: bytes;

  @doc("The content type of the x509 cert.")
  @header
  contentType: ContentType;
}
