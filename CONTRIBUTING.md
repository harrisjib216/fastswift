# Contributing

The catalog is only as good as its evidence, so the most useful contributions are corrections:

- **A newer benchmark** that changes a verdict or a tier, especially one run on a current OS and Swift version.
- **A default that caught up**: Apple shipped something that closes the gap.
- **A wrong number, a dead link, or a quote that no longer appears on its page.** `catalog verify` finds most of
  these.
- **A new entry** with published numbers against a default.

## Adding or changing an entry

1. Edit or add a record in `data/entries/`. The fields are described in [docs/schema.md](docs/schema.md).
2. Every number in `claimed_speedup` must appear in an `evidence` quote, copied exactly from the page at that quote's
   URL. Mark anything you computed, such as a ratio, "(derived from page data)".
3. Record when and where it was measured: the date, device, OS, Swift or Xcode version, and whether it was a release
   build. A benchmark against a default that has since been rewritten belongs in `caveats`.
4. Run the tools and commit the rendered output with your change:

   ```sh
   swift run --package-path tools catalog check
   swift run --package-path tools catalog verify
   swift run --package-path tools catalog render
   ```

## What doesn't belong

- Libraries with no performance claim. They may be good, but this catalog is about speed against a default.
- Benchmarks you ran yourself and haven't published. Publish them first (a gist or a repository with the code), then
  cite them.
