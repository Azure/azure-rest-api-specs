namespace AzureDevCompute {
  /** DirListingResponse wire model. */
  model DirListingResponse {
    /** path value. */
    path: string;

    /** entries value. */
    entries: FileInfoResponse[];
  }

  /** FileInfoResponse wire model. */
  model FileInfoResponse {
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

  /** FileOpStatusResponse wire model. */
  model FileOpStatusResponse {
    /** success value. */
    success: boolean;

    /** error value. */
    error?: string;

    /** message value. */
    message?: string;
  }

  /** MkDirRequest wire model. */
  model MkDirRequest {
    /** path value. */
    path: string;

    /** createParents value. */
    createParents?: boolean;

    /** mode value. */
    mode?: int32;
  }

  /** WriteFileResponse wire model. */
  model WriteFileResponse {
    /** success value. */
    success: boolean;

    /** error value. */
    error?: string;

    /** bytesWritten value. */
    bytesWritten?: int64;
  }
}
