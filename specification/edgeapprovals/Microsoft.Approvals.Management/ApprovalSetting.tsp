using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Approvals;

@doc("ApprovalSetting singleton resource.")
@singleton("default")
@subscriptionResource
model ApprovalSetting is ProxyResource<ApprovalSettingProperties> {
  ...ResourceNameParameter<ApprovalSetting>;
  ...EntityTagProperty;
}

@doc("RP-specific properties of an ApprovalSetting resource.")
model ApprovalSettingProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The list of verification authorities.")
  @identifiers(#["name"])
  verificationAuthorities: VerificationAuthority[];

  @doc("The settings of the requested verifiable credentials in the approvals service.")
  requestedCredentialsSetting: ApprovalRequestCredentialsSetting;

  @doc("The settings of backend storage for approval service to use as a ledger.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  secureLedgerSetting: SecureLedgerSetting;

  @doc("The settings for the root workflow approval.")
  approvalAdminSetting: ApprovalAdminSetting;
}

@doc("Settings for the root workflow approval.")
model ApprovalAdminSetting {
  @doc("The minimum number of admins required to be registered in the approvals service.")
  minimumAdminCount: int32;

  @doc("The approval scheme for the root workflow.")
  rootWorkflowApprovalScheme: WorkflowApprovalScheme;
}

@doc("The approval scheme for a workflow.")
model WorkflowApprovalScheme {
  @doc("The type of the approval scheme.")
  type: approvalSchemeType;

  @doc("The minimum number of approvals required for the MinimumApprovalCount scheme.")
  minimumApprovalsRequired: int32;
}

@doc("Enum of the supported approval schemes.")
union approvalSchemeType {
  string,

  @doc("Majority approval scheme.")
  MajorityApproval: "MajorityApproval",

  @doc("Minimum approval count scheme.")
  MinimumApprovalCount: "MinimumApprovalCount",
}

@doc("Information about a verification authority.")
model VerificationAuthority {
  @doc("The name of the verification authority.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: string;

  @doc("The API endpoint of the verification authority.")
  apiEndpoint: string;

  @doc("The API scope of the verification authority.")
  apiScope: string;

  @doc("The subject identifier for the verification authority.")
  subjectIdentifier: string;

  @doc("The requested verifiable credentials for the verification authority.")
  requestedCredential: RequestCredentialSetting;
}

@doc("Settings of the requested verifiable credentials in the approvals service.")
model ApprovalRequestCredentialsSetting {
  @doc("The requested verifiable credentials for approvers.")
  approver: RequestCredentialSetting;

  @doc("The requested verifiable credentials for admins.")
  admin: RequestCredentialSetting;

  @doc("The requested verifiable credentials for devices.")
  device: RequestCredentialSetting;

  @doc("The requested verifiable credentials for the approver management service.")
  approverManagementService: RequestCredentialSetting;
}

@doc("The requested verifiable credentials for a specific type.")
model RequestCredentialSetting {
  @doc("The list of issuers' decentralized identifiers that can be accepted.")
  acceptedIssuers: string[];

  @doc("The type of verifiable credential.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vcType: string;
}

@doc("Settings of backend storage for approval service to use as a ledger.")
model SecureLedgerSetting {
  @doc("The storage type.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  type: secureLedgerStorageType;

  @doc("The regions the storage should be created at and replicated to.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  regions: string[];

  @doc("The endpoint to access the storage.")
  @invisible(Lifecycle)
  endpoint: string;
}

@doc("Enum of the backend storage types for approval service to use as a ledger.")
union secureLedgerStorageType {
  string,

  @doc("Azure Cosmos DB.")
  CosmosDB: "AzureCosmosDB",

  @doc("Azure Confidential Ledger.")
  AzureConfidentialLedger: "AzureConfidentialLedger",
}

@doc("Request payload for initializing approval settings.")
model InitializeApprovalSettingRequest {
  @doc("The list of signed records to bootstrap the approval system.")
  signedRecords: string[];
}

@armResourceOperations(ApprovalSetting)
interface ApprovalSettings {
  get is ArmResourceRead<ApprovalSetting>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ApprovalSetting>;
  update is ArmResourcePatchSync<ApprovalSetting, ApprovalSettingProperties>;
  delete is ArmResourceDeleteSync<ApprovalSetting>;
  listBySubscription is ArmListBySubscription<ApprovalSetting>;

  @doc("Initializes the approval setting with signed records.")
  @action("initialize")
  initialize is ArmResourceActionSync<
    ApprovalSetting,
    InitializeApprovalSettingRequest,
    ApprovalSetting
  >;
}
