export type LabelAuthorization = {
  status: "authorized" | "trusted-bot" | "unauthorized" | "unprotected" | "plane-unprotected";
  authorizedUsers: string[];
};

export function evaluateLabelAuthorization({
  actor,
  approvers,
  globalApprovers = [],
  trustedBots = [],
}: {
  actor: string;
  approvers: readonly string[] | "unprotected" | undefined;
  globalApprovers?: readonly string[];
  trustedBots?: readonly string[];
}): LabelAuthorization {
  if (trustedBots.includes(actor)) {
    return { status: "trusted-bot", authorizedUsers: [] };
  }

  // Missing policy must not be treated as an explicitly unprotected plane.
  if (approvers === undefined) {
    return { status: "unprotected", authorizedUsers: [] };
  }
  if (approvers === "unprotected") {
    return { status: "plane-unprotected", authorizedUsers: [] };
  }

  const authorizedUsers = [...new Set([...approvers, ...globalApprovers])];
  const actorLower = actor.toLowerCase();
  return {
    status: authorizedUsers.some((user) => user.toLowerCase() === actorLower)
      ? "authorized"
      : "unauthorized",
    authorizedUsers,
  };
}
