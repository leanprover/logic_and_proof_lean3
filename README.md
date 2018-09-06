Logic and Proof
---------------

Built using Sphinx and restructured text. Also requires `convert` (https://imagemagick.org) for image conversion.

# How to build

The build requires python 3 (install `python3-venv` on ubuntu).

```
make install-deps
make images
make html
make latexpdf
```

The call to `make install-deps` is only required the first time, and only if you want to use the bundled version of Sphinx and Pygments with improved syntax highlighting for Lean.

The call to `make images` is also only required the first time, or if you add new latex source to `latex_images` after that.

# How to test the Lean code snippets

```
make leantest
```

# How to deploy

```
./deploy.sh leanprover logic_and_proof
```

# How to contribute

Pull requests with corrections are welcome. Please follow our `commit conventions <https://github.com/leanprover/lean/blob/master/doc/commit_convention.md>`. If you have questions about whether a change will be considered helpful, please contact Jeremy Avigad, ``avigad@cmu.edu``.