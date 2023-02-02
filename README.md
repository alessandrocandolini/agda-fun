# agda-fun

## Installation 

If using `nix`, there's a `shell.nix` file provided for an ephemeral nix shell, just run
```bash
nix-shell
```
Be careful, it installs GHC. Agda is ~100k lines of Haskell code! A proof assistant is a lot of work :)

Alternatively, on macos it's possible to install agda via homebrew:
```bash
brew install agda
``` 

## Compile
```bash
agda --compile Talk.agda
```
will generate a `./Talk` executable that should print `green` as output. 

To use the standard library, place a file `~/.agda/defaults` with the following content
```
standard-library
```

If it still cannot find the standard library, try to provide it explicitly (I had to do this when installing with homebrew):
```bash
agda --include-path=/opt/homebrew/Cellar/agda/2.6.2.2_1/lib/agda/src --compile talk.agda
```

## How to fail installing the Agda compiler!!


