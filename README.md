# Real World Rails

> Real World Rails applications and their open source codebases for developers to learn from

https://eliotsykes.com/real-world-rails

## Installation

1. Clone this git repo
2. `cd real-world-rails/`
3. Clone the git submodules in `real-world-rails/apps/` using the git submodule command (TODO: add exact command)
4. `bundle install`


## List models from *every* Real World Rails application

Interested in seeing how your fellow developers name their models? Run:

```bash
bin/rwr models | sort -f | uniq -c | sort -k 1nr -k 2f
```

## Show constants of every Real World Rails app

```bash
bin/rwr constants
```

## Adding a Real World Rails app

Given a GitHub repo for a Rails app `githubuser/foo`:

```bash
# Inside real-world-rails root:
git submodule add -b master git@github.com:githubuser/foo.git apps/foo
```


## Docs to help understand AST, Parser

- http://whitequark.github.io/ast/AST/Node.html
- http://www.rubydoc.info/github/whitequark/parser/master/Parser/AST/Processor
- http://whitequark.github.io/ast/AST/Processor.html
