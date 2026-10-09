import { readFile } from "node:fs/promises";
import { join } from "node:path";
import yaml from "js-yaml";

export const ALLOWED_BOT_LOGINS = ["github-actions[bot]", "azure-sdk"];
export const UNPROTECTED_PLANE = "unprotected";

export type PackageNamePlane = "data-plane" | "management-plane";
export type PackageNamePlaneApprovers = string[] | typeof UNPROTECTED_PLANE;

export type PackageNameLabelPolicy =
  | string[]
  | {
      "data-plane"?: PackageNamePlaneApprovers;
      "management-plane"?: PackageNamePlaneApprovers;
    };

export type PackageNamePolicy = {
  globalApprovers: string[];
  labels: Record<string, PackageNameLabelPolicy>;
  tier1: {
    "data-plane"?: string[];
    "management-plane"?: string[];
  };
};

export type PackageNameAuthorization = {
  status: "authorized" | "trusted-bot" | "unauthorized" | "unprotected" | "plane-unprotected";
  authorizedUsers: string[];
};

const isRecord = (value: unknown): value is Record<string, unknown> =>
  value !== null && typeof value === "object" && !Array.isArray(value);

const isNonEmptyStringArray = (value: unknown): value is string[] =>
  Array.isArray(value) && value.every((item) => typeof item === "string" && item.length > 0);

const isPackageNameApprovalLabel = (label: string): boolean =>
  label === "package-name-approved-all" || /^package-name-\w+-approved$/.test(label);

const usesTeamPolicy = (value: unknown): boolean =>
  isRecord(value) &&
  (Object.hasOwn(value, "team") || Object.hasOwn(value, "teams") || Object.hasOwn(value, "users"));

const unsupportedTeamPolicy = (label: string): Error =>
  new Error(
    `Unsupported package-name policy: "${label}" uses team approvers, but package-name approval only supports login lists while it runs in GitHub Actions`,
  );

const parsePlaneValue = (
  label: string,
  plane: PackageNamePlane,
  value: unknown,
): PackageNamePlaneApprovers | undefined => {
  if (value === undefined) return undefined;
  if (usesTeamPolicy(value)) throw unsupportedTeamPolicy(label);
  if (value === UNPROTECTED_PLANE || isNonEmptyStringArray(value)) return value;

  throw new Error(
    `Invalid protected-labels.yml: "${label}.${plane}" must be an array of non-empty logins or the literal "${UNPROTECTED_PLANE}"`,
  );
};

const parseLabelPolicy = (label: string, value: unknown): PackageNameLabelPolicy => {
  if (isNonEmptyStringArray(value)) return value;
  if (usesTeamPolicy(value)) throw unsupportedTeamPolicy(label);
  if (!isRecord(value)) {
    throw new Error(
      `Invalid protected-labels.yml: "${label}" must map to an array or a plane-aware object`,
    );
  }

  const managementPlane = parsePlaneValue(label, "management-plane", value["management-plane"]);
  const dataPlane = parsePlaneValue(label, "data-plane", value["data-plane"]);
  if (managementPlane === undefined && dataPlane === undefined) {
    throw new Error(
      `Invalid protected-labels.yml: "${label}" must define "management-plane" and/or "data-plane"`,
    );
  }

  return {
    ...(managementPlane === undefined ? {} : { "management-plane": managementPlane }),
    ...(dataPlane === undefined ? {} : { "data-plane": dataPlane }),
  };
};

const parseTier1 = (
  value: unknown,
): {
  "data-plane"?: string[];
  "management-plane"?: string[];
} => {
  if (value === undefined) return {};
  if (!isRecord(value)) {
    throw new Error(`Invalid protected-labels.yml: "tier1" must map to a plane-aware object`);
  }

  const managementPlane = value["management-plane"];
  const dataPlane = value["data-plane"];
  if (
    (managementPlane !== undefined && !isNonEmptyStringArray(managementPlane)) ||
    (dataPlane !== undefined && !isNonEmptyStringArray(dataPlane)) ||
    (managementPlane === undefined && dataPlane === undefined)
  ) {
    throw new Error(
      `Invalid protected-labels.yml: "tier1" must define "management-plane" and/or "data-plane" as arrays of non-empty language names`,
    );
  }

  return {
    ...(managementPlane === undefined ? {} : { "management-plane": managementPlane }),
    ...(dataPlane === undefined ? {} : { "data-plane": dataPlane }),
  };
};

export const parsePackageNamePolicy = (raw: unknown): PackageNamePolicy => {
  if (!isRecord(raw)) {
    throw new Error("Invalid protected-labels.yml: expected a YAML object");
  }

  const globalApprovers = raw["global-approvers"] ?? [];
  if (!isNonEmptyStringArray(globalApprovers)) {
    throw new Error(
      `Invalid protected-labels.yml: "global-approvers" must map to an array of non-empty strings`,
    );
  }

  const labels: Record<string, PackageNameLabelPolicy> = {};
  for (const [label, value] of Object.entries(raw)) {
    if (!isPackageNameApprovalLabel(label)) continue;
    labels[label] = parseLabelPolicy(label, value);
  }

  return {
    globalApprovers,
    labels,
    tier1: parseTier1(raw["tier1"]),
  };
};

export const loadPackageNamePolicy = async (
  path: string = join(process.cwd(), ".github", "protected-labels.yml"),
): Promise<PackageNamePolicy> => {
  const content = await readFile(path, "utf8");
  return parsePackageNamePolicy(yaml.load(content));
};

export const evaluatePackageNameAuthorization = ({
  policy,
  labelName,
  actor,
  plane,
}: {
  policy: PackageNamePolicy;
  labelName: string;
  actor: string;
  plane: PackageNamePlane;
}): PackageNameAuthorization => {
  if (ALLOWED_BOT_LOGINS.includes(actor)) {
    return { status: "trusted-bot", authorizedUsers: [] };
  }

  const entry = policy.labels[labelName];
  if (!entry) {
    return { status: "unprotected", authorizedUsers: [] };
  }

  const perLabelUsers = Array.isArray(entry) ? entry : (entry[plane] ?? []);
  if (perLabelUsers === UNPROTECTED_PLANE) {
    return { status: "plane-unprotected", authorizedUsers: [] };
  }

  const authorizedUsers = [...new Set([...perLabelUsers, ...policy.globalApprovers])];
  const actorLower = actor.toLowerCase();
  return {
    status: authorizedUsers.some((user) => user.toLowerCase() === actorLower)
      ? "authorized"
      : "unauthorized",
    authorizedUsers,
  };
};
