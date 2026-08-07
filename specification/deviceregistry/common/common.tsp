/** Common UX display properties shared across resources. */
model DisplayProperties {
  /** Human-readable description of the resource. */
  @maxLength(1024)
  description?: string;

  /** Human-readable display name for the resource. */
  @maxLength(256)
  displayName?: string;
}
