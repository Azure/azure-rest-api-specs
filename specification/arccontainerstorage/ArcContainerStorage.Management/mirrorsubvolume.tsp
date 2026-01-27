import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./edgevolume.tsp";
import "./backendconnectionstate.tsp";
import "./subvolumecommon.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ArcContainerStorage;

/**
 * MirrorSubvolume is a custom resource that defines configuration
 * for an mirror subvolume in the Arc Container Storage system.
 */
@doc("MirrorSubvolume is a custom resource that defines the configuration for a subvolume.")
@parentResource(EdgeVolume)
model MirrorSubvolume is ProxyResource<MirrorSubvolumeProperties> {
  ...ResourceNameParameter<
    MirrorSubvolume,
    NamePattern = "^[a-zA-Z0-9]([a-zA-Z0-9-_.]*[a-zA-Z0-9])?$"
  >;
}

/**
 * Defines the properties for the MirrorSubvolume resource.
 */
@doc("Defines the properties of the MirrorSubvolume resource.")
model MirrorSubvolumeProperties {
  @doc("Top-level path for this subvolume (e.g., /mysubvol).")
  @minLength(1)
  @maxLength(255)
  @pattern("^/?[a-zA-Z0-9-\\._]*$")
  path: string;

  @doc("Authentication config for certain subvolumes.")
  authentication: AuthConfig;

  @doc("Account used for mirror source")
  account: AccountConfig;

  @doc("Optional blob filtering configuration.")
  blobFiltering?: BlobFilteringConfig;

  @doc("Optional Unix-like ownership info (UID/GID) for the subvolume.")
  authSys?: AuthSysConfig;

  @doc("Schedule configuration for when mirroring should run.")
  schedule: ScheduleConfig;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.")
  @visibility(Lifecycle.Read)
  status?: MirrorSubvolumeStatus;
}

