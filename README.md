# sizeof
A single command to get the size of a file or directory, with a friendly uniform output.


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

Also, I haven't bothered to test, but the decimal character from the last example is probably locale-dependent (whatever your implementation of the internally used `du` does)

## How to get
Paste the code block in code.sh into your .\{ba,z\}shrc* file.

*May work for more shells, but this has not been tested. 
In particular, my current use of the `function` keyword is not POSIX-compliant.

# Todos

Formatting is off both for files as well as folders that are empty:

```
$ mkdir tmpdir
$ touch tmpfile
$ si tmpdir 
0 BB
$ si tmpfile
0  B
```
