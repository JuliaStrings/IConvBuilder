using BinaryBuilder

# Collection of sources required to build libiconv
sources = [
    "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz" =>
    "ccf536620a45458d26ba83887a983b96827001e92a13847b45e4925cc8913178",
]

script = raw"""
cd $WORKSPACE/srcdir
cd libiconv-1.15/
./configure --prefix=$prefix --host=${target}
make -j${nproc}
make install
"""

# These are the platforms we will build for by default, unless
# further platforms are passed in on the command line
platforms = supported_platforms()

# The products that we will ensure are always built
products = prefix -> [
    LibraryProduct(prefix,"libcharset",:libcharset),
    LibraryProduct(prefix,"libiconv",:libiconv),
    ExecutableProduct(prefix,"iconv",:iconv)
]

# Dependencies that must be installed before this package can be built
dependencies = [
]

build_tarballs(ARGS, "IConv", sources, script, platforms, products, dependencies)
