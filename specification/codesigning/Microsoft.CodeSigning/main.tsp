import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Autorest;

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
  title: "Azure.CodeSigning service",
})
@versioned(Azure.CodeSigning.Versions)
@server(
  "https://{region}.codesigning.azure.net/",
  "Azure CodeSigning is a service that provides managed code signing for all.",
  {
    @doc("The region where we will sign code.")
    region: string,
  }
)
@doc("Azure CodeSigning is a service that provides managed code signing for all.")
namespace Azure.CodeSigning;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2022_06_15_preview: "2022-06-15-preview",
}

interface CertificateProfileOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is a custom operation status endpoint."
  @summary("Gets the status of a sign operation.")
  @doc("Gets the status of a sign operation.")
  @example(
    "./examples/CertificateProfile_GetSignOperation.json",
    "GetSignOperation"
  )
  @route("/codesigningaccounts/{codeSigningAccountName}/certificateprofiles/{certificateProfileName}/sign/{operationId}")
  getSignOperation is Foundations.GetOperationStatus<
    CodeSignStatus,
    OperationStatus
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is a custom operation status endpoint."
  @summary("Gets the sign root certificate on the certificate chain.")
  @route("/codesigningaccounts/{codeSigningAccountName}/certificateprofiles/{certificateProfileName}/sign/rootcert")
  @doc("Gets the sign root certificate on the certificate chain.")
  @example(
    "./examples/CertificateProfile_GetSignRootCert.json",
    "GetSignRootCertificate"
  )
  getSignRootCertificate(
    ...CodeSignStatus
  ): BytesBody<"application/x-x509-ca-cert">;

  @summary("Gets a list of Extended Key Usage OIDs that are allowed.")
  @doc("Gets a list of Extended Key Usage OIDs that are allowed.")
  @example("./examples/CertificateProfile_GetSignEku.json", "GetSignEku")
  listSignEku is StandardResourceOperations.ResourceList<Eku>;

  @summary("Initiates a sign operation.")
  @doc("Initiates a sign operation.")
  @example("./examples/CertificateProfile_Sign.json", "Sign")
  @pollingOperation(CertificateProfileOperations.getSignOperation)
  sign is StandardResourceOperations.LongRunningResourceAction<
    CertificateProfile,
    SignRequest,
    OperationStatus
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

@doc("Sign status of the operation.")
@lroStatus
enum Status {
  NotStarted,
  Running,
  Succeeded,
  Failed,
  Canceled,
}

@doc("Code Signing Account")
@resource("codesigningaccounts")
model CodeSigningAccount {
  @key("codeSigningAccountName")
  @visibility("read", "update")
  @doc("Azure Code Signing account name.")
  codeSigningAccountName: string;
}

@doc("Certificate Profile")
@resource("certificateprofiles")
@parentResource(CodeSigningAccount)
model CertificateProfile {
  @key("certificateProfileName")
  @visibility("read", "update")
  @doc("Azure Code Signing certificate profile name.")
  certificateProfileName: string;
}

@doc("The sign request information to be signed.")
model SignRequest {
  @doc("The following algorithm identifiers are supported.")
  signatureAlgorithm: SignatureAlgorithm;

  @doc("Digest to sign.")
  digest: bytes;

  @doc("List of full file hash.")
  fileHashList?: bytes[];

  @doc("List of authenticode hash.")
  authenticodeHashList?: bytes[];
}

@doc("The operation status response model.")
model OperationStatus {
  @doc("Unique ID of the operation.")
  id: string;

  @doc("The status of the sign operation.")
  status?: Status;

  @doc("The resulting sign operation including the signature and signing certificate.")
  signStatus?: SignStatus;
}

@doc("The sign status model.")
model SignStatus {
  @doc("ID of the operation.")
  operationId: string;

  @doc("The status of the sign operation.")
  status: Status;

  @doc("Signature of the requested digest.")
  signature?: bytes;

  @doc("""
Signing certificate corresponding to the private key used to sign the requested
digest.
""")
  signingCertificate?: bytes;
}

@doc("Sign status request parameters")
model CodeSignStatus {
  @doc("Azure Code Signing account name.")
  @path
  codeSigningAccountName: string;

  @doc("Certificate profile name.")
  @path
  certificateProfileName: string;
}

@doc("Extended Key Usage OIDs that are allowed.")
@resource("sign/eku")
@parentResource(CertificateProfile)
model Eku {
  @key("eku")
  @visibility("read", "update")
  @doc("The element of eku list.")
  ekus: string[];
}

@doc("Public root certificate.")
model BytesBody<ContentType> {
  @doc("The root certificate.")
  @body
  body: bytes;

  @doc("The content type of the x509 cert.")
  @header
  contentType: ContentType;
}
