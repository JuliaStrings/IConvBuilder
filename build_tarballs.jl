using BinaryBuilder

# These are the platforms built inside the wizard
platforms = [
    BinaryProvider.Linux(:i686, :glibc),
  BinaryProvider.Linux(:x86_64, :glibc),
  BinaryProvider.Linux(:aarch64, :glibc),
  BinaryProvider.Linux(:armv7l, :glibc),
  BinaryProvider.Linux(:powerpc64le, :glibc),
  BinaryProvider.MacOS(),
  BinaryProvider.Windows(:i686),
  BinaryProvider.Windows(:x86_64)
]


# If the user passed in a platform (or a few, comma-separated) on the
# command-line, use that instead of our default platforms
if length(ARGS) > 0
    platforms = platform_key.(split(ARGS[1], ","))
end
info("Building for $(join(triplet.(platforms), ", "))")

# Collection of sources required to build libiconv
sources = [
    "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz" =>
    "ccf536620a45458d26ba83887a983b96827001e92a13847b45e4925cc8913178",
]

script = raw"""
cd $WORKSPACE/srcdir
cd libiconv-1.15/
./configure --prefix=/ --host=$target
make
make install

"""

products = prefix -> [
    LibraryProduct(prefix,"libcharset"),
    LibraryProduct(prefix,"libiconv"),
    ExecutableProduct(prefix,"iconv")
]


# Build the given platforms using the given sources
hashes = autobuild(pwd(), "libiconv", platforms, sources, script, products)

if !isempty(get(ENV,"TRAVIS_TAG",""))
    print_buildjl(pwd(), products, hashes,
        "https://github.com/davidanthoff/IConvBuilder/releases/download/$(ENV["TRAVIS_TAG"])")
end

