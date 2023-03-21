import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service({
  title: "Azure.CodeSigning service",
})
@versioned(Azure.CodeSigning.Versions)

@server(
  "https://{region}.codesigning.azure.net/", 
  "Azure CodeSigning is a service that provides managed code signing for all.", {
    @doc("The region where we will sign code.")
     region?: string = "eus"
  }
)

namespace Azure.CodeSigning;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2022_06_15_preview: "2022-06-15-preview",
}

interface CertificateProfileOperations {
  @summary("Gets the status of a sign operation.")
  @doc("Gets the status of a sign operation.")
  @route("/codesigningaccounts/{codeSigningAccountName}/certificateprofiles/{certificateProfileName}/sign/{operationId}")
  GetSignOperation is Foundations.GetOperationStatus<CodeSignStatus,OperationStatus>;

  @summary("Gets a list of Extended Key Usage OIDs that are allowed.")
  @doc("Gets a list of Extended Key Usage OIDs that are allowed.")
  GetSignEku is ResourceList<Eku>;

  @summary("Initiates a sign operation.")
  @doc("Initiates a sign operation.")
  @pollingOperation(CertificateProfileOperations.GetSignOperation)
  Sign is ResourceAction<CertificateProfile,SignRequest,OperationStatus>;
}

@doc("Algorithms supported for signing.")
enum SignatureAlgorithm {
  "RS256",
  "RS384",
  "RS512",
  "PS256",
  "PS384",
  "PS512",
  "ES256",
  "ES384",
  "ES512",
  "ES256K",
}

@doc("Sign status of the operation.")
@lroStatus
enum Status {
  "NotStarted",
  "Running",
  "Succeeded",
  "Failed",
  "Canceled",
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
  id?: string;

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
@parentResource(CertificateProfile)
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
  body: string[];
}