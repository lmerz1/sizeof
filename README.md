# sizeof
A single command to determine the size of a file or directory, with user-friendly, uniform output.


## Usages

```
sizeof path/to/file-or-dir
si path/to/file-or-dir
sof path/to/file-or-dir
```

These aliases can of course be adapted to your liking.


## Example outputs

```
$ si some-file
86 kB
$ si ..
264 MB
$ si $HOME/Pictures
2,9 GB
```

Notably, using si without arguments will default to calculating the size of the current directory.

Also, I haven't bothered to test, but the decimal character from the last example is probably locale-dependent (whatever your implementation of the internally used `du` does is used)


## How to get
Add sizeof.sh to your path (e.g. `export PATH="$HOME/scripts:$PATH"` as an executable, and an alias like the following

```
# sizeof lies in $HOME/scripts
alias si="sizeof.sh"
alias sof="sizeof.sh"
alias sizeof="sizeof.sh"
```

into your .\{ba,z\}shrc* file.

\*May work for more shells, but this has not been tested. 
In particular, the currently used `function` keyword is not POSIX-compliant.


## Options

You can set the "unit" to be multiples of 1000 or 1024 (Kilo/Mega/Giga/etc. vs. Kibi/Mebi/Gibi/etc.) by changing the value of the code's first variable ("default") or passing an optional argument.

```
$ si some-dir
264 MB  # uses default of 1000
$ si some-dir 1024
252 MiB
```

Abbreviated values for decimal/binary bases follow the symbols used [here](https://en.wikipedia.org/wiki/Byte#Multiple-byte_units): kB, MB, GB, …; KiB, MiB, GiB, …

