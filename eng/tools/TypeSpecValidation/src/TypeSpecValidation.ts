#!/usr/bin/env node

import {exec} from "child_process";
import fs from "fs";
import path from "path";
import {simpleGit} from 'simple-git';

async function runCmd(cmd:string, cwd:string) {
    console.log(`run command:${cmd}`)
    const { err, stdout, stderr } = await new Promise((res) =>
        exec(
        cmd,
        { encoding: "utf8", maxBuffer: 1024 * 1024 * 64, cwd: cwd},
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
    
async function main() {
    const args = process.argv.slice(2);
    const folder = args[0];
    console.log("Running TypeSpecValidation on folder:", folder);
    if (fs.existsSync(path.join(folder, "main.tsp"))) {
        const output = await runCmd(
            `npx --no tsp compile . --warn-as-error`,
            folder
        );
    }
    if (fs.existsSync(path.join(folder, "client.tsp"))) {
        const output = await runCmd(
            `npx --no tsp compile client.tsp --no-emit --warn-as-error`,
            folder
        );
    }

    let expected_npm_prefix = process.env.PWD
    const actual_npm_prefix = await runCmd(`npm prefix`, folder)
    if (expected_npm_prefix !== actual_npm_prefix) {
        console.log("ERROR: TypeSpec folders MUST NOT contain a package.json, and instead MUST rely on the package.json at repo root.")
        throw new Error ("Expected npm prefix: $expected_npm_prefix\nActual npm prefix: $actual_npm_prefix\n")
    }

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

main();
