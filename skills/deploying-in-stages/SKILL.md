---
name: deploying-in-stages
description: Use when a merged change or new release must reach a deployed environment, including bumping a version pin, image tag, or config bundle in a deployment repository
---

# Deploying in Stages

## Overview

One deployment PR per component.
Verify the artifact before moving a pin.
Deploy to staging before production, and to production in a quiet window.

## Steps

1. **Reuse the open deployment PR.**
   Search the deployment repository for an open PR that already changes this component's version (`gh pr list --state open --search <component>`).
   Update its pin, title, and description to the new version.
   Never leave two open PRs that move the same pin.
   If you cannot push to its branch, open a replacement, then close the old PR with a comment linking the replacement.
2. **Artifact first.**
   Wait for the release build.
   Pin an immutable tag or digest that exists.
3. **Staging.**
   Deploy, then check readiness, new errors in the logs, and the behavior the release was for.
   Keep new errors separate from pre-existing ones.
4. **Production needs an explicit go-ahead** unless your human partner already named production.
   "Deploy it" covers staging and preparing production.
   Ask once, with the staging evidence.
5. **Quiet window.**
   Before restarting production, check for active users, jobs, or requests.
   If work is in flight, wait for it to drain or schedule the restart.
   Never cut active work without saying so first.
6. **Verify production.**
   The deployed version matches the pin, health checks pass, and logs stay clean over a window, not a single glance.
7. **Report** the version per environment, downtime, user impact, and anything still open.

## Red Flags

| Thought | Reality |
|---|---|
| "The existing PR pins an old version, so I'll open a fresh one" | Update the existing PR. Two PRs moving one pin cause conflicting deploys. |
| "The tag is pushed, so the image exists" | Check the build finished and the image is pullable. |
| "Staging looked fine at a glance" | Check logs over a window, and check the feature itself. |
| "Users can retry their jobs" | Ask before interrupting active work. |
