```
              ,;###GGGGGGGGGGl#Sp
           ,##GGGlW""^'  '`""%GGGG#S,
         ,#GGG"                  "lGG#o
        #GGl^                      '$GG#
      ,#GGb                          \GGG,
      lGG"                            "GGG
     #GGGlGGGl##p,,p##lGGl##p,,p###ll##GGGG
    !GGGlW"""*GGGGGGG#""""WlGGGGG#W""*WGGGGS
     ""          "^          '"          ""


                @GGS         lG#
                !GGG        !GGG
                !GGG        !GGG
                !GGG        !GGG
                !GGG        !GGG
                !GGG        !GGG
                'GGG        $GGl
                 "GGG#psqp##GG#
                   "%GGGGGG#"
```

# ☂️ umbrel-dev

Automatically initialize and manage an Umbrel development environment.

## Install

### Homebrew

```
brew install lukechilds/tap/umbrel-dev
```

### Git

```
git clone https://github.com/getumbrel/umbrel-dev.git ~/.umbrel-dev
```

Then add to your shell profile:

```shell
export PATH="$PATH:$HOME/.umbrel-dev/bin"
```

## Usage

```
$ umbrel-dev
umbrel-dev 0.1.0

Automatically initialize and manage an Umbrel development environment.

Usage: umbrel-dev <command> [options]

Commands:
    help                    Show this help message
    init                    Initialize an Umbrel development environment in the working directory
    boot                    Boot the development VM
    halt                    Halt the development VM
    destroy                 Destroy the development VM
    containers              List container services
    rebuild <container>     Rebuild a container service
    logs                    Stream Umbrel logs
    run <command>           Run a command inside the development VM
    ssh                     Get an SSH session inside the development VM
```

## License

MIT © Luke Childs
