const STATUS_LABELS = {
  passed: "Met",
  failed: "Failed",
  "action-required": "Action required",
  "awaiting-review": "Awaiting review",
  running: "Running",
  pending: "Pending",
  warning: "Warning",
};

export type CommentStatus = keyof typeof STATUS_LABELS;

/** Keeps the decorative icon unlinked, including GitHub's automatic image-preview link. */
export function statusBadge(status: CommentStatus, label = STATUS_LABELS[status]): string {
  const url = `https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/.github/assets/merge-status/${status}.svg`;
  const text =
    status === "warning"
      ? `<span title="Needs attention, but does not block automated merge requirements.">${label}</span>`
      : label;
  return `<picture><img src="${url}" width="18" height="18" align="absmiddle" alt=""></picture> ${text}`;
}
