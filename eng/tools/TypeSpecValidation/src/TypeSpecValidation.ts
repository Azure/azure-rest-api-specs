import { exec } from "child_process";
import { access } from "fs/promises"
import { parseArgs, ParseArgsConfig } from 'node:util';
import path from "path";
import { simpleGit } from 'simple-git';

async function runCmd(cmd: string, cwd: string) {
    console.log(`run command:${cmd}`)
    const { err, stdout, stderr } = await new Promise((res) =>
        exec(
            cmd,
            { encoding: "utf8", maxBuffer: 1024 * 1024 * 64, cwd: cwd },
            (err: unknown, stdout: unknown, stderr: unknown) =>
                res({ err: err, stdout: stdout, stderr: stderr })
        )
    ) as any;
    let resultString = stderr + stdout;
    console.log("Stdout output:")
    console.log(stdout)
    if (stderr) {
        console.log("Stderr output:")
        console.log(stderr)
    }
    if (stderr || err) {
        throw new Error(err);
    }
    return resultString as string;
}

async function checkFileExists(file: string) {
    return access(file)
        .then(() => true)
        .catch(() => false)
}

export async function main() {
    const args = process.argv.slice(2);
    const options = {
        folder: {
            type: 'string',
            short: 'f',
        },
    };
    const parsedArgs = parseArgs({ args, options, allowPositionals: true } as ParseArgsConfig);
    const folder = parsedArgs.positionals[0];
    console.log("Running TypeSpecValidation on folder:", folder);

    // Verify all specs are using root level pacakge.json
    let expected_npm_prefix = process.cwd()
    const actual_npm_prefix = (await runCmd(`npm prefix`, folder)).trim()
    if (expected_npm_prefix !== actual_npm_prefix) {
        console.log("ERROR: TypeSpec folders MUST NOT contain a package.json, and instead MUST rely on the package.json at repo root.")
        throw new Error("Expected npm prefix: " + expected_npm_prefix + "\nActual npm prefix: " + actual_npm_prefix)
    }

    // Spec compilation check
    if (await checkFileExists(path.join(folder, "main.tsp"))) {
        await runCmd(
            `npx --no tsp compile . --warn-as-error`,
            folder
        );
    }
    if (await checkFileExists(path.join(folder, "client.tsp"))) {
        await runCmd(
            `npx --no tsp compile client.tsp --no-emit --warn-as-error`,
            folder
        );
    }

    // Format parent folder to include shared files
    await runCmd(
        `npx tsp format ../**/*.tsp`,
        folder
    );

    // Verify generated swagger file is in sync with one on disk
    const git = simpleGit();
    let gitStatusIsClean = await (await git.status(['--porcelain'])).isClean()
    if (!gitStatusIsClean) {
        let gitStatus = await git.status()
        let gitDiff = await git.diff()
        console.log("git status")
        console.log(gitStatus)
        console.log("git diff")
        console.log(gitDiff)
        throw new Error("Generated swagger file does not match swagger file on disk")
    }
}
