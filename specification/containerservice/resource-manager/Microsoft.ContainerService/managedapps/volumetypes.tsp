using Azure.ResourceManager;

namespace Microsoft.ContainerService;

/** Volume definition. Right now emptyDir,configmap,secret,persistentVolumeClaim */
model Volume {
  /** Name of the volume */
  name: string;

  /** EmptyDir volume */
  emptyDir?: EmptyDirVolume;

  /** ConfigMap volume */
  configMap?: ConfigMapVolume;

  /** Secret volume */
  secret?: SecretVolume;

  /** Persistent Volume Claim volume */
  persistentVolumeClaim?: PersistentVolumeClaimVolume;
}

/** Storage medium type for EmptyDir volume. */
union StorageMedium {
  /** Use default storage medium for the node */
  Default: "",

  /** Use memory (e.g. tmpfs on linux) */
  Memory: "Memory",

  /** Use hugepages */
  HugePages: "HugePages",

  string,
}

/** EmptyDir represents a temporary directory that shares a pod's lifetime. */
model EmptyDirVolume {
  /** What type of storage medium should back this directory. */
  medium?: StorageMedium;

  /** Total amount of local storage required for this EmptyDir volume. */
  sizeLimit?: string;
}

/** Adapts a ConfigMap into a volume. */
model ConfigMapVolume {
  /** Name of the ConfigMap. */
  name: string;

  /** Optional: mode bits used to set permissions on created files by default. */
  defaultMode?: int32;

  /** If unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file. */
  @identifiers(#["key"])
  items?: ConfigMapKeyToPath[];

  /** Specify whether the ConfigMap or its keys must be defined. */
  optional?: boolean;
}

/** Maps a string key to a path within a volume. */
model ConfigMapKeyToPath {
  /** The key to project. */
  key: string;

  /** The relative path of the file to map the key to. */
  path: string;

  /** Optional: mode bits used to set permissions on this file. */
  mode?: int32;
}

/** Adapts a Secret into a volume. */
model SecretVolume {
  /** Name of the secret. */
  secretName: string;

  /** Optional: mode bits used to set permissions on created files by default. */
  defaultMode?: int32;

  /** If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file. */
  @identifiers(#["key"])
  items?: SecretKeyToPath[];

  /** Specify whether the Secret or its keys must be defined. */
  optional?: boolean;
}

/** Maps a string key to a path within a volume. */
model SecretKeyToPath {
  /** The key to project. */
  key: string;

  /** The relative path of the file to map the key to. */
  path: string;

  /** Optional: mode bits used to set permissions on this file. */
  mode?: int32;
}

/** PersistentVolumeClaimVolume references a user's PVC in the same namespace. */
model PersistentVolumeClaimVolume {
  /** ClaimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume. */
  claimName: string;

  /** Will force the ReadOnly setting in VolumeMounts. */
  readOnly?: boolean;
}