@doc("schedule configuration")
model ScheduleConfig {
  @doc("Options are: @annually, @yearly, @monthly, @weekly, @daily, @hourly, never, or cron syntax (five digits, first is minutes (0-59), second is hours (0-23), third is day (1-31), fourth is month (1-12), fifth is day of the week (0-6)).")
  @pattern("^(never|@(annually|yearly|monthly|weekly|daily|hourly)|((([*]|([1-5]?[0-9])([-]([1-5]?[0-9]))?)([/]([1-5]?[0-9]))?)) ((([*]|(1?[0-9]|2[0-3])([-](1?[0-9]|2[0-3]))?)([/](1?[0-9]|2[0-3]))?)) ((([*]|([1-2]?[0-9]|3[0-1])([-]([1-2]?[0-9]|3[0-1]))?)([/]([1-2][0-9]|3[0-1]))?)) (([*]|((1[0-2]|[0-9]|[jJ][aA][nN]|[jJ][aA][nN][uU][aA][rR][yY]|[fF][eE][bB]|[fF][eE][bB][rR][uU][aA][rR][yY]|[mM][aA][rR]|[mM][aA][rR][cC][hH]|[aA][pP][rR]|[aA][pP][rR][iI][lL]|[mM][aA][yY]|[jJ][uU][nN]|[jJ][uU][nN][eE]|[aA][uU][gG]|[aA][uU][gG][uU][sS][tT]|[sS][eE][pP]|[sS][eE][pP][tT]|[sS][eE][pP][tT][eE][mM][bB][eE][rR]|[oO][cC][tT]|[oO][cC][tT][oO][bB][eE][rR]|[nN][oO][vV]|[nN][oO][vV][eE][mM][bB][eE][rR]|[dD][eE][cC]|[dD][eE][cC][eE][mM][bB][eE][rR])([-](1[0-2]|[0-9]|[jJ][aA][nN]|[jJ][aA][nN][uU][aA][rR][yY]|[fF][eE][bB]|[fF][eE][bB][rR][uU][aA][rR][yY]|[mM][aA][rR]|[mM][aA][rR][cC][hH]|[aA][pP][rR]|[aA][pP][rR][iI][lL]|[mM][aA][yY]|[jJ][uU][nN]|[jJ][uU][nN][eE]|[aA][uU][gG]|[aA][uU][gG][uU][sS][tT]|[sS][eE][pP]|[sS][eE][pP][tT]|[sS][eE][pP][tT][eE][mM][bB][eE][rR]|[oO][cC][tT]|[oO][cC][tT][oO][bB][eE][rR]|[nN][oO][vV]|[nN][oO][vV][eE][mM][bB][eE][rR]|[dD][eE][cC]|[dD][eE][cC][eE][mM][bB][eE][rR]))?))([/](1[0-2]|[0-9]|[jJ][aA][nN]|[jJ][aA][nN][uU][aA][rR][yY]|[fF][eE][bB]|[fF][eE][bB][rR][uU][aA][rR][yY]|[mM][aA][rR]|[mM][aA][rR][cC][hH]|[aA][pP][rR]|[aA][pP][rR][iI][lL]|[mM][aA][yY]|[jJ][uU][nN]|[jJ][uU][nN][eE]|[aA][uU][gG]|[aA][uU][gG][uU][sS][tT]|[sS][eE][pP]|[sS][eE][pP][tT]|[sS][eE][pP][tT][eE][mM][bB][eE][rR]|[oO][cC][tT]|[oO][cC][tT][oO][bB][eE][rR]|[nN][oO][vV]|[nN][oO][vV][eE][mM][bB][eE][rR]|[dD][eE][cC]|[dD][eE][cC][eE][mM][bB][eE][rR]))??) (([*]|([0-6]|[mM][oO][nN]|[mM][oO][nN][dD][aA][yY]|[tT][uU][eE]|[tT][uU][eE][sS]|[tT][uU][eE][sS][dD][aA][yY]|[wW][eE][dD]|[wW][eE][dD][sS]|[wW][eE][dD][nN][eE][sS][dD][aA][yY]|[tT][hH][uU]|[tT][hH][uU][rR]|[tT][hH][uU][rR][sS]|[tT][hH][uU][rR][sS][dD][aA][yY]|[fF][rR][iI]|[fF][rR][iI][dD][aA][yY]|[sS][aA][tT]|[sS][aA][tT][uU][rR][dD][aA][yY]|[sS][uU][nN]|[sS][uU][nN][dD][aA][yY])([-][0-6]|[mM][oO][nN]|[mM][oO][nN][dD][aA][yY]|[tT][uU][eE]|[tT][uU][eE][sS]|[tT][uU][eE][sS][dD][aA][yY]|[wW][eE][dD]|[wW][eE][dD][sS]|[wW][eE][dD][nN][eE][sS][dD][aA][yY]|[tT][hH][uU]|[tT][hH][uU][rR]|[tT][hH][uU][rR][sS]|[tT][hH][uU][rR][sS][dD][aA][yY]|[fF][rR][iI]|[fF][rR][iI][dD][aA][yY]|[sS][aA][tT]|[sS][aA][tT][uU][rR][dD][aA][yY]|[sS][uU][nN]|[sS][uU][nN][dD][aA][yY])?)([/]([0-6]|[mM][oO][nN]|[mM][oO][nN][dD][aA][yY]|[tT][uU][eE]|[tT][uU][eE][sS]|[tT][uU][eE][sS][dD][aA][yY]|[wW][eE][dD]|[wW][eE][dD][sS]|[wW][eE][dD][nN][eE][sS][dD][aA][yY]|[tT][hH][uU]|[tT][hH][uU][rR]|[tT][hH][uU][rR][sS]|[tT][hH][uU][rR][sS][dD][aA][yY]|[fF][rR][iI]|[fF][rR][iI][dD][aA][yY]|[sS][aA][tT]|[sS][aA][tT][uU][rR][dD][aA][yY]|[sS][uU][nN]|[sS][uU][nN][dD][aA][yY]))??))$")
  frequency: string;

  @doc("By default, left blank. If at any time a uuid is specified here, it triggers an 'immediate' sync. If a uuid is specified on creation, the subvolume performs a sync on initial create, and thereafter according to the frequency. If this parameter is empty on creation, the subvolume initially creates without a sync, and then syncs according to the frequency.")
  oneshot?: UUIDType;
}

