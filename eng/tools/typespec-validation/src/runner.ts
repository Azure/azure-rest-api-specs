import pc from "picocolors";

export class TaskRunner {
  #verbose: boolean;

  constructor(options: { verbose?: boolean } = {}) {
    this.#verbose = options.verbose === undefined ? Boolean(process.env.CI) : options.verbose;
  }

  reportTaskWithDetails(status: "pass" | "fail" | "skip", name: string, details: string) {
    const statusStr =
      status === "pass" ? pc.green("pass") : status === "fail" ? pc.red("fail") : pc.gray("skip");
    const message = `${statusStr} ${name}`;
    if (this.#verbose || status === "fail") {
      this.group(message, details);
    } else {
      console.log(message);
    }
  }

  group(name: string, content: string) {
    if (process.env.GITHUB_ACTIONS) {
      console.log(`::group::${name}`);
      console.log(content);
      console.log("::endgroup::");
    } else {
      console.group(name);
      console.log(content);
      console.groupEnd();
    }
  }
}
