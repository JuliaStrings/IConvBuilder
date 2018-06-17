# IConvBuilder

[![Build Status](https://travis-ci.org/JuliaStrings/IConvBuilder.svg?branch=master)](https://travis-ci.org/JuliaStrings/IConvBuilder)

This repository builds binary artifacts for the libiconv project. Binary artifacts are automatically uploaded to
[this repository's GitHub releases page](https://github.com/JuliaStrings/IConvBuilder/releases) whenever a tag is created
on this repository.

This repository was created using [BinaryBuilder.jl](https://github.com/JuliaPackaging/BinaryBuilder.jl)

The release tags we use have the form ``v1.15+build.2``. The part before the ``+`` refers to the upstream version of libiconv, the part after the ``+`` refers to new builds on the end of IConvBuilder.
