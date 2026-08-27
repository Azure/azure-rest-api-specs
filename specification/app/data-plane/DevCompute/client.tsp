import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using AzureDevCompute;

namespace AzureDevCompute;

@@clientName(SandboxFields.appUrl, "appUri", "csharp");
@@clientName(SandboxFields.managementUrl, "managementUri", "csharp");
@@clientName(GatewayConnection.mcpRuntimeUrl, "mcpRuntimeUri", "csharp");
@@clientName(
  GatewayConnection.connectionRuntimeUrl,
  "connectionRuntimeUri",
  "csharp"
);
@@clientName(ErrorResponse, "ErrorResult", "csharp");
@@clientName(AddPortRequest, "AddPortContent", "csharp");
@@clientName(
  SandboxExecutionTokenResponse,
  "SandboxExecutionTokenResult",
  "csharp"
);
@@clientName(
  SandboxExecutionTokensRequest,
  "SandboxExecutionTokensContent",
  "csharp"
);
@@clientName(SandboxRequest, "SandboxContent", "csharp");
@@clientName(
  AzureDevCompute.SandboxListResponse,
  "SandboxListResult",
  "csharp"
);
@@clientName(
  AzureDevCompute.SandboxCreatedResponse,
  "SandboxCreatedResult",
  "csharp"
);
@@clientName(AzureDevCompute.SandboxResponse, "SandboxResult", "csharp");
@@clientName(
  AzureDevCompute.SandboxDeletedResponse,
  "SandboxDeletedResult",
  "csharp"
);
@@clientName(
  AzureDevCompute.SandboxDeletedNoContentResponse,
  "SandboxDeletedNoContentResult",
  "csharp"
);
@@clientName(
  AuthorizeConnectionRequest,
  "AuthorizeConnectionContent",
  "csharp"
);
@@clientName(ConnectionCreateRequest, "ConnectionCreateContent", "csharp");
@@clientName(ConnectionResponse, "ConnectionResult", "csharp");
@@clientName(
  GenerateConsentLinkRequest,
  "GenerateConsentLinkContent",
  "csharp"
);
@@clientName(
  GenerateConsentLinkResponse,
  "GenerateConsentLinkResult",
  "csharp"
);
@@clientName(UpdatePolicyRulesRequest, "UpdatePolicyRulesContent", "csharp");
@@clientName(ContentPackageListResponse, "ContentPackageListResult", "csharp");
@@clientName(ContentPackageResponse, "ContentPackageResult", "csharp");
@@clientName(
  SandboxGroupCredentialRequest,
  "SandboxGroupCredentialContent",
  "csharp"
);
@@clientName(
  SandboxGroupCredentialResponse,
  "SandboxGroupCredentialResult",
  "csharp"
);
@@clientName(
  BuildDiskImageFromDockerfileRequest,
  "BuildDiskImageFromDockerfileContent",
  "csharp"
);
@@clientName(CreateDiskImageRequest, "CreateDiskImageContent", "csharp");
@@clientName(CreateDiskImageV2Request, "CreateDiskImageV2Content", "csharp");
@@clientName(DiskImageOperationResponse, "DiskImageOperationResult", "csharp");
@@clientName(DiskImageRequest, "DiskImageContent", "csharp");
@@clientName(PublicDiskImageResponse, "PublicDiskImageResult", "csharp");
@@clientName(DiskImageResponse, "DiskImageResult", "csharp");
@@clientName(
  NamedEgressPolicyListResponse,
  "NamedEgressPolicyListResult",
  "csharp"
);
@@clientName(NamedEgressPolicyResponse, "NamedEgressPolicyResult", "csharp");
@@clientName(DirListingResponse, "DirListingResult", "csharp");
@@clientName(FileInfoResponse, "FileInfoResult", "csharp");
@@clientName(FileOpStatusResponse, "FileOpStatusResult", "csharp");
@@clientName(MkDirRequest, "MkDirContent", "csharp");
@@clientName(WriteFileResponse, "WriteFileResult", "csharp");
@@clientName(BatchSandboxRequest, "BatchSandboxContent", "csharp");
@@clientName(BatchSandboxResponse, "BatchSandboxResult", "csharp");
@@clientName(
  SandboxExecuteCommandRequest,
  "SandboxExecuteCommandContent",
  "csharp"
);
@@clientName(
  SandboxExecuteCommandResponse,
  "SandboxExecuteCommandResult",
  "csharp"
);
@@clientName(
  SandboxExecuteShellCommandRequest,
  "SandboxExecuteShellCommandContent",
  "csharp"
);
@@clientName(
  SandboxExecuteShellCommandResponse,
  "SandboxExecuteShellCommandResult",
  "csharp"
);
@@clientName(
  SandboxGenerateTokenRequest,
  "SandboxGenerateTokenContent",
  "csharp"
);
@@clientName(SandboxResumeRequest, "SandboxResumeContent", "csharp");
@@clientName(SandboxStatsResponse, "SandboxStatsResult", "csharp");
@@clientName(AddConnectionRequest, "AddConnectionContent", "csharp");
@@clientName(ConnectionsListResponse, "ConnectionsListResult", "csharp");
@@clientName(EgressDecisionsResponse, "EgressDecisionsResult", "csharp");
@@clientName(PatchPortRequest, "PatchPortContent", "csharp");
@@clientName(PortsListResponse, "PortsListResult", "csharp");
@@clientName(RemovePortRequest, "RemovePortContent", "csharp");
@@clientName(UpdatePortsRequest, "UpdatePortsContent", "csharp");
@@clientName(AddPodVolumeMountsRequest, "AddPodVolumeMountsContent", "csharp");
@@clientName(AddVolumeMountRequest, "AddVolumeMountContent", "csharp");
@@clientName(CommitSandboxRequest, "CommitSandboxContent", "csharp");
@@clientName(CommitSandboxResponse, "CommitSandboxResult", "csharp");
@@clientName(
  DownloadContentPackageToSandboxRequest,
  "DownloadContentPackageToSandboxContent",
  "csharp"
);
@@clientName(SnapshotRequest, "SnapshotContent", "csharp");
@@clientName(SecretKeysResponse, "SecretKeysResult", "csharp");
@@clientName(SecretListResponse, "SecretListResult", "csharp");
@@clientName(SecretPeekResponse, "SecretPeekResult", "csharp");
@@clientName(SecretResponse, "SecretResult", "csharp");
@@clientName(SecretUpsertRequest, "SecretUpsertContent", "csharp");
@@clientName(SnapshotResponse, "SnapshotResult", "csharp");
@@clientName(ForkDataDiskVolumeRequest, "ForkDataDiskVolumeContent", "csharp");
@@clientName(VolumeCountResponse, "VolumeCountResult", "csharp");
@@clientName(
  VolumeListDirectoryResponse,
  "VolumeListDirectoryResult",
  "csharp"
);
@@clientName(VolumeRequest, "VolumeContent", "csharp");
@@clientName(
  VolumeRequestAzureBlobByoVolumeRequest,
  "VolumeRequestAzureBlobByoVolumeContent",
  "csharp"
);
@@clientName(
  VolumeRequestAzureBlobVolumeRequest,
  "VolumeRequestAzureBlobVolumeContent",
  "csharp"
);
@@clientName(
  VolumeRequestAzureFileCifsVolumeRequest,
  "VolumeRequestAzureFileCifsVolumeContent",
  "csharp"
);
@@clientName(
  VolumeRequestAzureFileNfsVolumeRequest,
  "VolumeRequestAzureFileNfsVolumeContent",
  "csharp"
);
@@clientName(
  VolumeRequestDataDiskVolumeRequest,
  "VolumeRequestDataDiskVolumeContent",
  "csharp"
);
@@clientName(VolumeResponse, "VolumeResult", "csharp");
@@clientName(
  VolumeResponseAzureBlobByoVolumeResponse,
  "VolumeResponseAzureBlobByoVolumeResult",
  "csharp"
);
@@clientName(
  VolumeResponseAzureBlobVolumeResponse,
  "VolumeResponseAzureBlobVolumeResult",
  "csharp"
);
@@clientName(
  VolumeResponseAzureFileCifsVolumeResponse,
  "VolumeResponseAzureFileCifsVolumeResult",
  "csharp"
);
@@clientName(
  VolumeResponseAzureFileNfsVolumeResponse,
  "VolumeResponseAzureFileNfsVolumeResult",
  "csharp"
);
@@clientName(
  VolumeResponseDataDiskVolumeResponse,
  "VolumeResponseDataDiskVolumeResult",
  "csharp"
);
@@clientName(DeleteConnectionsResponse, "DeleteConnectionsResult", "csharp");
@@clientName(ListConnectionResponse, "ListConnectionResult", "csharp");
@@clientName(GetConnectionResponse, "GetConnectionResult", "csharp");
@@clientName(
  PostConnectionsAuthorizeResponse,
  "PostConnectionsAuthorizeResult",
  "csharp"
);
@@clientName(
  PostConnectionsConsentLinkResponse,
  "PostConnectionsConsentLinkResult",
  "csharp"
);
@@clientName(
  PostConnectionsRefreshResponse,
  "PostConnectionsRefreshResult",
  "csharp"
);
@@clientName(
  PutConnectionsPolicyRulesResponse,
  "PutConnectionsPolicyRulesResult",
  "csharp"
);
@@clientName(ListContentPackageResponse, "ListContentPackageResult", "csharp");
@@clientName(GetContentPackageResponse, "GetContentPackageResult", "csharp");
@@clientName(
  PostContentpackagesUploadResponse,
  "PostContentpackagesUploadResult",
  "csharp"
);
@@clientName(DeleteCredentialsResponse, "DeleteCredentialsResult", "csharp");
@@clientName(ListCredentialResponse, "ListCredentialResult", "csharp");
@@clientName(GetCredentialResponse, "GetCredentialResult", "csharp");
@@clientName(PutCredentialsResponse, "PutCredentialsResult", "csharp");
@@clientName(ListDiskImageResponse, "ListDiskImageResult", "csharp");
@@clientName(
  GetDiskimagesOperationsResponse,
  "GetDiskimagesOperationsResult",
  "csharp"
);
@@clientName(
  ListPublicDiskImageResponse,
  "ListPublicDiskImageResult",
  "csharp"
);
@@clientName(GetPublicDiskImageResponse, "GetPublicDiskImageResult", "csharp");
@@clientName(GetDiskImageResponse, "GetDiskImageResult", "csharp");
@@clientName(
  PostDiskimagesDockerfileResponse,
  "PostDiskimagesDockerfileResult",
  "csharp"
);
@@clientName(
  PostDiskimagesDockerfileAsyncResponse,
  "PostDiskimagesDockerfileAsyncResult",
  "csharp"
);
@@clientName(PutDiskimagesResponse, "PutDiskimagesResult", "csharp");
@@clientName(
  PutDiskimagesAsyncPreviewResponse,
  "PutDiskimagesAsyncPreviewResult",
  "csharp"
);
@@clientName(PutDiskimagesAsyncResponse, "PutDiskimagesAsyncResult", "csharp");
@@clientName(PutDiskimagesV2Response, "PutDiskimagesV2Result", "csharp");
@@clientName(
  PutDiskimagesV2AsyncResponse,
  "PutDiskimagesV2AsyncResult",
  "csharp"
);
@@clientName(
  DeleteEgressPoliciesResponse,
  "DeleteEgressPoliciesResult",
  "csharp"
);
@@clientName(ListEgressPolicyResponse, "ListEgressPolicyResult", "csharp");
@@clientName(GetEgressPolicyResponse, "GetEgressPolicyResult", "csharp");
@@clientName(
  DeleteSandboxesFilesResponse,
  "DeleteSandboxesFilesResult",
  "csharp"
);
@@clientName(GetSandboxesFilesResponse, "GetSandboxesFilesResult", "csharp");
@@clientName(
  GetSandboxesFilesListResponse,
  "GetSandboxesFilesListResult",
  "csharp"
);
@@clientName(
  GetSandboxesFilesStatResponse,
  "GetSandboxesFilesStatResult",
  "csharp"
);
@@clientName(
  PostSandboxesFilesMkdirResponse,
  "PostSandboxesFilesMkdirResult",
  "csharp"
);
@@clientName(PutSandboxesFilesResponse, "PutSandboxesFilesResult", "csharp");
@@clientName(GetSandboxesCountResponse, "GetSandboxesCountResult", "csharp");
@@clientName(GetSandboxesStatsResponse, "GetSandboxesStatsResult", "csharp");
@@clientName(
  PostSandboxesDisableResponse,
  "PostSandboxesDisableResult",
  "csharp"
);
@@clientName(
  PostSandboxesEnableResponse,
  "PostSandboxesEnableResult",
  "csharp"
);
@@clientName(
  PostSandboxesExecuteCommandResponse,
  "PostSandboxesExecuteCommandResult",
  "csharp"
);
@@clientName(
  PostSandboxesExecuteShellCommandResponse,
  "PostSandboxesExecuteShellCommandResult",
  "csharp"
);
@@clientName(
  PostSandboxesGenerateSandboxTokenResponse,
  "PostSandboxesGenerateSandboxTokenResult",
  "csharp"
);
@@clientName(
  PostSandboxesLifecycleResponse,
  "PostSandboxesLifecycleResult",
  "csharp"
);
@@clientName(
  PostSandboxesResumeResponse,
  "PostSandboxesResumeResult",
  "csharp"
);
@@clientName(PostSandboxesStopResponse, "PostSandboxesStopResult", "csharp");
@@clientName(
  PostSandboxesStopAsyncResponse,
  "PostSandboxesStopAsyncResult",
  "csharp"
);
@@clientName(PutSandboxesBatchResponse, "PutSandboxesBatchResult", "csharp");
@@clientName(
  GetSandboxesEgressDecisionsResponse,
  "GetSandboxesEgressDecisionsResult",
  "csharp"
);
@@clientName(
  GetSandboxesEgressDecisions2Response,
  "GetSandboxesEgressDecisions2Result",
  "csharp"
);
@@clientName(GetSandboxesPortsResponse, "GetSandboxesPortsResult", "csharp");
@@clientName(
  PatchSandboxesPortsResponse,
  "PatchSandboxesPortsResult",
  "csharp"
);
@@clientName(
  PostSandboxesConnectionsAddResponse,
  "PostSandboxesConnectionsAddResult",
  "csharp"
);
@@clientName(
  PostSandboxesEgresspolicyResponse,
  "PostSandboxesEgresspolicyResult",
  "csharp"
);
@@clientName(
  PostSandboxesPortsAddResponse,
  "PostSandboxesPortsAddResult",
  "csharp"
);
@@clientName(
  PostSandboxesPortsRemoveResponse,
  "PostSandboxesPortsRemoveResult",
  "csharp"
);
@@clientName(PutSandboxesPortsResponse, "PutSandboxesPortsResult", "csharp");
@@clientName(
  PostSandboxesCommitResponse,
  "PostSandboxesCommitResult",
  "csharp"
);
@@clientName(
  PostSandboxesDownloadContentPackageResponse,
  "PostSandboxesDownloadContentPackageResult",
  "csharp"
);
@@clientName(
  PostSandboxesPodVolumesAddResponse,
  "PostSandboxesPodVolumesAddResult",
  "csharp"
);
@@clientName(
  PostSandboxesPodVolumesAdd2Response,
  "PostSandboxesPodVolumesAdd2Result",
  "csharp"
);
@@clientName(
  PostSandboxesSnapshotResponse,
  "PostSandboxesSnapshotResult",
  "csharp"
);
@@clientName(
  PostSandboxesVolumesAddResponse,
  "PostSandboxesVolumesAddResult",
  "csharp"
);
@@clientName(
  GetSandboxesExecStreamResponse,
  "GetSandboxesExecStreamResult",
  "csharp"
);
@@clientName(
  GetSandboxesLogstreamResponse,
  "GetSandboxesLogstreamResult",
  "csharp"
);
@@clientName(
  GetSandboxesProcessesStreamResponse,
  "GetSandboxesProcessesStreamResult",
  "csharp"
);
@@clientName(DeleteSecretsResponse, "DeleteSecretsResult", "csharp");
@@clientName(GetSecretsResponse, "GetSecretsResult", "csharp");
@@clientName(GetSecretsKeysResponse, "GetSecretsKeysResult", "csharp");
@@clientName(PostSecretsPeekResponse, "PostSecretsPeekResult", "csharp");
@@clientName(ListSnapshotResponse, "ListSnapshotResult", "csharp");
@@clientName(GetSnapshotsCountResponse, "GetSnapshotsCountResult", "csharp");
@@clientName(GetSnapshotResponse, "GetSnapshotResult", "csharp");
@@clientName(DeleteVolumesResponse, "DeleteVolumesResult", "csharp");
@@clientName(DeleteVolumesFilesResponse, "DeleteVolumesFilesResult", "csharp");
@@clientName(ListVolumeResponse, "ListVolumeResult", "csharp");
@@clientName(GetVolumesCountResponse, "GetVolumesCountResult", "csharp");
@@clientName(GetVolumeResponse, "GetVolumeResult", "csharp");
@@clientName(GetVolumesFilesResponse, "GetVolumesFilesResult", "csharp");
@@clientName(
  GetVolumesFilesDownloadResponse,
  "GetVolumesFilesDownloadResult",
  "csharp"
);
@@clientName(
  PostVolumesFilesMkdirResponse,
  "PostVolumesFilesMkdirResult",
  "csharp"
);
@@clientName(PostVolumesForkResponse, "PostVolumesForkResult", "csharp");
@@clientName(PutVolumesResponse, "PutVolumesResult", "csharp");
@@clientName(
  PutVolumesFilesUploadResponse,
  "PutVolumesFilesUploadResult",
  "csharp"
);
