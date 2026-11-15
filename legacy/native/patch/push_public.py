#!/usr/bin/env python3
"""把一组本地文件作为一次 commit 推到公开仓库 MyCode-share。

本机代理只放行 api.github.com,github.com 的 git smart HTTP 会 502,
所以 `git push` 走不通,这里走 REST Git Data API:
    blob -> tree(带 base_tree 保留已有文件) -> commit -> 更新 ref

token 只从 GH_TOKEN 环境变量读,不落盘、不打印。
用法: GH_TOKEN=... python push_public.py <待推送目录>
"""
import base64
import datetime
import json
import os
import pathlib
import sys
import time
import urllib.error
import urllib.request

ROOT = pathlib.Path(sys.argv[1])
REPO = "MyCodeHasBugs/MyCode-share"
BRANCH = "main"
API = "https://api.github.com"
P = "/repos/" + REPO
TOKEN = os.environ.get("GH_TOKEN", "")
if not TOKEN:
    sys.exit("GH_TOKEN 未设置")
COMMIT_MSG = sys.argv[2] if len(sys.argv) > 2 else "feat: 旧版 Keeper 反编译修补流水线 (公开仓库构建)"


def call(method, path, payload=None, timeout=300):
    body = json.dumps(payload, ensure_ascii=False).encode("utf-8") if payload is not None else None
    last = ""
    for attempt in range(3):
        req = urllib.request.Request(
            API + path,
            data=body,
            method=method,
            headers={
                "Authorization": "Bearer " + TOKEN,
                "Accept": "application/vnd.github+json",
                "Content-Type": "application/json",
                "User-Agent": "keeper-legacy-push/1.0",
                "X-GitHub-Api-Version": "2022-11-28",
            },
        )
        try:
            with urllib.request.urlopen(req, timeout=timeout) as resp:
                raw = resp.read()
                return json.loads(raw) if raw else {}
        except urllib.error.HTTPError as exc:
            last = "%s %s" % (exc.code, exc.read().decode("utf-8", "replace")[:400])
            if exc.code not in (429, 500, 502, 503, 504):
                break
            time.sleep(2 * (attempt + 1))
        except Exception as exc:
            last = "%s: %s" % (type(exc).__name__, exc)
            time.sleep(2 * (attempt + 1))
    sys.exit("API 失败 %s %s -> %s" % (method, path, last))


def main():
    ref = call("GET", P + "/git/refs/heads/" + BRANCH)["object"]["sha"]
    base_tree = call("GET", P + "/git/commits/" + ref)["tree"]["sha"]
    print("远端 HEAD =", ref, "| base tree =", base_tree[:7], flush=True)

    files = sorted(p for p in ROOT.rglob("*") if p.is_file())
    print("待上传文件 =", len(files), flush=True)
    entries = []
    for f in files:
        rel = f.relative_to(ROOT).as_posix()
        data = f.read_bytes()
        blob = call(
            "POST",
            P + "/git/blobs",
            {"content": base64.b64encode(data).decode("ascii"), "encoding": "base64"},
        )
        entries.append({"path": rel, "mode": "100644", "type": "blob", "sha": blob["sha"]})
        print("  %-58s %9d B -> %s" % (rel, len(data), blob["sha"][:7]), flush=True)

    tree = call("POST", P + "/git/trees", {"base_tree": base_tree, "tree": entries})
    print("新 tree =", tree["sha"][:7], flush=True)

    now = datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    who = {"name": "MyCodeHasBugs", "email": "15809879275@163.com", "date": now}
    commit = call(
        "POST",
        P + "/git/commits",
        {
            "message": COMMIT_MSG,
            "tree": tree["sha"],
            "parents": [ref],
            "author": who,
            "committer": who,
        },
    )
    call("PATCH", P + "/git/refs/heads/" + BRANCH, {"sha": commit["sha"], "force": False})
    print("新 HEAD =", commit["sha"], flush=True)

    check = call("GET", P + "/git/trees/" + tree["sha"] + "?recursive=1")
    paths = {x["path"] for x in check.get("tree", []) if x["type"] == "blob"}
    missing = [e["path"] for e in entries if e["path"] not in paths]
    print("校验: 树内 blob =", len(paths), "| 缺失 =", missing or "无", flush=True)
    print("仓库: https://github.com/" + REPO, flush=True)


if __name__ == "__main__":
    main()
