import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace ContainerAppsSandbox {
  // Client hierarchy
  // These namespaces declare no REST operations. C#-only placement decorators below
  // populate the clients without changing the service interfaces or other languages.
  /** Operations within one sandbox group. */
  namespace Group {
    /** Operations on one sandbox within the group. */
    namespace Resource {
      namespace Files {

      }

      namespace Networking {

      }

      namespace Streams {

      }
    }

    namespace Connections {

    }

    namespace ContentPackages {

    }

    namespace Credentials {

    }

    namespace DiskImages {

    }

    namespace EgressPolicies {

    }

    namespace Secrets {

    }

    namespace Snapshots {

    }

    namespace Volumes {

    }
  }

  // Client initialization
  @@clientInitialization(
    Group,
    {
      parameters: AzureResourceScope,
      initializedBy: InitializedBy.parent,
    },
    "csharp"
  );
  @@clientInitialization(
    Group.Resource,
    {
      parameters: {
        ...AzureResourceScope,

        /** Sandbox identifier. */
        id: string,
      },
      initializedBy: InitializedBy.parent,
    },
    "csharp"
  );

  // Operation locations
  // Collection operations do not require an individual sandbox.
  @@clientLocation(AzureSandboxes.list, Group, "csharp");
  @@clientLocation(AzureSandboxes.create, Group, "csharp");
  @@clientLocation(
    SandboxLifecycleOperations.getSandboxesCount,
    Group,
    "csharp"
  );
  // Resource operations share the sandbox identifier captured by the parent factory.
  @@clientLocation(AzureSandboxes.get, Group.Resource, "csharp");
  @@clientLocation(AzureSandboxes.delete, Group.Resource, "csharp");
  @@clientLocation(
    SandboxLifecycleOperations.getSandboxStats,
    Group.Resource,
    "csharp"
  );
  @@clientLocation(
    SandboxLifecycleOperations.postSandboxDisable,
    Group.Resource,
    "csharp"
  );
  @@clientLocation(
    SandboxLifecycleOperations.postSandboxEnable,
    Group.Resource,
    "csharp"
  );
  @@clientLocation(
    SandboxLifecycleOperations.postSandboxExecuteCommand,
    Group.Resource,
    "csharp"
  );
  @@clientLocation(
    SandboxLifecycleOperations.postSandboxExecuteShellCommand,
    Group.Resource,
    "csharp"
  );
  @@clientLocation(
    SandboxLifecycleOperations.postSandboxLifecycle,
    Group.Resource,
    "csharp"
  );
  @@clientLocation(
    SandboxLifecycleOperations.postSandboxResume,
    Group.Resource,
    "csharp"
  );
  @@clientLocation(
    SandboxLifecycleOperations.postSandboxStop,
    Group.Resource,
    "csharp"
  );
  @@clientLocation(
    SandboxStorageOperations.postSandboxCommit,
    Group.Resource,
    "csharp"
  );
  @@clientLocation(
    SandboxStorageOperations.postSandboxDownloadContentPackage,
    Group.Resource,
    "csharp"
  );
  @@clientLocation(
    SandboxStorageOperations.postSandboxPodVolumesAdd2,
    Group.Resource,
    "csharp"
  );
  @@clientLocation(
    SandboxStorageOperations.postSandboxSnapshot,
    Group.Resource,
    "csharp"
  );
  @@clientLocation(
    SandboxStorageOperations.postSandboxVolumeAdd,
    Group.Resource,
    "csharp"
  );
  @@clientLocation(
    SandboxFilesOperations.deleteSandboxFile,
    Group.Resource.Files,
    "csharp"
  );
  @@clientLocation(
    SandboxFilesOperations.getSandboxFile,
    Group.Resource.Files,
    "csharp"
  );
  @@clientLocation(
    SandboxFilesOperations.getSandboxFilesList,
    Group.Resource.Files,
    "csharp"
  );
  @@clientLocation(
    SandboxFilesOperations.getSandboxFileStat,
    Group.Resource.Files,
    "csharp"
  );
  @@clientLocation(
    SandboxFilesOperations.postSandboxFileMkdir,
    Group.Resource.Files,
    "csharp"
  );
  @@clientLocation(
    SandboxFilesOperations.postSandboxFile,
    Group.Resource.Files,
    "csharp"
  );

  @@clientLocation(
    SandboxNetworkingOperations.getSandboxEgressDecisions2,
    Group.Resource.Networking,
    "csharp"
  );
  @@clientLocation(
    SandboxNetworkingOperations.getSandboxPorts,
    Group.Resource.Networking,
    "csharp"
  );
  @@clientLocation(
    SandboxNetworkingOperations.patchSandboxPort,
    Group.Resource.Networking,
    "csharp"
  );
  @@clientLocation(
    SandboxNetworkingOperations.postSandboxConnectionAdd,
    Group.Resource.Networking,
    "csharp"
  );
  @@clientLocation(
    SandboxNetworkingOperations.postSandboxEgressPolicy,
    Group.Resource.Networking,
    "csharp"
  );
  @@clientLocation(
    SandboxNetworkingOperations.postSandboxPortAdd,
    Group.Resource.Networking,
    "csharp"
  );
  @@clientLocation(
    SandboxNetworkingOperations.postSandboxPortRemove,
    Group.Resource.Networking,
    "csharp"
  );
  @@clientLocation(
    SandboxNetworkingOperations.putSandboxPorts,
    Group.Resource.Networking,
    "csharp"
  );

  @@clientLocation(
    SandboxStreamsOperations.getSandboxExecStream,
    Group.Resource.Streams,
    "csharp"
  );
  @@clientLocation(
    SandboxStreamsOperations.getSandboxLogStream,
    Group.Resource.Streams,
    "csharp"
  );
  @@clientLocation(
    SandboxStreamsOperations.getSandboxProcessesStream,
    Group.Resource.Streams,
    "csharp"
  );

  // Supporting resources remain scoped to the sandbox group, not one sandbox.
  @@clientLocation(
    ConnectionsOperations.deleteConnection,
    Group.Connections,
    "csharp"
  );
  @@clientLocation(
    ConnectionsOperations.listConnections,
    Group.Connections,
    "csharp"
  );
  @@clientLocation(
    ConnectionsOperations.getConnection,
    Group.Connections,
    "csharp"
  );
  @@clientLocation(
    ConnectionsOperations.postConnection,
    Group.Connections,
    "csharp"
  );
  @@clientLocation(
    ConnectionsOperations.postConnectionAuthorize,
    Group.Connections,
    "csharp"
  );
  @@clientLocation(
    ConnectionsOperations.postConnectionConsentLink,
    Group.Connections,
    "csharp"
  );
  @@clientLocation(
    ConnectionsOperations.postConnectionRefresh,
    Group.Connections,
    "csharp"
  );
  @@clientLocation(
    ConnectionsOperations.putConnectionPolicyRules,
    Group.Connections,
    "csharp"
  );

  @@clientLocation(
    ContentPackagesOperations.deleteContentPackage,
    Group.ContentPackages,
    "csharp"
  );
  @@clientLocation(
    ContentPackagesOperations.listContentPackages,
    Group.ContentPackages,
    "csharp"
  );
  @@clientLocation(
    ContentPackagesOperations.getContentPackage,
    Group.ContentPackages,
    "csharp"
  );
  @@clientLocation(
    ContentPackagesOperations.postContentPackageUpload,
    Group.ContentPackages,
    "csharp"
  );

  @@clientLocation(
    CredentialsOperations.deleteCredential,
    Group.Credentials,
    "csharp"
  );
  @@clientLocation(
    CredentialsOperations.listCredentials,
    Group.Credentials,
    "csharp"
  );
  @@clientLocation(
    CredentialsOperations.getCredential,
    Group.Credentials,
    "csharp"
  );
  @@clientLocation(
    CredentialsOperations.putCredential,
    Group.Credentials,
    "csharp"
  );

  @@clientLocation(
    DiskImagesOperations.deleteDiskImage,
    Group.DiskImages,
    "csharp"
  );
  @@clientLocation(
    DiskImagesOperations.listDiskImages,
    Group.DiskImages,
    "csharp"
  );
  @@clientLocation(
    DiskImagesOperations.listDiskImagesPublic,
    Group.DiskImages,
    "csharp"
  );
  @@clientLocation(
    DiskImagesOperations.getDiskImagePublic,
    Group.DiskImages,
    "csharp"
  );
  @@clientLocation(
    DiskImagesOperations.getDiskImage,
    Group.DiskImages,
    "csharp"
  );
  @@clientLocation(
    DiskImagesOperations.postDiskImage,
    Group.DiskImages,
    "csharp"
  );

  @@clientLocation(
    EgressPoliciesOperations.deleteEgressPolicy,
    Group.EgressPolicies,
    "csharp"
  );
  @@clientLocation(
    EgressPoliciesOperations.listEgressPolicies,
    Group.EgressPolicies,
    "csharp"
  );
  @@clientLocation(
    EgressPoliciesOperations.getEgressPolicy,
    Group.EgressPolicies,
    "csharp"
  );
  @@clientLocation(
    EgressPoliciesOperations.putEgressPolicy,
    Group.EgressPolicies,
    "csharp"
  );

  @@clientLocation(SecretsOperations.deleteSecret, Group.Secrets, "csharp");
  @@clientLocation(SecretsOperations.getSecrets, Group.Secrets, "csharp");
  @@clientLocation(SecretsOperations.getSecretKeys, Group.Secrets, "csharp");
  @@clientLocation(SecretsOperations.postSecretPeek, Group.Secrets, "csharp");
  @@clientLocation(SecretsOperations.putSecret, Group.Secrets, "csharp");

  @@clientLocation(
    SnapshotsOperations.deleteSnapshot,
    Group.Snapshots,
    "csharp"
  );
  @@clientLocation(
    SnapshotsOperations.listSnapshots,
    Group.Snapshots,
    "csharp"
  );
  @@clientLocation(
    SnapshotsOperations.getSnapshotsCount,
    Group.Snapshots,
    "csharp"
  );
  @@clientLocation(SnapshotsOperations.getSnapshot, Group.Snapshots, "csharp");

  @@clientLocation(VolumesOperations.deleteVolume, Group.Volumes, "csharp");
  @@clientLocation(VolumesOperations.deleteVolumeFile, Group.Volumes, "csharp");
  @@clientLocation(VolumesOperations.listVolumes, Group.Volumes, "csharp");
  @@clientLocation(VolumesOperations.getVolumesCount, Group.Volumes, "csharp");
  @@clientLocation(VolumesOperations.getVolume, Group.Volumes, "csharp");
  @@clientLocation(VolumesOperations.getVolumeFiles, Group.Volumes, "csharp");
  @@clientLocation(
    VolumesOperations.getVolumeFileDownload,
    Group.Volumes,
    "csharp"
  );
  @@clientLocation(
    VolumesOperations.postVolumeFileMkdir,
    Group.Volumes,
    "csharp"
  );
  @@clientLocation(VolumesOperations.postVolumeFork, Group.Volumes, "csharp");
  @@clientLocation(VolumesOperations.putVolume, Group.Volumes, "csharp");
  @@clientLocation(VolumesOperations.postVolumeFile, Group.Volumes, "csharp");

  // Client names
  // The C# emitter prefixes nested clients with their parent names.
  @@clientName(Group, "SandboxGroup", "csharp");
  @@clientName(Group.Resource, "Sandbox", "csharp");
  @@clientName(Group.Resource.Files, "Files", "csharp");
  @@clientName(Group.Resource.Networking, "Networking", "csharp");
  @@clientName(Group.Resource.Streams, "Streams", "csharp");
  @@clientName(Group.Connections, "Connections", "csharp");
  @@clientName(Group.ContentPackages, "ContentPackages", "csharp");
  @@clientName(Group.Credentials, "Credentials", "csharp");
  @@clientName(Group.DiskImages, "DiskImages", "csharp");
  @@clientName(Group.EgressPolicies, "EgressPolicies", "csharp");
  @@clientName(Group.Secrets, "Secrets", "csharp");
  @@clientName(Group.Snapshots, "Snapshots", "csharp");
  @@clientName(Group.Volumes, "Volumes", "csharp");

  // Operation names
  @@clientName(AzureSandboxes.list, "getSandboxes", "csharp");
  @@clientName(AzureSandboxes.create, "createSandbox", "csharp");
  @@clientName(AzureSandboxes.get, "getProperties", "csharp");
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

  // Model names
  // Qualify generic model names to avoid collisions with other libraries.
  @@clientName(Connection, "SandboxConnection", "csharp");
  @@clientName(Secret, "SandboxSecret", "csharp");
  @@clientName(Sandbox, "ContainerAppsSandbox", "csharp");
  @@clientName(Snapshot, "SandboxSnapshot", "csharp");

  // SandboxVolume already describes a volume mount; this model is the group-scoped resource.
  @@clientName(Volume, "SandboxGroupVolume", "csharp");

  // Name response bodies independently of their HTTP envelopes.
  @@clientName(
    GenerateConsentLinkResponse,
    "GenerateConsentLinkResult",
    "csharp"
  );
  @@clientName(
    ContentPackageListResponse,
    "ContentPackageListResult",
    "csharp"
  );
  @@clientName(
    NamedEgressPolicyListResponse,
    "NamedEgressPolicyListResult",
    "csharp"
  );
  @@clientName(DirListingResponse, "DirListingResult", "csharp");
  @@clientName(FileOpStatusResponse, "FileOpStatusResult", "csharp");
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
  @@clientName(SecretListResponse, "SecretListResult", "csharp");
  @@clientName(SecretPeekResponse, "SecretPeekResult", "csharp");
  @@clientName(VolumeCountResponse, "VolumeCountResult", "csharp");
  @@clientName(
    VolumeListDirectoryResponse,
    "VolumeListDirectoryResult",
    "csharp"
  );

  // Property names
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
