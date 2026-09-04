#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Response identifies a JSON response body; Result is reserved for HTTP response envelopes."
namespace ContainerAppsSandbox {
  /** Directory-listing response body. */
  model DirListingResponse {
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

  /** File-operation response body. */
  model FileOpStatusResponse {
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

  /** Write-file response body. */
  model WriteFileResponse {
    /** success value. */
    success: boolean;

    /** error value. */
    error?: string;

    /** bytesWritten value. */
    bytesWritten?: int64;
  }
}
