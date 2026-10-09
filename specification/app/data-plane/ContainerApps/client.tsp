import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace ContainerAppsSandbox {
  // Client hierarchy
  // These namespaces declare no REST operations. C#-only placement decorators below
  // populate the clients without changing the service interfaces or other languages.
  /** Operations on sandboxes within the group. */
  namespace Sandboxes {

  }

  namespace Connections {

  }

  namespace ContentPackages {

  }

  namespace Credentials {

  }

  namespace DiskImages {

  }

  namespace PublicDiskImages {

  }

  namespace EgressPolicies {

  }

  namespace Secrets {

  }

  namespace Snapshots {

  }

  namespace Volumes {

  }

  // Client initialization
  @@clientInitialization(
    ContainerAppsSandbox,
    {
      parameters: AzureResourceScope,
      initializedBy: InitializedBy.individually,
    },
    "csharp"
  );

  // Operation locations
  // Collection operations do not require an individual sandbox.
  @@clientLocation(AzureSandboxes.list, Sandboxes, "csharp");
  @@clientLocation(AzureSandboxes.create, Sandboxes, "csharp");
  @@clientLocation(
    SandboxLifecycleOperations.getSandboxesCount,
    Sandboxes,
    "csharp"
  );
  // Individual sandbox operations retain the sandbox identifier as a method parameter.
  @@clientLocation(AzureSandboxes.get, Sandboxes, "csharp");
  @@clientLocation(AzureSandboxes.delete, Sandboxes, "csharp");
  @@clientLocation(
    SandboxLifecycleOperations.getSandboxStats,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxLifecycleOperations.postSandboxDisable,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxLifecycleOperations.postSandboxEnable,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxLifecycleOperations.postSandboxExecuteCommand,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxLifecycleOperations.postSandboxExecuteShellCommand,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxLifecycleOperations.postSandboxLifecycle,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxLifecycleOperations.postSandboxResume,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxLifecycleOperations.postSandboxStop,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxStorageOperations.postSandboxCommit,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxStorageOperations.postSandboxDownloadContentPackage,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxStorageOperations.postSandboxPodVolumesAdd2,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxStorageOperations.postSandboxSnapshot,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxStorageOperations.postSandboxVolumeAdd,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxFilesOperations.deleteSandboxFile,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(SandboxFilesOperations.getSandboxFile, Sandboxes, "csharp");
  @@clientLocation(
    SandboxFilesOperations.getSandboxFilesList,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxFilesOperations.getSandboxFileStat,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxFilesOperations.postSandboxFileMkdir,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(SandboxFilesOperations.postSandboxFile, Sandboxes, "csharp");

  @@clientLocation(
    SandboxNetworkingOperations.getSandboxEgressDecisions,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxNetworkingOperations.getSandboxPorts,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxNetworkingOperations.patchSandboxPort,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxNetworkingOperations.postSandboxConnectionAdd,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxNetworkingOperations.postSandboxEgressPolicy,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxNetworkingOperations.postSandboxPortAdd,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxNetworkingOperations.postSandboxPortRemove,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxNetworkingOperations.putSandboxPorts,
    Sandboxes,
    "csharp"
  );

  @@clientLocation(
    SandboxStreamsOperations.getSandboxExecStream,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxStreamsOperations.getSandboxLogStream,
    Sandboxes,
    "csharp"
  );
  @@clientLocation(
    SandboxStreamsOperations.getSandboxProcessesStream,
    Sandboxes,
    "csharp"
  );

  // Supporting resources remain scoped to the sandbox group, not one sandbox.
  @@clientLocation(
    ConnectionsOperations.deleteConnection,
    Connections,
    "csharp"
  );
  @@clientLocation(
    ConnectionsOperations.listConnections,
    Connections,
    "csharp"
  );
  @@clientLocation(ConnectionsOperations.getConnection, Connections, "csharp");
  @@clientLocation(ConnectionsOperations.postConnection, Connections, "csharp");
  @@clientLocation(
    ConnectionsOperations.postConnectionAuthorize,
    Connections,
    "csharp"
  );
  @@clientLocation(
    ConnectionsOperations.postConnectionConsentLink,
    Connections,
    "csharp"
  );
  @@clientLocation(
    ConnectionsOperations.postConnectionRefresh,
    Connections,
    "csharp"
  );
  @@clientLocation(
    ConnectionsOperations.putConnectionPolicyRules,
    Connections,
    "csharp"
  );

  @@clientLocation(
    ContentPackagesOperations.deleteContentPackage,
    ContentPackages,
    "csharp"
  );
  @@clientLocation(
    ContentPackagesOperations.listContentPackages,
    ContentPackages,
    "csharp"
  );
  @@clientLocation(
    ContentPackagesOperations.getContentPackage,
    ContentPackages,
    "csharp"
  );
  @@clientLocation(
    ContentPackagesOperations.postContentPackageUpload,
    ContentPackages,
    "csharp"
  );

  @@clientLocation(
    CredentialsOperations.deleteCredential,
    Credentials,
    "csharp"
  );
  @@clientLocation(
    CredentialsOperations.listCredentials,
    Credentials,
    "csharp"
  );
  @@clientLocation(CredentialsOperations.getCredential, Credentials, "csharp");
  @@clientLocation(CredentialsOperations.putCredential, Credentials, "csharp");

  @@clientLocation(DiskImagesOperations.deleteDiskImage, DiskImages, "csharp");
  @@clientLocation(DiskImagesOperations.listDiskImages, DiskImages, "csharp");
  @@clientLocation(
    DiskImagesOperations.listDiskImagesPublic,
    PublicDiskImages,
    "csharp"
  );
  @@clientLocation(
    DiskImagesOperations.getDiskImagePublic,
    PublicDiskImages,
    "csharp"
  );
  @@clientLocation(DiskImagesOperations.getDiskImage, DiskImages, "csharp");
  @@clientLocation(DiskImagesOperations.postDiskImage, DiskImages, "csharp");

  @@clientLocation(
    EgressPoliciesOperations.deleteEgressPolicy,
    EgressPolicies,
    "csharp"
  );
  @@clientLocation(
    EgressPoliciesOperations.listEgressPolicies,
    EgressPolicies,
    "csharp"
  );
  @@clientLocation(
    EgressPoliciesOperations.getEgressPolicy,
    EgressPolicies,
    "csharp"
  );
  @@clientLocation(
    EgressPoliciesOperations.putEgressPolicy,
    EgressPolicies,
    "csharp"
  );

  @@clientLocation(SecretsOperations.deleteSecret, Secrets, "csharp");
  @@clientLocation(SecretsOperations.listSecrets, Secrets, "csharp");
  @@clientLocation(SecretsOperations.getSecretKeys, Secrets, "csharp");
  @@clientLocation(SecretsOperations.postSecretPeek, Secrets, "csharp");
  @@clientLocation(SecretsOperations.putSecret, Secrets, "csharp");

  @@clientLocation(SnapshotsOperations.deleteSnapshot, Snapshots, "csharp");
  @@clientLocation(SnapshotsOperations.listSnapshots, Snapshots, "csharp");
  @@clientLocation(SnapshotsOperations.getSnapshotsCount, Snapshots, "csharp");
  @@clientLocation(SnapshotsOperations.getSnapshot, Snapshots, "csharp");

  @@clientLocation(VolumesOperations.deleteVolume, Volumes, "csharp");
  @@clientLocation(VolumesOperations.deleteVolumeFile, Volumes, "csharp");
  @@clientLocation(VolumesOperations.listVolumes, Volumes, "csharp");
  @@clientLocation(VolumesOperations.getVolumesCount, Volumes, "csharp");
  @@clientLocation(VolumesOperations.getVolume, Volumes, "csharp");
  @@clientLocation(VolumesOperations.getVolumeFiles, Volumes, "csharp");
  @@clientLocation(VolumesOperations.getVolumeFileDownload, Volumes, "csharp");
  @@clientLocation(VolumesOperations.postVolumeFileMkdir, Volumes, "csharp");
  @@clientLocation(VolumesOperations.postVolumeFork, Volumes, "csharp");
  @@clientLocation(VolumesOperations.createVolume, Volumes, "csharp");
  @@clientLocation(
    VolumesOperations.createOrReplaceVolumeFile,
    Volumes,
    "csharp"
  );

  // Client names
  // The C# emitter prefixes nested clients with their parent names.
  @@clientName(ContainerAppsSandbox, "SandboxGroupClient", "csharp");
  @@clientName(Sandboxes, "SandboxesClient", "csharp");
  @@clientName(Connections, "ConnectionsClient", "csharp");
  @@clientName(ContentPackages, "ContentPackagesClient", "csharp");
  @@clientName(Credentials, "CredentialsClient", "csharp");
  @@clientName(DiskImages, "DiskImagesClient", "csharp");
  @@clientName(PublicDiskImages, "PublicDiskImagesClient", "csharp");
  @@clientName(EgressPolicies, "EgressPoliciesClient", "csharp");
  @@clientName(Secrets, "SecretsClient", "csharp");
  @@clientName(Snapshots, "SnapshotsClient", "csharp");
  @@clientName(Volumes, "VolumesClient", "csharp");

  // Operation names
  @@clientName(AzureSandboxes.list, "getSandboxes", "csharp");
  @@clientName(AzureSandboxes.create, "createSandbox", "csharp");
  @@clientName(AzureSandboxes.get, "getProperties", "csharp");
  @@clientName(
    SandboxLifecycleOperations.getSandboxesCount,
    "getSandboxCount",
    "csharp"
  );
  @@clientName(
    SandboxLifecycleOperations.getSandboxStats,
    "getStats",
    "csharp"
  );
  @@clientName(
    SandboxLifecycleOperations.postSandboxDisable,
    "disable",
    "csharp"
  );
  @@clientName(
    SandboxLifecycleOperations.postSandboxEnable,
    "enable",
    "csharp"
  );
  @@clientName(
    SandboxLifecycleOperations.postSandboxExecuteCommand,
    "executeCommand",
    "csharp"
  );
  @@clientName(
    SandboxLifecycleOperations.postSandboxExecuteShellCommand,
    "executeShellCommand",
    "csharp"
  );
  @@clientName(
    SandboxLifecycleOperations.postSandboxLifecycle,
    "setLifecyclePolicy",
    "csharp"
  );
  @@clientName(
    SandboxLifecycleOperations.postSandboxResume,
    "resume",
    "csharp"
  );
  @@clientName(SandboxLifecycleOperations.postSandboxStop, "stop", "csharp");
  @@clientName(SandboxStorageOperations.postSandboxCommit, "commit", "csharp");
  @@clientName(
    SandboxStorageOperations.postSandboxDownloadContentPackage,
    "downloadContentPackage",
    "csharp"
  );
  @@clientName(
    SandboxStorageOperations.postSandboxPodVolumesAdd2,
    "addPodVolumeMounts",
    "csharp"
  );
  @@clientName(
    SandboxStorageOperations.postSandboxSnapshot,
    "createSnapshot",
    "csharp"
  );
  @@clientName(
    SandboxStorageOperations.postSandboxVolumeAdd,
    "addVolumeMount",
    "csharp"
  );
  @@clientName(
    SandboxFilesOperations.getSandboxFile,
    "downloadSandboxFile",
    "csharp"
  );
  @@clientName(
    SandboxFilesOperations.getSandboxFilesList,
    "getSandboxFilesMetadata",
    "csharp"
  );
  @@clientName(
    SandboxFilesOperations.getSandboxFileStat,
    "getSandboxFileMetadata",
    "csharp"
  );
  @@clientName(
    SandboxFilesOperations.postSandboxFileMkdir,
    "createSandboxDirectory",
    "csharp"
  );
  @@clientName(
    SandboxFilesOperations.postSandboxFile,
    "uploadSandboxFile",
    "csharp"
  );
  @@clientName(
    SandboxNetworkingOperations.getSandboxEgressDecisions,
    "getEgressDecisions",
    "csharp"
  );
  @@clientName(
    SandboxNetworkingOperations.getSandboxPorts,
    "getPorts",
    "csharp"
  );
  @@clientName(
    SandboxNetworkingOperations.patchSandboxPort,
    "updatePort",
    "csharp"
  );
  @@clientName(
    SandboxNetworkingOperations.postSandboxConnectionAdd,
    "addConnection",
    "csharp"
  );
  @@clientName(
    SandboxNetworkingOperations.postSandboxEgressPolicy,
    "setEgressPolicy",
    "csharp"
  );
  @@clientName(
    SandboxNetworkingOperations.postSandboxPortAdd,
    "addPort",
    "csharp"
  );
  @@clientName(
    SandboxNetworkingOperations.postSandboxPortRemove,
    "removePort",
    "csharp"
  );
  @@clientName(
    SandboxNetworkingOperations.putSandboxPorts,
    "setPorts",
    "csharp"
  );
  @@clientName(
    ConnectionsOperations.postConnection,
    "createConnection",
    "csharp"
  );
  @@clientName(
    ConnectionsOperations.postConnectionAuthorize,
    "authorizeConnection",
    "csharp"
  );
  @@clientName(
    ConnectionsOperations.postConnectionConsentLink,
    "generateConnectionConsentLink",
    "csharp"
  );
  @@clientName(
    ConnectionsOperations.postConnectionRefresh,
    "refreshConnection",
    "csharp"
  );
  @@clientName(
    ConnectionsOperations.putConnectionPolicyRules,
    "updateConnectionPolicyRules",
    "csharp"
  );
  @@clientName(
    ContentPackagesOperations.postContentPackageUpload,
    "uploadContentPackage",
    "csharp"
  );
  @@clientName(CredentialsOperations.putCredential, "setCredential", "csharp");
  @@clientName(
    DiskImagesOperations.listDiskImagesPublic,
    "getPublicDiskImages",
    "csharp"
  );
  @@clientName(
    DiskImagesOperations.getDiskImagePublic,
    "getPublicDiskImage",
    "csharp"
  );
  @@clientName(DiskImagesOperations.postDiskImage, "createDiskImage", "csharp");
  @@clientName(
    EgressPoliciesOperations.putEgressPolicy,
    "setEgressPolicy",
    "csharp"
  );
  @@clientName(SecretsOperations.postSecretPeek, "peekSecret", "csharp");
  @@clientName(SecretsOperations.putSecret, "setSecret", "csharp");
  @@clientName(
    SnapshotsOperations.getSnapshotsCount,
    "getSnapshotCount",
    "csharp"
  );
  @@clientName(VolumesOperations.getVolumesCount, "getVolumeCounts", "csharp");
  @@clientName(
    VolumesOperations.getVolumeFiles,
    "getVolumeFilesMetadata",
    "csharp"
  );
  @@clientName(
    VolumesOperations.getVolumeFileDownload,
    "downloadVolumeFile",
    "csharp"
  );
  @@clientName(
    VolumesOperations.postVolumeFileMkdir,
    "createVolumeDirectory",
    "csharp"
  );
  @@clientName(VolumesOperations.postVolumeFork, "forkVolume", "csharp");
  @@clientName(
    VolumesOperations.createOrReplaceVolumeFile,
    "uploadVolumeFile",
    "csharp"
  );
  @@alternateType(DiskImageStatus.state, ConnectionState, "csharp");
  @@alternateType(Connection.state, ConnectionState, "csharp");
  @@clientName(ConnectionState, "ResourceState", "csharp");

  // Model customizations
  @@alternateType(
    AzureBlobByoVolumeAuth,
    ContainerAppsSandboxClientModels.BlobVolumeAuthentication,
    "csharp"
  );
  @@alternateType(EgressPolicyHookRef.endpoint, url, "csharp");
  @@alternateType(VolumePathItem.eTag, Azure.Core.eTag, "csharp");
  @@alternateType(
    Sandbox.sandboxGroupId,
    Azure.Core.armResourceIdentifier,
    "csharp"
  );
  @@alternateType(
    CreateSandboxGatewayConnectionContent.resourceId,
    Azure.Core.armResourceIdentifier,
    "csharp"
  );
  @@alternateType(
    EgressPolicyManagedIdentityRef.identityResourceId,
    Azure.Core.armResourceIdentifier,
    "csharp"
  );

  // Model names
  // Qualify generic model names to avoid collisions with other libraries.
  @@clientName(Connection, "SandboxConnection", "csharp");
  @@clientName(Secret, "SandboxSecret", "csharp");
  @@clientName(Sandbox, "SandboxProperties", "csharp");
  @@clientName(Snapshot, "SandboxSnapshot", "csharp");
  @@clientName(FileInfo, "SandboxFileInfo", "csharp");
  @@clientName(MkDirContent, "SandboxDirectoryContent", "csharp");
  @@clientName(AddPodVolumeMountsContent, "PodVolumeMountsContent", "csharp");
  @@clientName(AddVolumeMountContent, "SandboxVolumeMountContent", "csharp");

  @@clientName(CreateDiskImageSource, "DiskImageSource", "csharp");
  @@clientName(CreateDiskImageSourceKind, "DiskImageSourceKind", "csharp");
  @@clientName(
    CreateDiskImageSourceBlobSource,
    "BlobDiskImageSource",
    "csharp"
  );
  @@clientName(
    CreateDiskImageSourceRegistrySource,
    "RegistryDiskImageSource",
    "csharp"
  );

  @@clientName(LogColumnDef, "TelemetryLogColumn", "csharp");
  @@clientName(LogColumnDefKind, "TelemetryLogColumnKind", "csharp");
  @@clientName(RefLogColumnDef, "ReferenceTelemetryLogColumn", "csharp");
  @@clientName(ValueLogColumnDef, "LiteralTelemetryLogColumn", "csharp");
  @@clientName(TelemetryAuth, "TelemetryAuthentication", "csharp");
  @@clientName(TelemetryAuthKind, "TelemetryAuthenticationKind", "csharp");
  @@clientName(
    TelemetryManagedIdentityAuth,
    "TelemetryManagedIdentityAuthentication",
    "csharp"
  );
  @@clientName(
    TelemetrySystemAssignedManagedIdentityAuth,
    "TelemetrySystemAssignedManagedIdentityAuthentication",
    "csharp"
  );
  @@clientName(
    TelemetryApplicationInsightsAuth,
    "TelemetryApplicationInsightsAuthentication",
    "csharp"
  );
  @@clientName(TelemetryHeaderAuth, "TelemetryHeaderAuthentication", "csharp");
  @@clientName(TelemetryConfig, "TelemetryConfiguration", "csharp");

  @@clientName(
    SandboxGroupIdentitySelectorSystemAssignedIdentitySelector,
    "SystemAssignedSandboxGroupIdentitySelector",
    "csharp"
  );
  @@clientName(
    SandboxGroupIdentitySelectorUserAssignedIdentitySelector,
    "UserAssignedSandboxGroupIdentitySelector",
    "csharp"
  );
  @@clientName(SandboxAutoSuspendPolicy.interval, "intervalSeconds", "csharp");
  @@clientName(DiskImageImage, "ImageMetadata", "csharp");

  // SandboxVolume already describes a volume mount; this model is the group-scoped resource.
  @@clientName(Volume, "SandboxGroupVolume", "csharp");

  @@clientName(AzureBlobByoPodVolume, "UserProvidedBlobPodVolume", "csharp");
  @@clientName(AzureBlobByoVolume, "UserProvidedBlobVolume", "csharp");
  @@clientName(AzureBlobPodVolume, "ServiceManagedBlobPodVolume", "csharp");
  @@clientName(AzureBlobVolume, "ServiceManagedBlobVolume", "csharp");

  // Name response bodies independently of their HTTP envelopes.
  @@clientName(
    GenerateConsentLinkResponse,
    "GenerateConsentLinkResult",
    "csharp"
  );
  @@clientName(DirListingResponse, "SandboxDirectoryListingResult", "csharp");
  @@clientName(FileOpStatusResponse, "SandboxFileOperationResult", "csharp");
  @@clientName(WriteFileResponse, "WriteFileResult", "csharp");
  @@clientName(ConnectionsListResponse, "ConnectionsListResult", "csharp");
  @@clientName(EgressDecisionsResponse, "EgressDecisionsResult", "csharp");
  @@clientName(PortsListResponse, "PortsListResult", "csharp");
  @@clientName(CommitSandboxResponse, "CommitSandboxResult", "csharp");
  @@clientName(
    SandboxExecuteCommandResponse,
    "SandboxExecuteCommandResult",
    "csharp"
  );
  @@clientName(
    SandboxExecuteShellCommandResponse,
    "SandboxExecuteShellCommandResult",
    "csharp"
  );
  @@clientName(SandboxStatsResponse, "SandboxStatsResult", "csharp");
  @@clientName(SecretKeysResponse, "SecretKeysResult", "csharp");
  @@clientName(SecretPeekResponse, "SecretPeekResult", "csharp");
  @@clientName(CreateSecretContent, "SetSecretContent", "csharp");
  @@clientName(CountResponse, "CountResult", "csharp");
  @@clientName(SandboxCountResponse, "SandboxCountResult", "csharp");
  @@clientName(SnapshotCountResponse, "SnapshotCountResult", "csharp");
  @@clientName(VolumeCountResponse, "VolumeCountResult", "csharp");
  @@clientName(
    VolumeListDirectoryResponse,
    "VolumeListDirectoryResult",
    "csharp"
  );

  // Property names
  @@clientName(Sandbox.cmd, "command", "csharp");
  @@clientName(CreateSandboxContent.cmd, "command", "csharp");
  @@clientName(DiskImageImage.cmd, "command", "csharp");
  @@clientName(DiskImageImage.base, "baseImage", "csharp");
  @@clientName(ContainerSpec.args, "arguments", "csharp");
  @@clientName(ExecuteSandboxCommandContent.args, "arguments", "csharp");
  @@clientName(ContainerSpec.env, "environment", "csharp");
  @@clientName(FileInfo.isDir, "isDirectory", "csharp");
  @@clientName(FileInfo.isSymlink, "isSymbolicLink", "csharp");
  @@clientName(FileInfo.symlinkTarget, "symbolicLinkTarget", "csharp");
  @@clientName(NetworkStats.rxBytes, "bytesReceived", "csharp");
  @@clientName(NetworkStats.txBytes, "bytesSent", "csharp");
  @@clientName(NetworkStats.rxPackets, "packetsReceived", "csharp");
  @@clientName(NetworkStats.txPackets, "packetsSent", "csharp");
  @@clientName(CpuStats.loadAvg1, "loadAverage1Minute", "csharp");
  @@clientName(CpuStats.loadAvg5, "loadAverage5Minutes", "csharp");
  @@clientName(CpuStats.loadAvg15, "loadAverage15Minutes", "csharp");
  @@clientName(
    SandboxExecuteCommandResponse.stdout,
    "standardOutput",
    "csharp"
  );
  @@clientName(SandboxExecuteCommandResponse.stderr, "standardError", "csharp");
  @@clientName(
    SandboxExecuteShellCommandResponse.stdout,
    "standardOutput",
    "csharp"
  );
  @@clientName(
    SandboxExecuteShellCommandResponse.stderr,
    "standardError",
    "csharp"
  );
  @@clientName(EgressForwardProxy.ca, "certificateAuthority", "csharp");
  @@clientName(
    IpAccessControlRule.sourceCidrs,
    "sourceAddressPrefixes",
    "csharp"
  );

  // Url -> Uri, matching .NET naming conventions.
  @@clientName(Sandbox.appUrl, "appUri", "csharp");
  @@clientName(Sandbox.managementUrl, "managementUri", "csharp");
  @@clientName(GatewayConnection.mcpRuntimeUrl, "mcpRuntimeUri", "csharp");
  @@clientName(
    GatewayConnection.connectionRuntimeUrl,
    "connectionRuntimeUri",
    "csharp"
  );
  @@clientName(GenerateConsentLinkContent.redirectUrl, "redirectUri", "csharp");

  // Container image references can include registry names and tags rather than absolute URIs.
  @@clientName(
    CreateDiskImageSourceRegistrySource.imageUrl,
    "imageReference",
    "csharp"
  );
}

@clientNamespace("Azure.Containers.Apps.Sandbox", "csharp")
namespace ContainerAppsSandboxClientModels {
  /** Authentication mechanisms for accessing a user-provided blob container. */
  union BlobVolumeAuthenticationKind {
    string,

    /** Uses a managed identity already assigned to the sandbox group. */
    ManagedIdentity: "ManagedIdentity",
  }

  /** Authentication configuration for accessing a user-provided blob container. */
  @discriminator("kind")
  model BlobVolumeAuthentication {
    /** The authentication mechanism. */
    kind: BlobVolumeAuthenticationKind;
  }

  /** Authenticates with a managed identity already assigned to the sandbox group. */
  model BlobVolumeManagedIdentityAuthentication
    extends BlobVolumeAuthentication {
    ...ContainerAppsSandbox.AzureBlobByoVolumeAuthAzureBlobByoIdentityAuth;
  }
}
