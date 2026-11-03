const STATUS_LABELS = {
  passed: "Met",
  failed: "Failed",
  "action-required": "Action required",
  "awaiting-review": "Awaiting review",
  running: "Running",
  pending: "Pending",
  warning: "Non-blocking",
};

export type CommentStatus = keyof typeof STATUS_LABELS;

/** Renders a decorative icon beside a trusted, readable status label. */
export function statusBadge(status: CommentStatus, label = STATUS_LABELS[status]): string {
  const url = `https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/.github/assets/merge-status/${status}.svg`;
  return `<img src="${url}" width="18" height="18" align="absmiddle" alt=""> ${label}`;
}