@doc("A scheme for filtering blobs to mirror")
model BlobFilteringConfig {
  @doc("Use a prefix for filtering. For example, if the value is 'a' it only mirrors blobs with names starting with a.")
  @maxLength(255)
  @pattern(
    "(^(?!.*[/][/]).*[^.]$|^$)",
    "must not contain '//' and must not end with '.'"
  )
  blobNamePrefix?: string;
}

@doc("A storage account configuration type used for mirroring")
union AccountConfigType {
  blob: "blob",
  onelake: "onelake",
  string,
}

@doc("A storage account used for mirroring")
@discriminator("accountType")
model AccountConfig {
  accountType: AccountConfigType;
}

@doc("possible values for indextags")
union IndexTagsModes {
  @doc("use mirror")
  mirrorIndexTags: "MirrorIndexTags",

  @doc("no tags used")
  noIndexTags: "NoIndexTags",

  string,
}

@doc("a blob account used for mirroring")
model BlobAccountConfig extends AccountConfig {
  accountType: "blob";

  @doc("Blob storage endpoint, for example: https://mysa.core.windows.net")
  @minLength(3)
  @maxLength(1024)
  accountEndpoint: string;

  @doc("Blob container name.")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-z0-9]([a-z0-9]|-[a-z0-9])*$")
  containerName: string;

  @doc("Mode MirrorIndexTags requires higher permissions. When set index tags will be translated to corresponding azindex.<name> xattrs. NoIndexTags will keep index tag xattrs unset.")
  indexTagsMode?: IndexTagsModes = IndexTagsModes.noIndexTags;
}

@doc("A onelake account used for mirroring")
model OnelakeAccountConfig extends AccountConfig {
  accountType: "onelake";

  @doc("Onelake endpoint, for example: https://onelake.blob.fabric.microsoft.com")
  @minLength(3)
  @maxLength(1024)
  accountEndpoint: string;

  // The seemingly excessive \\ noise here is required to ensure that the generated SDKs will use escaped values.
  // For example, otherwise [\\/] would become \/ in the generated python SDK which is not the intended pattern.
  // Similarly, double backslashes are needed to ensure \\t\\n\\r become \t\n\r respectively.
  @doc("Blob container name.")
  @pattern("^[^\\t\\n\\r\\\\/ #]*[/]([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|[A-Za-z0-9_]*[.]lakehouse)$")
  containerName: string;
}

/**
 * Defines the observed status of the MirrorSubvolume resource.
 */
@doc("Defines the observed status of the MirrorSubvolume resource.")
model MirrorSubvolumeStatus {
  @doc("The current state of the subvolume.")
  state?: MirrorSubvolumeState;
}

@doc("States of an MirrorSubvolume")
union MirrorSubvolumeState {
  @doc("MirrorSubvolume is in an unknown state")
  Unknown: "unknown",

  @doc("MirrorSubvolume configuration is in progress")
  Configuring: "configuring",

  @doc("MirrorSubvolume is configured and ready")
  Configured: "configured",

  @doc("MirrorSubvolume is being deleted")
  CleaningUp: "cleaning_up",

  string,
}

/**
 * Resource operations for the MirrorSubvolume resource.
 */
@armResourceOperations
interface MirrorSubvolumes {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MirrorSubvolume>;
  delete is ArmResourceDeleteWithoutOkAsync<MirrorSubvolume>;
  get is ArmResourceRead<MirrorSubvolume>;
  list is ArmResourceListByParent<MirrorSubvolume>;
  update is ArmResourcePatchAsync<MirrorSubvolume, MirrorSubvolumeProperties>;
}
