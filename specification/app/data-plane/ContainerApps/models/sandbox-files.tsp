namespace ContainerAppsSandbox {
  /** DirListingResult wire model. */
  model DirListingResult {
    /** path value. */
    path: string;

    /** entries value. */
    entries: FileInfo[];
  }

  /** FileInfo wire model. */
  model FileInfo {
    /** name value. */
    name: string;

    /** path value. */
    path: string;

    /** size value. */
    size: int64;

    /** mode value. */
    mode: int32;

    /** isDir value. */
    isDir: boolean;

    /** isSymlink value. */
    isSymlink: boolean;

    /** symlinkTarget value. */
    symlinkTarget: string;

    /** modifiedTime value. */
    modifiedTime: int64;
  }

  /** FileOpStatusResult wire model. */
  model FileOpStatusResult {
    /** success value. */
    success: boolean;

    /** error value. */
    error?: string;

    /** message value. */
    message?: string;
  }

  /** MkDirContent wire model. */
  model MkDirContent {
    /** path value. */
    path: string;

    /** createParents value. */
    createParents?: boolean;

    /** mode value. */
    mode?: int32;
  }

  /** WriteFileResult wire model. */
  model WriteFileResult {
    /** success value. */
    success: boolean;

    /** error value. */
    error?: string;

    /** bytesWritten value. */
    bytesWritten?: int64;
  }
}
