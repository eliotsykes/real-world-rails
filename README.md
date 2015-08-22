# Real World Rails

> Real World Rails applications and their open source codebases for developers to learn from

Learn from Rails apps written by experienced developers.

This project helps with my efforts coaching Rails developers and researching the articles I publish for them. Find out more at https://eliotsykes.com

You&rsquo;ll find the source code for the Real World Rails apps in the [`apps/`](apps/) subdirectory.

The [inspectors](lib/real_world_rails/inspectors) are responsible for the analysis of the Rails apps.

If you've got an idea for something that'd be interesting or fun to find out about these Real World Rails apps, [contribute your idea on the issue tracker](https://github.com/eliotsykes/real-world-rails/issues) or write your own inspector, contributions welcome! &mdash; [_Eliot Sykes_](https://eliotsykes.com)

## How to install on your computer

```bash
# Clone this git repo:
git clone git@github.com:eliotsykes/real-world-rails.git

cd real-world-rails/

# The Rails apps are linked to as git submodules.
# This will take some time...
git submodule update --init  

# To run the `bin/rwr` inspectors, install gems:
bundle install

echo "All done! Why not run some inspections? Run bin/rwr"
```

## How you can analyze Real World Rails apps

### List models from *every* Real World Rails application

Interested in seeing how your fellow developers name their models? Run:

```bash
bin/rwr models | sort -f | uniq -c | sort -k 1nr -k 2f
```

### Show constants of every Real World Rails app

```bash
bin/rwr constants
```
(this helped when researching [Magic Numbers in Ruby & How You Make Them Disappear](https://eliotsykes.com/magic-numbers))

### Show view specs

See the file path and source of every view spec in every app:
```bash
bin/rwr view-specs
```

### Show model methods

See just the model method names and file paths:
```bash
bin/rwr model-method-names
```

See the model method source and file paths:
```bash
bin/rwr model-methods
```

## Settings

### Analyzing directories outside of `apps/`

Prefix the `bin/rwr` command with the `FILES_PATTERN` environment variable:

```bash
FILES_PATTERN=~/dev/my-rails-app/**/*.rb bin/rwr
```

### Change source output format to markdown

Prefix `bin/rwr` with the `SOURCE_OUTPUT_FORMAT` environment variable:
```bash
SOURCE_OUTPUT_FORMAT=markdown bin/rwr view-specs
```

## How to add a Real World Rails app

Given a GitHub repo for a Rails app `githubuser/foo`:

```bash
# Inside real-world-rails root:
git submodule add -b master git@github.com:githubuser/foo.git apps/foo
```

## Updating the Rails apps submodules to latest

The Rails apps in `apps/` are git submodules. Git submodules are locked to a revision and don't stay in sync with the latest revision.

To update the revisions, run:

```bash
#git pull --recurse-submodules # Probably not needed, try without.
# This will take some time:
git submodule foreach git pull origin master
```

## Writing an Inspector? Some docs to help understand AST, Parser&hellip;

Review the existing [inspectors](lib/real_world_rails/inspectors) if you're looking for some info on how to write a new one, and see these API docs:

- http://whitequark.github.io/ast/AST/Node.html
- http://www.rubydoc.info/github/whitequark/parser/master/Parser/AST/Processor
- http://whitequark.github.io/ast/AST/Processor.html


# Contributors

- Eliot Sykes https://eliotsykes.com/
- Contributions are welcome, fork the GitHub repo, make your changes, then submit your pull request! Reach out if you'd like some help.
