import { describe, expect, it } from "vitest";
import {
  buildApprovalResetComment,
  buildUnauthorizedApplyComment,
} from "../../src/protected-labels/label-comments.ts";

describe("buildUnauthorizedApplyComment (#46787)", () => {
  it("names the actor, label, and allowed approvers", () => {
    const body = buildUnauthorizedApplyComment({
      actor: "random-user",
      labelName: "package-name-java-approved",
      authorizedUsers: ["approver1", "global-admin"],
    });

    expect(body).toContain(
      "⚠️ @random-user is not authorized to apply `package-name-java-approved`. Label removed.",
    );
    expect(body).toContain("[review and merge process](https://aka.ms/azsdk/specreview/merge)");
    expect(body).toContain("<details><summary>See allowed approvers</summary>");
    expect(body).toContain("[approver1](https://github.com/approver1)");
    expect(body).toContain("[global-admin](https://github.com/global-admin)");
  });

  it("matches the protected-labels wording byte-for-byte (single source of truth)", () => {
    // This is the exact body protected-labels/check-label asserts in its tests. Keeping it
    // identical here guarantees both enforcement paths speak with one voice (#46787).
    const body = buildUnauthorizedApplyComment({
      actor: "unauthorized-user",
      labelName: "BreakingChange-Approved-Benign",
      authorizedUsers: ["user1", "user2", "global-admin"],
    });

    expect(body).toBe(
      "⚠️ @unauthorized-user is not authorized to apply `BreakingChange-Approved-Benign`. Label removed.\n\n" +
        "Please follow the **Next Steps to Merge** comment on this PR and the " +
        "[review and merge process](https://aka.ms/azsdk/specreview/merge).\n\n" +
        "<details><summary>See allowed approvers</summary>\n\n" +
        "Only [user1](https://github.com/user1), [user2](https://github.com/user2), " +
        "[global-admin](https://github.com/global-admin) can apply this label.\n\n</details>",
    );
  });
});

describe("buildApprovalResetComment (#46786)", () => {
  it("names the reset languages and asks for re-approval", () => {
    const body = buildApprovalResetComment({ resetLanguages: ["java", "python"] });

    expect(body).toContain(
      "Approvals for java, python were cleared because the package name changed, and must be re-applied.",
    );
    expect(body).toContain("`package-name-<language>-approved`");
  });

  it("mentions the prior approvers when known", () => {
    const body = buildApprovalResetComment({
      resetLanguages: ["dotnet"],
      approvers: ["JoshLove-msft"],
    });

    expect(body.startsWith("⚠️ @JoshLove-msft ")).toBe(true);
  });

  it("omits mentions when no approver is known", () => {
    const body = buildApprovalResetComment({ resetLanguages: ["go"], approvers: [] });

    expect(body.startsWith("⚠️ Approvals for go ")).toBe(true);
    expect(body).not.toContain("@");
  });
});
