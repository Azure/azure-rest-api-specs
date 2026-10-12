namespace ContainerAppsSandbox {
  /** Files and directories returned for a directory listing. */
  model DirListingResponse {
    /** The directory path that was listed. */
    path: string;

    /** Files and directories contained in the path. */
    entries: FileInfo[];
  }

  /** Metadata for a file or directory in a sandbox. */
  model FileInfo {
    /** The file or directory name. */
    name: string;

    /** The full path in the sandbox. */
    path: string;

    /** The size in bytes. */
    size: int64;

    /** The Unix file mode. */
    mode: int32;

    /** Whether the path is a directory. */
    isDir: boolean;

    /** Whether the path is a symbolic link. */
    isSymlink: boolean;

    /** The symbolic link target, when applicable. */
    symlinkTarget: string;

    /** The last modification time as a Unix timestamp. */
    modifiedTime: int64;
  }

  /** Result of a sandbox file operation. */
  model FileOpStatusResponse {
    /** Whether the file operation succeeded. */
    success: boolean;

    /** The error message when the operation failed. */
    error?: string;

    /** Additional information about the operation. */
    message?: string;
  }

  /** Options for creating a directory in a sandbox. */
  model MkDirContent {
    /** The directory path to create. */
    path: string;

    /** Whether to create missing parent directories. */
    createParents?: boolean;

    /** The Unix mode for the new directory. */
    mode?: int32;
  }

  /** Result of writing a sandbox file. */
  model WriteFileResponse {
    /** Whether the file was written successfully. */
    success: boolean;

    /** The error message when the write failed. */
    error?: string;

    /** The number of bytes written. */
    bytesWritten?: int64;
  }
}
